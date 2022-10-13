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
    let segmentedControl = UISegmentedControl(items: ["Past", "Scheduled"]);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertViewModel.delegate = self;
        
        self.concertViewModel.getConcerts();
        self.segmentedControl.selectedSegmentIndex = 0;
        
    }
    
    
    
    
    override func layout() {
        
        self.view.addSubview(segmentedControl);
        self.view.addSubview(titleLabel);
        
        NSLayoutConstraint.activate([
            
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            //self.segmentedControl.heightAnchor.constraint(equalToConstant: 20),
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]);
    }
    
    override func style() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addConcertButtonTapped));
        navigationItem.setRightBarButton(addButton, animated: true);
        
        
        self.titleLabel.isHidden = true;
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

extension ConcertHistoryViewController {
    @objc func addConcertButtonTapped() {
        // TODO: Show Form Page
        let viewController = AddConcertViewController();
        self.pushToViewController(viewController);
    }
}
