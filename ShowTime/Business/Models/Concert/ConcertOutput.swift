//
//  ConcertOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import Foundation

struct ConcertOutput : Codable {
    let id: String;
    let artist : ArtistOutput;
    let date : String;
    let venueId : String;
    let venueName : String;
    let address : String;
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case venueName = "venue"
        case artist, date, venueId, address
    }
}
