//
//  ArtistSpotifySearchOutput.swift
//  ShowTime
//
//  Created by Miguel Solans on 01/11/2022.
//

import Foundation

struct ArtistFollowersSpotifyOutput : Codable {
    let total: Int
}

struct ArtistSpotifyImageOutput : Codable {
    let height: Int
    let width: Int
    let url: String
}

struct ArtistSpotifyOutput : Codable {
    let followers: ArtistFollowersSpotifyOutput
    let genres: [String]
    let images: [ArtistSpotifyImageOutput]
    let name: String
}

struct SpotifySearchResults : Codable {
    let limit: Int
    let total: Int
    let items: [ArtistSpotifyOutput]
}

struct ArtistSpotifySearchOutput : Codable {
    let artists : SpotifySearchResults;
}
