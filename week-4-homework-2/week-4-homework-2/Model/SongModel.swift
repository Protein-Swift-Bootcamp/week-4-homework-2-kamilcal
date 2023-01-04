//
//  SongModel.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

struct SongsModel: Decodable {
    let resultCount: Int
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
