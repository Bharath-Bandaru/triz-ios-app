//
//  MatterTableViewCell.swift
//  conference
//
//  Created by Laxmi Rekha on 11/09/16.
//  Copyright © 2016 ux. All rights reserved.
//

import UIKit

class MatterTableViewCell: UITableViewCell {

    @IBOutlet weak var eventMiddles: UILabel!
    @IBOutlet weak var imgname: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var matter: UILabel!
    @IBOutlet weak var roomno: UILabel!
    @IBOutlet weak var imgv: UIImageView!
    
    override func awakeFromNib() {
      super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgv.clipsToBounds = true
        self.imgv.layer.cornerRadius = imgv.frame.size.height/2
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
