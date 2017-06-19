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
    @IBOutlet weak var gview: UIView!
    
    override func layoutSubviews() {
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 2.0
        self.gview.clipsToBounds = true
        self.gview.layer.cornerRadius = 5
        self.imgv.clipsToBounds = true
        self.imgv.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.gview.layer.bounds
        
        gradientLayer.colors = [UIColor(rgbValue : 0x000000).cgColor, UIColor(rgbValue : 0x000000).cgColor]
        
        self.gview.layer.addSublayer(gradientLayer)
    }

   

}
