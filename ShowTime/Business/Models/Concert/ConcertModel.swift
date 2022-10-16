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
            "all": "http://localhost:3031/concert",
            "past": "http://localhost:3031/concert/past",
            "scheduled": "http://localhost:3031/concert/scheduled",
            "new": "http://localhost:3031/concert"
        ];
    }
    
    func getAll(completion: @escaping(_ output: [ConcertOutput]) -> Void,
                failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "all" ]!, httpMethod: .get, parameters: nil) { (result: Result<[ConcertOutput], Error>) in
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error);
            }
        }
    }
    
    func getPast(completion: @escaping(_ output: [ConcertOutput]) -> Void,
                 failure: @escaping(_ error: Error) -> Void) {
        self.networkManager.request(toURL: self.endpoints[ "past" ]!, httpMethod: .get, parameters: nil) { (result: Result<[ConcertOutput], Error>) in
            
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error)
            }
            
        }
    }
    
    
    func getScheduled(completion: @escaping(_ output: [ConcertOutput]) -> Void,
                      failure: @escaping(_ error: Error) -> Void) {
        self.networkManager.request(toURL: self.endpoints[ "scheduled" ]!, httpMethod: .get, parameters: nil) { (result: Result<[ConcertOutput], Error>) in
            
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error)
            }
            
        }
    }
    
    func addNew(concert: ConcertInput, completion: @escaping(_ output: ConcertOutput) -> Void,
                failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "new" ]!, httpMethod: .post, parameters: concert.dictionary) { (result: Result<ConcertOutput, Error>) in
            
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error)
            }
            
        }
    }
    
}
