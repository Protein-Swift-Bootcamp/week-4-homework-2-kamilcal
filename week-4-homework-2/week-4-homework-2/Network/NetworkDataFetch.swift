//
//  NetworkDataFetch.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    let decoder = JSONDecoder()
    
    func fetchAlbum(urlString: String, response: @escaping (AlbumModel?, Error?) -> Void) {
        NetworkRequest.shared.request(urlString: urlString) { result in
            switch result {
                
            case .success(let data):
                do {
                    let jsonAlbum = try self.decoder.decode(AlbumModel.self, from: data)
                    response(jsonAlbum, nil)
                } catch let jsonError {
                    print("Failed to decode json \(jsonError.localizedDescription)")
                }
            case .failure(let error):
                print("Error request: \(error.localizedDescription)")
                response(nil,error)
            }
        }
    }
    
    func fetchSong(urlString: String, response: @escaping (SongsModel?, Error?) -> Void) {
        NetworkRequest.shared.request(urlString: urlString) { result in
            switch result {
                
            case .success(let data):
                do {
                    let jsonSong = try self.decoder.decode(SongsModel.self, from: data)
                    response(jsonSong, nil)
                } catch let jsonError {
                    print("Failed to decode json \(jsonError.localizedDescription)")
                }
            case .failure(let error):
                print("Error request: \(error.localizedDescription)")
                response(nil,error)
            }
        }
    }
}
