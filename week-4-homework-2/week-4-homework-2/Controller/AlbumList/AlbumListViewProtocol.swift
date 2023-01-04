//
//  AlbumListViewProtocol.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

enum AlbumListViewNavigation {
    case exit
    case profile
    case details(Album)
}

protocol AlbumListViewProtocol {
    func showMusicList(albums: [Album]?)
    func getAlbum(at index: Int) -> Album
}
