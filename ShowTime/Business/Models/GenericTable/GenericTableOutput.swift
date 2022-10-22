//
//  GenericTableOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 22/10/2022.
//

import Foundation

struct GenericTableItem : Codable {
    let id: String
    let label: String 
}

struct GenericTableOutput : Codable {
    let tableName: String;
    let data : [GenericTableItem];
}
