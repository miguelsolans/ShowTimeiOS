//
//  ConcertViewModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import Foundation

protocol ConcertViewModelDelegate {
    func concertOutputDidChange();
}

class ConcertViewModel {
    var delegate : ConcertViewModelDelegate?;
    let model = ConcertModel()
    
    func getConcerts() {
        self.model.getAll { output in
            
            self.concertOutput = output;
            
        } failure: { error in
            
            
        }
    }
    
    func getPastConcerts() {
        self.model.getPast { output in
            
            self.concertOutput = output;
            
        } failure: { error in
            
        }

    }
    
    func getScheduled() {
        self.model.getScheduled { output in
            
            self.concertOutput = output;
            
        } failure: { error in
            
        }
    }
    
    var concertOutput: [ConcertOutput]? {
        didSet {
            self.delegate?.concertOutputDidChange();
        }
    }
}
