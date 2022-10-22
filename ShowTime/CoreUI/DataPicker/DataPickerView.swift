//
//  DataPickerView.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import UIKit

protocol DataPickerViewDelegate : AnyObject {
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: DataPickerOption);
}

class DataPickerView: UIView {

    // ViewControllers and Delegates
    weak var rootViewController: UIViewController!
    weak var delegate: DataPickerViewDelegate?
    // var pickerViewController = DataPickerViewController(options: []);
    var pickerViewController: DataPickerViewController;
    fileprivate var searchbar: Bool

    
    // Properties
    var placeholder: String?
    var selectedIndex: Int?
    var options: [DataPickerOption]?;
    
    // UI Components
    let arrowImageView = UIImageView();
    let placeholderLabel = UILabel();
    let selectedOptionLabel = UILabel();
    
    
    required init(target: UIViewController, placeholder: String, withSearchBar searchbar: Bool){
        self.searchbar = searchbar
        self.pickerViewController = DataPickerViewController(options: [], andSearch: searchbar)
        self.placeholder = placeholder;
        self.rootViewController = target;
        super.init(frame: CGRect.zero)
        
        self.setupGestures();
        self.style();
        self.layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func style() {
        
        self.layer.borderColor = UIColor.gray.cgColor;
        self.layer.borderWidth = 0.6;
        self.layer.cornerRadius = 4;
        self.clipsToBounds = false;
        
        
        self.arrowImageView.image = UIImage(systemName: KCoreUI.Symbols.ArrowRight)?.withRenderingMode(.alwaysTemplate);
        self.arrowImageView.tintColor = .blue;
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.placeholderLabel.text = self.placeholder
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.selectedOptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.selectedOptionLabel.isHidden = true;
        self.selectedOptionLabel.text = "";
        
    }
    
    func layout() {
        
        self.addSubview(arrowImageView)
        self.addSubview(placeholderLabel)
        self.addSubview(selectedOptionLabel)
        
        NSLayoutConstraint.activate([
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -14),
            
            self.placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.placeholderLabel.rightAnchor.constraint(lessThanOrEqualTo: self.arrowImageView.leftAnchor, constant: 4),
            
            self.selectedOptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 2),
            self.selectedOptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.placeholderLabel.rightAnchor.constraint(lessThanOrEqualTo: self.arrowImageView.leftAnchor, constant: 4)
        ]);
        
    }
    
    func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(gesture);
    }

}

// MARK: - Gestures
extension DataPickerView {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("DataPickerView - Open Picker Action");
        
        guard let options = self.options else { return }
        
        self.pickerViewController = DataPickerViewController(options: options, andSearch: self.searchbar);
        
        self.pickerViewController.delegate = self;
        
        self.rootViewController?.present(self.pickerViewController, animated: true);
    }
}

// MARK: - Animations
extension DataPickerView {
    func movePlaceholderUp() {
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.textColor = UIColor(named: KCoreUI.Colors.AnimatedPlaceholderTextColor);
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.80, y: 0.80).translatedBy(x: 0, y: -15)
        }
    }
    
    func movePlaceholderDown() {
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.textColor = UIColor(named: KCoreUI.Colors.PlaceholderTextColor);
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 0, y: 0)
        }
    }
}

// MARK: DataPickerView
extension DataPickerView : DataPickerViewControllerDelegate {
    func didSelectOption(_ option: DataPickerOption, atIndex: Int) {
        
        self.movePlaceholderUp()
        
        self.selectedOptionLabel.text = option.label;
        self.selectedOptionLabel.isHidden = false;
        self.selectedIndex = atIndex;
        
        self.delegate?.didSelectPicker(self, withOption: option);
        self.pickerViewController.dismiss(animated: true);
        
        
    }
}
