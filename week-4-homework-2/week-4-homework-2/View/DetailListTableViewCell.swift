//
//  DetailListTableViewCell.swift
//  week-4-homework-2
//
//  Created by kamilcal on 4.01.2023.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {
    
    @IBOutlet var songNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension DetailListTableViewCell {
    func config(_ song: Song) {
        songNameLabel.text = song.trackName
    }
}
