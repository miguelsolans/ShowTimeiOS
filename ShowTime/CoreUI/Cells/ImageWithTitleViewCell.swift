//
//  ImageWithTitleViewCell.swift
//  ShowTime
//
//  Created by Miguel Solans on 01/11/2022.
//

import Foundation
import UIKit

class ImageWithTitleViewCell : UICollectionViewCell {
    
    let imageView = UIImageView()
    let titleLabel = UILabel();
    let titleView = UIView();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.style()
        self.layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}


extension ImageWithTitleViewCell {
    func style() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.titleView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.titleView.backgroundColor = .white;
        
    }
    
    func layout() {
        self.addSubview(imageView);
        self.addSubview(titleView);
        self.titleView.addSubview(titleLabel);
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.titleView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -4),
            self.titleView.heightAnchor.constraint(equalToConstant: 40),
            self.titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.titleView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            self.titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor)
        ]);
    }
}
