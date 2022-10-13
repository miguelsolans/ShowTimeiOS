//
//  AddConcertViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/10/2022.
//

import UIKit

class AddConcertViewController : BaseViewController {
    
    // TODO: Artist Picker
    let datePicker = UIDatePicker();
    // TODO: Venue Picker
    let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    override func style() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false;
        datePicker.preferredDatePickerStyle = .wheels;
        datePicker.datePickerMode = .date;
        
        // Save Button
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.setTitle("Save", for: []);
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchDown)
        self.saveButton.applyStyle();
    }
    
    override func layout() {
        
        self.view.addSubview(datePicker);
        self.view.addSubview(saveButton);
        
        NSLayoutConstraint.activate([
            
            self.datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.datePicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50),
            self.saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
            
        ]);
    }
    
}


extension AddConcertViewController {
    @objc func saveButtonTapped() {
        self.navigationController?.popViewController(animated: true);
    }
}
