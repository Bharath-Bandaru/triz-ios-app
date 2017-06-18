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
        self.grad_view.layer.cornerRadius = 6
        self.grad_view.clipsToBounds = true;
        createGradientLayer()
    }
    func createGradientLayer() {
        
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.grad_view.bounds
        
        gradientLayer.colors = [UIColor(rgbValue : 0xFF0D8D).cgColor, UIColor(rgbValue : 0xF02529).cgColor]
        
        self.grad_view.layer.addSublayer(gradientLayer)
    }
}
