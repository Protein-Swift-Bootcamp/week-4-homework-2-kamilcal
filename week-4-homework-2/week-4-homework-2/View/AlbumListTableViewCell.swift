//
//  AlbumListTableViewCell.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import UIKit

class AlbumListTableViewCell: UITableViewCell {

    @IBOutlet var songCountLabel: UILabel!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var imagaView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension AlbumListTableViewCell {
    func config(_ album: Album) {
        albumNameLabel.text = album.collectionName
        groupNameLabel.text = album.artistName
        songCountLabel.text = "\(album.trackCount) tracks"
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.request(urlString: urlString) { [weak self] result in
                switch result {
                    
                case .success(let data):
                    self?.imagaView.image = UIImage(data: data)
                case .failure(let error):
                    self?.imagaView.image = nil
                    print("No album logo: ", error.localizedDescription)
                }
            }
        } else {
            imagaView.image = nil
        }
    }
}

