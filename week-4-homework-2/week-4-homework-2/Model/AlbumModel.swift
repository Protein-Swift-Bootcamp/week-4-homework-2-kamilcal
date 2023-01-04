//
//  AlbumModel.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

struct AlbumModel: Decodable, Equatable {
    let resultCount: Int
    let results: [Album]
}
struct Album: Decodable, Equatable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
    let collectionId: Int
}

