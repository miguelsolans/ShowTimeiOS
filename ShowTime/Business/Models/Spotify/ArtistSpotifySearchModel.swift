//
//  ArtistSpotifySearchModel.swift
//  ShowTime
//
//  Created by Miguel Solans on 01/11/2022.
//

import Foundation

class ArtistSpotifySearchModel : BaseModel {
    
    override init() {
        super.init();
        
        self.endpoints = [
            "getAll": "spotify/artist"
        ]
    }
    
    func getAll(artist name: String, completion: @escaping(_ output: ArtistSpotifySearchOutput) -> Void,
                     failure: @escaping(_ error: Error) -> Void) {
        
        var url = URLComponents(string: self.endpoints[ "getAll" ]!)!;
        url.queryItems = [URLQueryItem(name: "artist", value: name)];
        
        let path = url.string!;
        
        self.networkManager.request(toURL: path, httpMethod: .get, parameters: nil) { (result: Result<ArtistSpotifySearchOutput, Error>) in
            
            switch result {
            case .success(let output):
                completion(output)
            case .failure(let error):
                failure(error);
            }
        }
    }
}
