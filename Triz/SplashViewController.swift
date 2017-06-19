//
//  SplashViewController.swift
//  Fitgyan
//
//  Created by Laxmi Rekha on 03/03/17.
//  Copyright © 2017 devoron. All rights reserved.
//

import UIKit
import SWRevealViewController
class SplashViewController: UIViewController {
    
    @IBOutlet weak var spview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(SplashViewController.showNext), with: nil, afterDelay: 2)
        createGradientLayer()
        // Do any additional setup after loading the view.
    }
    public func showNext(){
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        let secondtime = defaults.bool(forKey: "secondtime")
        print("secondtime",secondtime)
        
        if secondtime{
            let view: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "explore") as! SWRevealViewController
            present(view, animated: true, completion: nil)
        }
        if !secondtime {
            if hasViewedWalkthrough {
                if let pageViewController:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                    let navController = UINavigationController(rootViewController: pageViewController)

                    present(navController, animated: true, completion: nil)
                }
            }
            if !hasViewedWalkthrough {
                if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkThroughViewController{
                    
                    present(pageViewController, animated: true, completion: nil)
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createGradientLayer() {
        
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.spview.bounds
        
        gradientLayer.colors = [UIColor(rgbValue : 0xF72B30).cgColor, UIColor(rgbValue : 0xFF0D8D).cgColor]
        
        self.spview.layer.addSublayer(gradientLayer)
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
