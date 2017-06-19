//
//  SideBarViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 03/06/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var sideview: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    var colorSets = [[CGColor]]()
    
    @IBOutlet weak var sidetable: UITableView!
    var currentColorSet: Int!
    var sidenames = ["Profile","Choose Location","Feedback"," About Triz","Logout"]
    var imgnames = ["user","location","feedback","triz","logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        createColorSets()
        let defaults =  UserDefaults.standard
        name.text = defaults.string(forKey: "email")
        sidetable.tableFooterView = UIView()
        sidetable.rowHeight = UITableViewAutomaticDimension
        sidetable.estimatedRowHeight = 40
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.sideview.applyGradient(colours: [ UIColor(rgbValue :0xFF0D8D) , UIColor(rgbValue :0x8D007C)])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            self.performSegue(withIdentifier: "aboutid", sender: self)

            break
        case 4:
            let alertController = UIAlertController(title: "Logout", message: "Do you wish to logout?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            let copyAction = UIAlertAction(title: "Ok", style: .destructive, handler: {
                (action : UIAlertAction!) -> Void in
                UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                UserDefaults.standard.synchronize()
                if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                    let navController = UINavigationController(rootViewController: pageViewController)
                    self.present(navController, animated: true, completion: nil)
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "hasViewedWalkthrough")

                }

                
            })
            
            
            
            alertController.addAction(copyAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
             break
        default: break
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "aboutid" {
//            let backItem = UIBarButtonItem()
//            backItem.title = "Home"
//            navigationItem.backBarButtonItem = backItem
//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let header = tableView.dequeueReusableCell(withIdentifier: "sidecell") as! SideBarTableViewCell
        header.sidename.text = sidenames[indexPath.row]
        header.sideimg.image = UIImage(named : imgnames[indexPath.row])?.imageWithColor(color: UIColor(rgbValue: 0x8F017D))
        return header

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
   
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.sideview.bounds
        
        
        gradientLayer.colors = [0x8D007C ,0xF05357]
        gradientLayer.locations = [0.0, 0.35]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.sideview.layer.addSublayer(gradientLayer)
    }
    func createColorSets() {
    //    colorSets.append([0x8D007C as! CGColor,0xF05357 as! CGColor])
        currentColorSet = 0
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
extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
