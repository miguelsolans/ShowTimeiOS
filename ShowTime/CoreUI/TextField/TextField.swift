//
//  TextField.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/10/2022.
//

import UIKit

class TextField : UIView {
    
    let textField = UITextField();
    let placeholderLabel = UILabel();
    
    var placeholder: String?
    
    // Constraints
    var placeholderLeftConstraint: NSLayoutConstraint!;
    var placeholderRightConstraint: NSLayoutConstraint!;
    var placeholderTopConstraint: NSLayoutConstraint!;
    var placeholderBottomConstraint: NSLayoutConstraint!;
    
    required init(placeholder: String){
        self.placeholder = placeholder;
        super.init(frame: CGRect.zero)
        
        self.setupGestures();
        self.style();
        self.layout(); 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func style() {
        self.layer.borderColor = UIColor.gray.cgColor;
        self.layer.borderWidth = 0.6;
        self.layer.cornerRadius = 4;
        self.clipsToBounds = false;
        
        self.placeholderLabel.text = self.placeholder;
        self.placeholderLabel.font = UIFont.systemFont(ofSize: 15);
        
        self.textField.placeholder = "";
        self.textField.font = UIFont.systemFont(ofSize: 15);
        self.textField.translatesAutoresizingMaskIntoConstraints = false;
        self.textField.delegate = self;
        
        
        self.placeholderLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    fileprivate func layout() {
        self.addSubview(textField);
        self.addSubview(placeholderLabel);
        
        
        // TextField Constraints
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]);
        
        // Placeholder Constraints
        self.placeholderLeftConstraint = self.placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        self.placeholderRightConstraint = self.placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        self.placeholderTopConstraint = self.placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor)
        self.placeholderBottomConstraint = self.placeholderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor);
        
        NSLayoutConstraint.activate([placeholderLeftConstraint, placeholderRightConstraint,
                                     placeholderTopConstraint, placeholderBottomConstraint])
        
    }
    
    func setupGestures() {
        // User clicks the TextField View
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture);
        
        self.placeholderLabel.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Gestures
fileprivate extension TextField {
    
    
    @objc func handleTap() {
        self.movePlaceholderUp()
    }
}

// MARK: - Animations
fileprivate extension TextField {
    func movePlaceholderUp() {
        
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 0.80, y: 0.80).translatedBy(x: -45, y: -15)
        }
        
    }
    func movePlaceholderDown() {
        UIView.animate(withDuration: 0.25) {
            self.placeholderLabel.transform = CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 0, y: 0)
        }
    }
}

// MARK: - UITextField Delegate Methods
extension TextField : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(isEmtpy()) {
            self.movePlaceholderDown();
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO: Animate placeholder
        self.movePlaceholderUp();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.movePlaceholderDown();
        self.textField.resignFirstResponder();
        return true;
    }
}

// MARK: - Getters and Setters
extension TextField {
    func getText() -> String {
        return self.textField.text ?? "";
    }
    
    func isEmtpy() -> Bool {
        return self.textField.text == nil;
    }
}
