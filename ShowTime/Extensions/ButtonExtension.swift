//
//  ButtonExtension.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/10/2022.
//

import UIKit

extension UIButton {
    func applyStyle() {
        let button = self;
        
        button.tintColor = UIColor(named: "ButtonTextColor");
        button.backgroundColor = UIColor(named: "ButtonBackgroundColor");
        button.layer.cornerRadius = 10;
        button.clipsToBounds = true;
        
    }
}
