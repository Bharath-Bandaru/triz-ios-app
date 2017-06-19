//
//  ExploreCollectionViewCell.swift
//  Triz
//
//  Created by Laxmi Rekha on 15/04/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var grad_view: UIView!
    @IBOutlet weak var exploreImage: UIImageView!
    @IBOutlet weak var exploreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.grad_view.layer.cornerRadius = 5
        self.grad_view.clipsToBounds = true
        createGradientLayer()
    }
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
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    func createGradientLayer() {
        
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.grad_view.bounds
        
        gradientLayer.colors = [UIColor(rgbValue : 0xFF0D8D).cgColor, UIColor(rgbValue : 0xF02529).cgColor]
        
        self.grad_view.layer.addSublayer(gradientLayer)
    }
}
