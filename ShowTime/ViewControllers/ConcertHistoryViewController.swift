//
//  ConcertHistoryViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import UIKit

class ConcertHistoryViewController : BaseViewController {
    
    let concertViewModel = ConcertViewModel()
    let titleLabel = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertViewModel.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.concertViewModel.getConcerts();
    }
    
    override func layout() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(titleLabel);
        self.titleLabel.isHidden = true;
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
    }
    
    override func style() {
        
    }
    
}

extension ConcertHistoryViewController : ConcertViewModelDelegate {
    func concertOutputDidChange() {
        if let concerts = self.concertViewModel.concertOutput {
            if(concerts.count > 0) {
                self.titleLabel.text = concerts[ 0 ].artist.name;
                
                self.titleLabel.isHidden = false;
            }
        }
            
    }
}
