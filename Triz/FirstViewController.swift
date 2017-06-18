//
//  FirstViewController.swift
//  Fitgyan
//
//  Created by Laxmi Rekha on 03/03/17.
//  Copyright © 2017 devoron. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var index = 0
    //var heading = ""
    var imageFile = ""
    var content = ""
    var blueEffect:UIBlurEffect!
    var blurView: UIVisualEffectView!
    @IBOutlet weak var scrolelrs: UIPageControl!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var forwardButton:UIButton!
    var images = [#imageLiteral(resourceName: "triz intro 1"),#imageLiteral(resourceName: "triz intro 2"),#imageLiteral(resourceName: "triz intro 3")]
    override func viewDidLoad() {
        super.viewDidLoad()
        scrolelrs.currentPage = index
        
        imageView.image = images[index]
        if case 0 = index {
            forwardButton.setTitle("NEXT", for: UIControlState.normal)
        }
       else if case 1 = index {
            forwardButton.setTitle("NEXT", for: UIControlState.normal)
        }else if case 2 = index {
            forwardButton.setTitle("DONE", for: UIControlState.normal)
        }
        
    }
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
        case 0:
            let pageViewController = parent as!
            WalkThroughViewController
            pageViewController.forward(index: index)
        case 1:
            let pageViewController = parent as!
            WalkThroughViewController
            pageViewController.forward(index: index)
        case 2:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedWalkthrough")
            
            //dismissViewControllerAnimated(true, completion: nil)
            
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                let navController = UINavigationController(rootViewController: pageViewController)
                present(navController, animated: true, completion: nil)
            }
            
            
        default: break
        }
    }
    
}
extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
