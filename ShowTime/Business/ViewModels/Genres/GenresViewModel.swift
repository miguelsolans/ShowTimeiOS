//
//  GenresViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import Foundation

protocol GenresViewModelDelegate {
    func genresOutputDidChange(_ viewModel: GenresViewModel);
    func genresErrorDidChange(_ viewModel: GenresViewModel);
}

class GenresViewModel {
    let model = GenreModel();
    var delegate: GenresViewModelDelegate?;
    
    func getGenres() {
        self.model.getGenres { output in
            self.genresOutput = output;
        } failure: { error in
            // self.genresError = error;
            
        }
    }
    
    func createGenre(_ genre: GenreInput) {
        self.model.createGenre(genre) { output in
            
            print("POST /genre 201");
            self.getGenres()
            
        } failure: { error in
            
            print("Error: \(error.localizedDescription)");
            
        }

    }
    
    func getGenreByIndex(_ index: Int) -> GenreOutput? {
        self.genresOutput?[index];
    }
    
    var genresOutput: [GenreOutput]? {
        didSet {
            self.delegate?.genresOutputDidChange(self)
        }
    }
    var genresError: NSError? {
        didSet {
            self.delegate?.genresErrorDidChange(self);
        }
    }
}
