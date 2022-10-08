//
//  ArtistsViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import Foundation

protocol ArtistsViewModelDelegate {
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel);
    func artistsErrorDidChange(_ viewModel: ArtistsViewModel);
}

class ArtistsViewModel {
    let model = ArtistModel();
    var delegate: ArtistsViewModelDelegate?;
    
    
    
    func getArtists() {
        self.model.getArtists { output in
            self.artistsOutput = output;
        } failure: { error in
            // self.genresError = error;
            
        }

    }
    
    func getArtistsByGenre(_ genre: String) {
        self.model.getArtistsByGenre(genre, completion: { output in
            self.artistsOutput = output;
        }, failure: { error in
            
        });
    }
    
    
    
    var artistsOutput: [ArtistOutput]? {
        didSet {
            self.delegate?.artistsOutputDidChange(self)
        }
    }
    var genresError: NSError? {
        didSet {
            self.delegate?.artistsErrorDidChange(self);
        }
    }
}
