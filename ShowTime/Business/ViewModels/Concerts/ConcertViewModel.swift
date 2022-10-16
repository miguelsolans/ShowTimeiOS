//
//  ConcertViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import Foundation

protocol ConcertViewModelDelegate {
    func concertsOutputDidChange(_ viewModel: ConcertViewModel);
    func concertOutputDidChange(_ viewModel: ConcertViewModel);
}

class ConcertViewModel {
    var delegate : ConcertViewModelDelegate?;
    let model = ConcertModel()
    
    func getConcerts() {
        self.model.getAll { output in
            
            self.concertsOutput = output;
            
        } failure: { error in
            
            
        }
    }
    
    func getPastConcerts() {
        self.model.getPast { output in
            
            self.concertsOutput = output;
            
        } failure: { error in
            
        }

    }
    
    func getScheduled() {
        self.model.getScheduled { output in
            
            self.concertsOutput = output;
            
        } failure: { error in
            
        }
    }
    
    func addNew(concert: ConcertInput) {
        self.model.addNew(concert: concert) { output in
            self.concertOutput = output
        } failure: { error in
            
        }

    }
    
    var concertOutput: ConcertOutput? {
        didSet {
            self.delegate?.concertOutputDidChange(self);
        }
    }
    
    var concertsOutput: [ConcertOutput]? {
        didSet {
            self.delegate?.concertsOutputDidChange(self);
        }
    }
}
