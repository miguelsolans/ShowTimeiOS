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
            
            self.groupedByDate = Dictionary(grouping: output, by: { $0.date })
            self.concertsOutput = output;
            
        } failure: { error in
            
            
        }
    }
    
    func getPastConcerts() {
        self.model.getPast { output in
            
            self.groupedByDate = Dictionary(grouping: output, by: { $0.date });
            self.concertsOutput = output;
            
        } failure: { error in
            
        }

    }
    
    func getScheduled() {
        self.model.getScheduled { output in
            
            self.groupedByDate = Dictionary(grouping: output, by: { $0.date });
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
    
    func numberOfConcerts() -> Int {
        
        guard let concerts = self.groupedByDate else { return 0 };
        
        return concerts.keys.count;
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        
        guard let concerts = self.groupedByDate else { return 0 };
        
        let key = Array(concerts.keys.sorted())[ section ];
        
        return concerts[ key ]?.count ?? 0;
    }
    
    func titleForSection(_ section: Int) -> String {
        guard let concerts = self.groupedByDate else { return "" }
        
        let key = Array(concerts.keys.sorted())[ section ];
        
        return key;
    }
    
    func concertForSection(_ section: Int, andIndex index: Int)  -> ConcertOutput? {
        guard let concerts = self.groupedByDate else { return nil }
        
        let key = Array(concerts.keys.sorted())[ section ];
        
        let concertsOnDate = concerts[ key ];
        
        guard let concert = concertsOnDate?[index] else { return nil }
        
        
        return concert
        
    }
    
    var groupedByDate: [String: [ConcertOutput]]?;
    
    
    // MARK: - Service Outputs
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
