//
//  ExploreViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 24/03/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift
import SWRevealViewController
import KVNProgress

class ExploreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var openSideBAr: UIBarButtonItem!
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var exploreCollection: UICollectionView!
    var exploreEvents = Array<String>()
    var exploreEventsuuid = Array<String>()

    @IBOutlet weak var curveview: UIView!
    var titl: String?
    var venue : String = ""
    var desc :String = ""
    var sdate : String = ""
    var edate : String = ""
    var tempindex : Int?
    var event_url = "http://lowcost-env.hr2dk2nnep.us-west-2.elasticbeanstalk.com/event"

    override func viewDidLoad() {
        super.viewDidLoad()
        openSideBAr.target = self.revealViewController()
        openSideBAr.action =  #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

        self.navigationController?.navigationBar.applyg(gradient: [UIColor(rgbValue :0xF02529) , UIColor(rgbValue :0xFF0D8D)])
        
        getExploreEvents();
        self.automaticallyAdjustsScrollViewInsets = false

        
        }
    override func viewWillAppear(_ animated: Bool) {
           }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: {() -> Void in
        let path = UIBezierPath(roundedRect:self.curveview.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width :15, height : 15))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.curveview.bounds;
        maskLayer.path = path.cgPath
        self.curveview.layer.mask = maskLayer;
        })

    }
    func getExploreEvents(){
     
        Alamofire.request(self.event_url, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    
                    let responseJSON = JSON(resultValue)
                    //print("res\(responseJSON)")

                    let exploreArray = responseJSON["value"].array
                    for event in exploreArray!{
                        self.exploreEvents.append(event["event_title"].string!)
                        self.exploreEventsuuid.append(event["event_uuid"].string!)
                    }
                
                    DispatchQueue.main.async {
                        self.exploreCollection.reloadData()
                    }
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrr")
                    DispatchQueue.main.async {
                        
                    }
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
        }
    }
    
 
    func getDetails(ur : String, head : [String : String],completionHandler:((UIBackgroundFetchResult)->())!){
        
        Alamofire.request(ur, method: .get, parameters: nil,encoding: JSONEncoding.default,headers : head )
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print(response)
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    print("hereeee;e")
                    
                    let responseJSON = JSON(resultValue)
                    print("reser\(responseJSON)")
                    
                    let exploreArray = responseJSON["value"]
                    
                    self.titl = exploreArray["event_title"].string
                    self.venue = exploreArray["event_venue"].string!
                    self.desc = exploreArray["event_description"].string!
                    self.sdate = exploreArray["start_date"].string!
                    self.edate = exploreArray["end_date"].string!
                    print("thehehe\(self.venue)")
                    
                    DispatchQueue.main.async {
                        
                    }
                    completionHandler(UIBackgroundFetchResult.newData)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrr")
                    DispatchQueue.main.async {
                        
                    }
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                print("Background Fetch Complete")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                  // self.performSegue(withIdentifier: "showdetail", sender: self)
        let urle = self.event_url + "/" + self.exploreEventsuuid[indexPath.row]
        print("sfsef \(urle)")
        tempindex =  indexPath.row
       let head = ["hmac" : (self.exploreEventsuuid[indexPath.row] + "_1234567890").sha1()]
      KVNProgress.show(withStatus: "Loading event details")
        getDetails(ur : urle,head : head, completionHandler: { (UIBackgroundFetchResult) in
                       self.performSegue(withIdentifier: "showdetail", sender: self)
                      KVNProgress.dismiss()
            })
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "explorecell", for: indexPath) as! ExploreCollectionViewCell
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.contentView.layer.cornerRadius).cgPath
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 6;
      cell.exploreLabel.text = self.exploreEvents[indexPath.row]

        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count\(self.exploreEvents.count)")
        return self.exploreEvents.count
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> ExploreHeaderCollectionViewCell
    {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath as IndexPath) as! ExploreHeaderCollectionViewCell
        header.heading.text = "All Events"
        return header
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let dv : ExploreDetailViewController = (segue.destination as? ExploreDetailViewController)!
            print("uuuuuu\(self.venue)")
            dv.venue =  self.venue
            dv.titl = self.titl
            dv.desc =  self.desc
            dv.euuid = self.exploreEventsuuid[tempindex!]
            dv.sd = self.sdate
            dv.ed = self.edate
        
        }
    }
 

}
extension UINavigationBar
{
    /// Applies a background gradient with the given colors
    func applyg(gradient colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
        self.shadowImage = UIImage()
    }
    
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: size.height), end: CGPoint(x: 0, y: 0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

