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
