//
//  GenreInput.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import Foundation

struct GenreInput : Encodable {
    let genre: String;
    let subGenre: String;
    let description: String;
}
