//
//  AlbumListViewController.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var albums: [Album]?
    var presenter: AlbumListPresenter!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        presenter = AlbumListPresenter(view: self, albums: albums)
        spinner.hidesWhenStopped = true

    }
    
}

//MARK: - UITableViewDataSource

extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumListTableViewCell
        guard let album = self.albums?[indexPath.row] else { return cell }
        cell.config(album)
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectRow(at: indexPath.row)
    }
    
    //MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let text = searchText else { preconditionFailure() }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
            self?.spinner.startAnimating()
            self?.presenter.didChangeSearch(albumName: text)
        })
    }
}
//MARK: - AlbumListViewProtocol
extension AlbumListViewController: AlbumListViewProtocol {
    func move(to: AlbumListViewNavigation) {
        switch to {
        case .details(let album):
            let detailVc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                .instantiateViewController(withIdentifier: "DetailListViewController") as? DetailListViewController
            detailVc?.albums = album
            detailVc?.title = "Details"
            self.navigationController?.pushViewController(detailVc!, animated: true)
        }
    }
    
    //    func showSearchError() {
    //        <#code#>
    //    }
    //
    func showMusicList(albums: [Album]?) {
        self.albums = albums
        spinner.stopAnimating()
        tableView.reloadData()
    }
    
    func getAlbum(at index: Int) -> Album {
        guard let album = self.albums?[index] else { preconditionFailure() }
        return album
    }
    
    
}
