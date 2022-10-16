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
            "all": "concert",
            "past": "concert/past",
            "scheduled": "concert/scheduled",
            "new": "concert"
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
