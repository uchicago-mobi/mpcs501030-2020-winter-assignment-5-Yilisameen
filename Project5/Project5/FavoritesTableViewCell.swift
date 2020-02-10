//
//  FavoritesTableViewCell.swift
//  Project5
//
//  Created by Yangjun Bie on 2/10/20.
//  Copyright © 2020 Yangjun Bie. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet var placeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
