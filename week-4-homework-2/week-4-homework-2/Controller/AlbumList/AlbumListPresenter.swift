//
//  AlbumListPresenter.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

class AlbumListPresenter {
    let view: AlbumListViewProtocol
    var albums: [Album]?
    
    init(view: AlbumListViewProtocol, albums: [Album]?) {
        self.view = view
        self.albums = albums
    }
    
    func didChangeSearch(albumName: String) {
        let urlString = "https://itunes.apple.com/search?term=\(albumName)"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] album, error in
            if error == nil {
                guard let albumData = album else { return }
                
                if albumData.results != [] {
                    let sortedAlbums = albumData.results.sorted { firstItem, secondItem in
                        firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    self?.albums = sortedAlbums
                } else {
//                    self?.view.showSearchError()
                }
            } else {
                print(error!.localizedDescription)
            }
            self?.view.showMusicList(albums: self?.albums)
        }
    }
    
    func selectRow(at index: Int) {
        let album = view.getAlbum(at: index)
        view.move(to: .details(album))
    }
}
