
//
//  SideBarTableViewCell.swift
//  Triz
//
//  Created by Laxmi Rekha on 03/06/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit

class SideBarTableViewCell: UITableViewCell {

    @IBOutlet weak var sideimg: UIImageView!
    @IBOutlet weak var sidename: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
