//
//  VenueViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 16/10/2022.
//

import Foundation

protocol VenueViewModelDelegate {
    func venuesOutputDidChange(_ viewModel: VenueViewModel);
}

class VenueViewModel {
    let model = VenueModel();
    var delegate: VenueViewModelDelegate?;
    
    func getAll() {
        self.model.getAll { output in
            self.venuesOutput = output;
        } failure: { error in
            
            
        }

    }
    
    var venuesOutput: [VenueOutput]? {
        didSet {
            self.delegate?.venuesOutputDidChange(self)
        }
    }
    
    
    
}
