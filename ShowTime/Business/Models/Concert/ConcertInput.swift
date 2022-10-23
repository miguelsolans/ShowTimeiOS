//
//  ConcertInput.swift
//  ShowTime
//
//  Created by Miguel Solans on 16/10/2022.
//

import Foundation

struct ConcertInput : Encodable {
    let artistName: String
    let date: String
    let venueId: String
    let notes: String
}
