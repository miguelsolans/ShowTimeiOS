//
//  ConcertModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import UIKit

class ConcertModel: BaseModel {
    override init() {
        super.init();
        self.endpoints = [
            "concerts": "http://localhost:3031/concert"
        ]
    }
    
    func getConcerts(completion: @escaping(_ output: [ConcertOutput]) -> Void,
                   failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "concerts" ]!, httpMethod: .get, parameters: nil) { (result: Result<[ConcertOutput], Error>) in
            
            switch result {
                case .success(let output):
                    completion(output)
                case .failure(let error):
                    failure(error);
            }
        }
    }

}
