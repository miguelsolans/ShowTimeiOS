//
//  TwoLabelTableViewCell.swift
//  ShowTime
//
//  Created by Miguel Solans on 30/10/2022.
//

import UIKit

class TwoLabelTableViewCell: UITableViewCell {
    
    var titleImageView = UIImageView();
    var titleLabel = UILabel();
    
    var subtitleImageView = UIImageView();
    var subtitleLabel = UILabel();
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.style();
        self.layout();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    
    fileprivate func style() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        self.titleImageView.translatesAutoresizingMaskIntoConstraints = false;
        self.titleImageView.tintColor = UIColor(named: KCoreUI.Colors.InactiveMenuColor)
        self.subtitleImageView.translatesAutoresizingMaskIntoConstraints = false;
        self.subtitleImageView.tintColor = UIColor(named: KCoreUI.Colors.InactiveMenuColor)
    }
    
    fileprivate func layout() {
        
        
        self.addSubview(titleLabel);
        self.addSubview(subtitleLabel);
        self.addSubview(titleImageView);
        self.addSubview(subtitleImageView);
        
        
        NSLayoutConstraint.activate([
            titleImageView.heightAnchor.constraint(equalToConstant: 20),
            titleImageView.widthAnchor.constraint(equalToConstant: 20),
            titleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            titleImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            titleLabel.leftAnchor.constraint(equalTo: self.titleImageView.rightAnchor, constant: 4),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4),
            
            subtitleImageView.heightAnchor.constraint(equalToConstant: 20),
            subtitleImageView.widthAnchor.constraint(equalToConstant: 20),
            subtitleImageView.topAnchor.constraint(equalTo: self.titleImageView.bottomAnchor, constant: 8),
            subtitleImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            
            subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leftAnchor.constraint(equalTo: self.titleImageView.rightAnchor, constant: 4),
            subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 4),
            
        ]);
    }
    

}
