//
//  VenueModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 16/10/2022.
//

import Foundation

class VenueModel : BaseModel {
    
    override init() {
        super.init();
        
        self.endpoints = [
            "list": "venue"
        ]
    }
    
    func getAll(completion: @escaping(_ output: [VenueOutput]) -> Void,
                     failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "list" ]!, httpMethod: .get, parameters: nil) { (result: Result<[VenueOutput], Error>) in
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error);
            }
        }
    }
}
