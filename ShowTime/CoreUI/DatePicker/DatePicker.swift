//
//  DatePicker.swift
//  ShowTime
//
//  Created by Miguel Solans on 15/10/2022.
//

import UIKit

protocol DatePickerDelegate {
    func didClickSave(_ picker: DatePicker, with date: Date);
}

class DatePicker : UIView {
    
    
    var delegate: DatePickerDelegate?
    
    let datePicker = UIDatePicker();
    let placeholderLabel = UILabel();
    let saveButton = UIButton(type: .system);
    
    var placeholderLabelCenterYConstraint: NSLayoutConstraint?
    var placeholderLabelTopConstraint: NSLayoutConstraint?
    
    fileprivate var shouldShowPicker : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setupGesture();
    }
    
    func initPicker(withLabel label: String) {
        self.placeholderLabel.text = label;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        style()
        layout();
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPickerGesture));
        self.addGestureRecognizer(tapGesture);
    }
    
    override var intrinsicContentSize: CGSize {
        return self.shouldShowPicker ? CGSize(width: self.frame.width, height: 250) : CGSize(width: self.frame.width, height: 40);
    }
    
    private func style() {
        // backgroundColor = .red
        
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false;
        self.datePicker.preferredDatePickerStyle = .wheels;
        self.datePicker.datePickerMode = .date;
        self.datePicker.isHidden = true;
        
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal);
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside);
        self.saveButton.isHidden = true;
        
    }
    
    private func layout() {
        
        self.addSubview(placeholderLabel);
        self.addSubview(datePicker);
        self.addSubview(saveButton);
        
        self.initConstraints();
        
    }
    
    private func initConstraints() {
        
        self.placeholderLabelCenterYConstraint = self.placeholderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor);
        self.placeholderLabelTopConstraint = self.placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2);
        
        NSLayoutConstraint.activate([
            self.placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4),
            self.placeholderLabelCenterYConstraint!,
            
            self.saveButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.saveButton.widthAnchor.constraint(equalToConstant: 40),
            self.saveButton.heightAnchor.constraint(equalToConstant: 40),
            self.saveButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            
            self.datePicker.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 4),
            self.datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4),
            self.datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4),
            
        ]);
    }
    
}

// MARK: - Actions
extension DatePicker {
    @objc func saveButtonTapped() {
        let selectedDate = self.datePicker.date;
        
        self.openPickerGesture();
        
        self.delegate?.didClickSave(self, with: selectedDate);
        
        self.placeholderLabel.text = selectedDate.getFormattedDate()
    }
    
    @objc func openPickerGesture() {
        self.shouldShowPicker = !self.shouldShowPicker;
        
        self.datePicker.isHidden = !self.shouldShowPicker;
        self.saveButton.isHidden = !self.shouldShowPicker;
        self.placeholderLabelTopConstraint?.isActive = self.shouldShowPicker;
        self.placeholderLabelCenterYConstraint?.isActive = !self.shouldShowPicker;
        
        
        UIView.animate(withDuration: 0.2, animations: {
            self.invalidateIntrinsicContentSize();
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        })
    }
}
