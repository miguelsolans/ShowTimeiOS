//
//  SimpleTableViewHeader.swift
//  ShowTime
//
//  Created by Miguel Solans on 30/10/2022.
//

import UIKit

class SimpleTableViewHeader : UIView {
    
    var titleLabel = UILabel();
    var subtitleLabel = UILabel();
    
    fileprivate var stackView = UIStackView();
    
    required init(title: String, andSubtitle subtitle: String){
        super.init(frame: CGRect.zero)
        
        self.titleLabel.text = title;
        self.subtitleLabel.text = subtitle;
        
        self.style();
        self.layout();
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}

extension SimpleTableViewHeader {
    func style() {
        self.backgroundColor = UIColor(named: KCoreUI.Colors.HeaderBackgroundColor);
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false;
        self.stackView.distribution = .fillEqually;
        self.stackView.axis = .vertical;
    }
    
    func layout() {
        self.addSubview(stackView);
        self.stackView.addArrangedSubview(titleLabel);
        self.stackView.addArrangedSubview(subtitleLabel);
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
        ]);
    }
}
