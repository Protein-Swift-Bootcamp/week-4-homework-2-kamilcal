//
//  AlbumListViewProtocol.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

enum AlbumListViewNavigation {
    case details(Album)
}

protocol AlbumListViewProtocol {
    func move(to: AlbumListViewNavigation)
    func showMusicList(albums: [Album]?)
    func getAlbum(at index: Int) -> Album
//    func showSearchError()

}
