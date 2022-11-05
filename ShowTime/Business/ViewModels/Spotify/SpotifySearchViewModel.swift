//
//  SpotifySearchViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 01/11/2022.
//

import Foundation

protocol SpotifySearchViewModelDelegate {
    func spotifySearchOutputDidChange(_ viewModel: SpotifySearchViewModel);
}

class SpotifySearchViewModel {
    let model = ArtistSpotifySearchModel();
    var delegate: SpotifySearchViewModelDelegate?
    
    func search(artist name: String) {
        model.getAll(artist: name) { output in
            self.spotifySearchOutput = output;
        } failure: { error in
            // TODO: Handle Error
        }
    }
    
    
    var spotifySearchOutput: ArtistSpotifySearchOutput? {
        didSet {
            self.delegate?.spotifySearchOutputDidChange(self);
        }
    }
}
