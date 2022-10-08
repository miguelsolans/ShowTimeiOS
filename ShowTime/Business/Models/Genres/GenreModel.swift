//
//  GenreModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import Foundation

class GenreModel: BaseModel {
    
    override init() {
        super.init();
        
        self.endpoints = [
            "listGenres": "http://localhost:3031/genre",
            "addGenre": "http://localhost:3031/genre"
        ];
    }
    
    func getGenres(completion: @escaping(_ output: [GenreOutput]) -> Void,
                   failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "listGenres" ]!, httpMethod: .get, parameters: nil) { (result: Result<[GenreOutput], Error>) in
            
            switch result {
                case .success(let output):
                    completion(output)
                case .failure(let error):
                    failure(error);
            }
        }
    }
    
    func createGenre(_ genre: GenreInput, completion: @escaping(_ output: GenreOutput) -> Void,
                     failure: @escaping(_ error: Error) -> Void) {
        
        let params = genre.dictionary;
        
        self.networkManager.request(toURL: self.endpoints[ "addGenre" ]!, httpMethod: .post, parameters: params) { (result: Result<GenreOutput, Error>) in
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error)
            }
        }
        
    }
}
