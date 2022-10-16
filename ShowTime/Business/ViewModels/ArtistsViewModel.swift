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
    func artistOutputDidChange(_ viewModel: ArtistsViewModel);
    func artistErrorDidChange(_ viewModel: ArtistsViewModel);
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
    
    func createArtist(_ artist: ArtistInput) {
        self.model.createArtist(artist) { output in
            self.artistOutput = output;
        } failure: { error in
            self.artistError = error;
        }
    }
    
    
    func getArtistByIndex(_ index: Int) -> ArtistOutput? {
        self.artistsOutput?[index];
    }
    
    
    var artistOutput: ArtistOutput? {
        didSet {
            self.delegate?.artistOutputDidChange(self)
        }
    }
    
    var artistError: Error? {
        didSet {
            self.delegate?.artistErrorDidChange(self);
        }
    }
    
    var artistsOutput: [ArtistOutput]? {
        didSet {
            self.delegate?.artistsOutputDidChange(self)
        }
    }
    var artistsError: Error? {
        didSet {
            self.delegate?.artistsErrorDidChange(self);
        }
    }
}
