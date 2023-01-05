//
//  DetailListViewController.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import UIKit

class DetailListViewController: UIViewController {
    
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var countSongLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var albums: Album?
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setData()
        fetchSong(album: albums)
        navigationItem.largeTitleDisplayMode = .never
        imageView.layer.cornerRadius = 5.0
        navigationItem.title = ""
    }
    
}
// MARK: - UITableViewDataSource

extension DetailListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailListTableViewCell
        cell.config(songs[indexPath.row])
        return cell
    }
}

extension DetailListViewController {
    // MARK: - setData
    private func setData() {
        guard let album = albums else { return }
        
        albumNameLabel.text = album.collectionName
        groupNameLabel.text = "\(album.artistName)"
        dateLabel.text = "\(setDateFormatter(date: album.releaseDate))"
        countSongLabel.text = "\(album.trackCount) tracks"
        guard let url = album.artworkUrl100 else { return }
        setLogoAlbum(urlString: url)
    }
    
    // MARK: - setDateFormatter
    private func setDateFormatter(date: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyy'-'MM'-'dd'T'HH':'mm':'ssZZZ'"
        guard let date = df.date(from: date) else { return "" }
        let fromDate = DateFormatter()
        fromDate.dateFormat = "dd.MM.yyyy"
        let releaseDate = fromDate.string(from: date)
        return releaseDate
    }
    // MARK: - setLogoAlbum
    private func setLogoAlbum(urlString: String?) {
        if let url = urlString {
            NetworkRequest.shared.request(urlString: url) { [weak self] result in
                switch result {
                    
                case .success(let data):
                    self?.imageView.image = UIImage(data: data)
                case .failure(let error):
                    print("No album logo: ", error.localizedDescription)
                }
            }
        } else {
            imageView.image = nil
        }
    }
    // MARK: - fetchSong
    private func fetchSong(album: Album?) {
        guard let album = album else { return }
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        NetworkDataFetch.shared.fetchSong(urlString: urlString) { [weak self] song, error in
            if error == nil {
                guard let song = song else { return }
                self?.songs = song.results
                self?.tableView.reloadData()
            } else {
                let warningController = UIAlertController(title: "Error",
                                                          message: (error!.localizedDescription),
                                                          preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK",
                                                 style: .cancel)
                self?.tableView.reloadData()
                warningController.addAction(cancelAction)
                self?.present(warningController, animated: true)
                
            }
            self?.tableView.reloadData()
        }
    }
    
}
