//
//  ArtistModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import Foundation

class ArtistModel: BaseModel {
    
    override init() {
        super.init();
        
        self.endpoints = [
            "listArtists": "http://localhost:3031/artist",
            "listArtistsByGenre": "http://localhost:3031/artist",
            "createArtist": "http://localhost:3031/artist"
        ];
    }
    
    func getArtists(completion: @escaping(_ output: [ArtistOutput]) -> Void,
                   failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "listArtists" ]!, httpMethod: .get, parameters: nil) { (result: Result<[ArtistOutput], Error>) in
            
            switch result {
                case .success(let output):
                    completion(output)
                case .failure(let error):
                    failure(error);
            }
        }
    }
    
    func getArtistsByGenre(_ genre: String, completion: @escaping(_ output: [ArtistOutput]) -> Void,
                   failure: @escaping(_ error: Error) -> Void) {
        
        
        var url = URLComponents(string: self.endpoints[ "listArtistsByGenre" ]!)!;
        url.queryItems = [URLQueryItem(name: "genre", value: genre)];
        
        
        let path = url.string!;
        
        self.networkManager.request(toURL: path, httpMethod: .get, parameters: nil) { (result: Result<[ArtistOutput], Error>) in
            
            switch result {
                case .success(let output):
                    completion(output)
                case .failure(let error):
                    failure(error);
            }
        }
    }
    
    func createArtist(_ artist: ArtistInput, completion: @escaping(_ output: ArtistOutput) -> Void,
                      failure: @escaping(_ error: Error) -> Void) {
        
        self.networkManager.request(toURL: self.endpoints[ "createArtist" ]!, httpMethod: .post, parameters: artist.dictionary) { (result: Result<ArtistOutput, Error>) in
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error)
            }
        }
        
    }
    
}
