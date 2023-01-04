//
//  NetworkRequest.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    
    func request(urlString: String, completion: (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}

