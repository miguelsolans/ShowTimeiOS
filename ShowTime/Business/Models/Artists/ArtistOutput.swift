//
//  ArtistOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import Foundation

struct ArtistOutput : Codable {
    let id: String;
    let name: String;
    let genreId: String;
    let genreName: String;
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, genreId, genreName
    }
}
