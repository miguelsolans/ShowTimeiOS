//
//  VenueOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 16/10/2022.
//

import Foundation

struct VenueOutput : Codable {
    let id: String;
    let name : String;
    let address : String;
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, address
    }
}
