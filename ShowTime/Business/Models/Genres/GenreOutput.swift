//
//  GenreOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import Foundation

struct GenreOutput : Codable {
    let id: String;
    let genre: String;
    let subGenre: String;
    let description: String;
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case genre, subGenre, description
    }
}
