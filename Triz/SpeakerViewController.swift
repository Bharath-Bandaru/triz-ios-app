//
//  SpeakerViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 27/05/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import SwiftyJSON
import CryptoSwift
import SDWebImage

class SpeakerViewController: UIViewController {
    

    @IBOutlet weak var vie_fin: UIView!
    @IBOutlet weak var full_view: UIView!
    @IBOutlet weak var srating: CosmosView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var swat: UITextView!
    @IBOutlet weak var sabt: UITextView!
    @IBOutlet weak var sbut: UIButton!
    @IBOutlet weak var stitle: UILabel!
    @IBOutlet weak var simg: UIImageView!
    
    var nam : String?
    var bio : String?
    var img : String?
    var works : String?
    var talks : String?
  
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var view_img: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
//        scrollview.contentSize = CGSize(width : 400, height: 2300)
       sbut.clipsToBounds = true
        sbut.layer.cornerRadius = sbut.layer.bounds.height/2
        simg.clipsToBounds = true
        view_img.clipsToBounds = true
        view_img.layer.cornerRadius = 5
        simg.layer.cornerRadius = 5
        sabt.text = bio
        sabt.sizeToFit()
        let path = UIBezierPath(roundedRect:self.full_view.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width :15, height : 15))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.full_view.bounds;
        maskLayer.path = path.cgPath
        self.full_view.layer.mask = maskLayer;
               let fixedWidth = sabt.frame.size.width
        sabt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = sabt.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = sabt.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        sabt.frame = newFrame;
        name.text = nam
        simg.sd_setImage(with: URL(string: img!))
        swat.text = works
      
        stitle.text = talks
              // Do any additional setup after loading the view.
    }

    @IBAction func sbutact(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollview.contentSize = CGSize(width: 375, height: 1500)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
