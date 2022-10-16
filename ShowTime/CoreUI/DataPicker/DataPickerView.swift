//
//  DataPickerView.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import UIKit

protocol DataPickerViewDelegate : AnyObject {
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: String);
}

class DataPickerView: UIView {
    
    weak var rootViewController: UIViewController!
    weak var delegate: DataPickerViewDelegate?
    var pickerViewController = DataPickerViewController(options: []);

    let stackView = UIStackView();
    let arrowImageView = UIImageView();
    let optionLabel = UILabel();
    
    var options: [String] = [];
    
    var selectedIndex: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
        self.style()
        self.layout();
        self.setup();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    

}

extension DataPickerView {
    
    func setup() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(gesture);
    }
    
    func style() {
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = .systemTeal;
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.axis = .horizontal;
        self.stackView.distribution = .fillProportionally
        
        self.arrowImageView.image = UIImage(systemName: "arrow.right")?.withRenderingMode(.alwaysTemplate);
        self.arrowImageView.tintColor = .blue;
        
        self.optionLabel.text = NSLocalizedString("chooseOption", comment: "Picker placeholder");
        
    }
    
    func layout() {
        self.stackView.addArrangedSubview(self.optionLabel);
        self.stackView.addArrangedSubview(self.arrowImageView);
        self.addSubview(self.stackView);
        
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]);
    }
}

extension DataPickerView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("DataPickerView - Open Picker Action");
        self.pickerViewController = DataPickerViewController(options: self.options);
        
        self.pickerViewController.delegate = self;
        
        self.rootViewController?.present(self.pickerViewController, animated: true);
    }
}

extension DataPickerView : DataPickerViewControllerDelegate {
    func didSelectOption(_ option: String, atIndex: Int) {
        
        self.optionLabel.text = option;
        self.selectedIndex = atIndex;
        
        self.delegate?.didSelectPicker(self, withOption: option);
        self.pickerViewController.dismiss(animated: true);

        
    }
}
