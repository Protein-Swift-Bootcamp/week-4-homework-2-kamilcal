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
//    "https://itunes.apple.com/search?term=\(albumName)"
//    "https://itunes.apple.com/search?term=\(albumName)&id=211192863&entity=song&media=music"
    //MARK: - didChangeSearch
    func didChangeSearch(albumName: String) {
        let urlString =
        "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term=\(albumName)"
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] album, error in
            if error == nil {
                guard let albumData = album else { return }
                
                let sortedAlbums = albumData.results.sorted { firstItem, secondItem in
                    firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                }
                self?.albums = sortedAlbums
            } else {
                print(error!.localizedDescription)
            }
            self?.view.showMusicList(albums: self?.albums)
        }
    }
    
    //MARK: - selectRow
    func selectRow(at index: Int) {
        let album = view.getAlbum(at: index)
        view.move(to: .details(album))
    }
}
