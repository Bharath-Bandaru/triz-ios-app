//
//  ExploreDetailViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 15/04/17.
//  Copyright © 2017 um. All rights reserved.
//

import Alamofire
import SwiftyJSON
import CryptoSwift
import UIKit
import KVNProgress

class ExploreDetailViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var imag_grad: UIView!
    @IBOutlet weak var speakernotupdated: UILabel!
    @IBOutlet weak var edesc: UITextView!
    @IBOutlet weak var likeBut: UIBarButtonItem!
    @IBOutlet weak var buyBut: UIButton!
    @IBOutlet weak var escroll: UIScrollView!
    @IBOutlet weak var eimage: UIImageView!
    @IBOutlet weak var eheading: UILabel!
    @IBOutlet weak var esubheading: UILabel!
    @IBOutlet weak var ecost: UILabel!
    @IBOutlet weak var eplace: UILabel!
    @IBOutlet weak var emonth: UILabel!
    @IBOutlet weak var ebuttonhome: UIButton!
    @IBOutlet weak var eday: UILabel!
    var speak :String = ""
    var venue : String = ""
    var desc :String = ""
    var sdate : String = ""
    var edate : String = ""
    var euuid : String = ""
    var sd = ""
    var ed = ""
    var titl : String?
    var flag = 0
    var spk_url = "http://sintillashunz.com/DesignFirst/speakers.php"
    var tempI : Int = 0
    var event_title = ""
    var event_image = ""
    var hostedby = ""
    var event_date = ""
    var schedule_title = Array<String>()
    var schedule_info = Array<String>()
    var schedule_time = Array<String>()
    var schedule_image = Array<String>()
    var schedule_hashtag = Array<String>()
    var schedule_sname = Array<String>()
    var speaker_name_arr = Array<String>()
    var speaker_image_arr = Array<String>()
    var speaker_works_at_arr = Array<String>()
    var speaker_about_arr = Array<String>()
    var speaker_talks_about_arr = Array<String>()

    @IBOutlet weak var mht: NSLayoutConstraint!
    @IBOutlet weak var detailview: UIView!
    @IBOutlet weak var scollection: UICollectionView!
    var speakeruuid = Array<String>()
    var speakername = Array<String>()
    var speakerbio = Array<String>()
    var speakerimg = Array<String>()
    @IBOutlet weak var collht: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.eheading.text = titl
        self.eplace.text =  venue
        self.edesc.text = desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: self.sd) ?? Date()
        let calendar = Calendar.current
//
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.day, from: date)
        let day = calendar.component(.day, from: date)
        
        print("dayyyy\(self.sd)\(date)")
        self.emonth.text = "\(date.monthMedium.uppercased())"
        self.eday.text =  "\(day)" + "\n" + date.dayOfWeek()!
        eimage.dropShadow(scale: true)
        buyBut.dropShadow(scale: true)
        ebuttonhome.dropShadow(scale: true)
        eheading.numberOfLines = 0
        eheading.frame = CGRect(x:20,y:20,width:200,height:800)
       esubheading.numberOfLines = 0
        esubheading.frame = CGRect(x:20,y:20,width:200,height:800)
        eheading.sizeToFit()
        esubheading.sizeToFit()
           self.ebuttonhome.layer.cornerRadius=self.ebuttonhome.layer.bounds.height/2
        self.ebuttonhome.clipsToBounds =  true
        self.buyBut.layer.cornerRadius=self.buyBut.layer.bounds.height/2
        self.buyBut.clipsToBounds =  true
        self.navigationController?.navigationBar.barTintColor = UIColor.init(argb: 0xEE3568)
        
        
        
        self.eimage.layer.cornerRadius = 5.0
        self.eimage.layer.borderWidth = 1.0
        self.eimage.layer.borderColor = UIColor.clear.cgColor
        self.eimage.layer.masksToBounds = true
        self.eimage.clipsToBounds = true
        self.eimage.layer.shadowColor = UIColor.lightGray.cgColor
        self.eimage.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.eimage.layer.shadowRadius = 2.0
        self.eimage.layer.shadowOpacity = 2.0
        self.eimage.layer.masksToBounds = false
        self.eimage.layer.shadowPath = UIBezierPath(roundedRect: self.eimage.bounds, cornerRadius: self.eimage.layer.cornerRadius).cgPath
        
        
        
     //   self.navigationController?.navigationBar.apply(gradient: [UIColor.init(argb: 0xFF0D8D), UIColor.init(argb: 0xE44E51)])
        let urles = self.spk_url + "/" + self.euuid
        let head = ["hmac" : (self.euuid + "_1234567890").sha1()]
        print("bhbhbh\(urles) n \(self.titl!)")
        //speak = self.euuid
        speak = self.titl!
        self.getSpeakers(ur : urles,head : head, completionHandler: { (UIBackgroundFetchResult) in
        })
      //  self.navigationItem.title = self.titl
        self.getSpe()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.ebuttonhome.titleLabel?.numberOfLines = 1
            self.ebuttonhome.titleLabel?.adjustsFontSizeToFitWidth = true
            self.ebuttonhome.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
            self.eimage.layer.cornerRadius = 5
            self.eimage.clipsToBounds = true
            let path = UIBezierPath(roundedRect:self.detailview.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width :15, height : 15))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.detailview.bounds;
            maskLayer.path = path.cgPath
            self.detailview.layer.mask = maskLayer;
            self.escroll.contentSize = CGSize(width: CGFloat(0), height: CGFloat(self.view.layer.bounds.height + self.scollection.layer.bounds.height + 540))
            
//            let height = min(self.detailview.bounds.size.height, self.scollection.contentSize.height)
//            //self.collht.constant = height
//            self.view.layoutIfNeeded()
//            self.escroll.contentSize.height =   self.detailview.layer.bounds.height + self.mht.constant

                  //    self.escroll.contentSize = CGSize(width: CGFloat(0), height: CGFloat(self.view.layer.bounds.height + self.scollection.layer.bounds.height ))
        })
    }

    func getSpe()
    {
        let parameters: Parameters = ["event_name": "DesignFirst"]
        Alamofire.request(spk_url, method: .post, parameters: parameters)
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
                    print("wwww: \(responseJSON)")
                    if(responseJSON["result"]==1 ){
                        for index in responseJSON["speaker"].array!{
                    self.speaker_name_arr.append(index["speaker_name"].string!)
                    self.speaker_image_arr.append(index["speaker_image"].string!)
                    self.speaker_works_at_arr.append(index["speaker_works_at"].string!)
                    self.speaker_about_arr.append(index["speaker_about"].string!)
                    self.speaker_talks_about_arr.append(index["speaker_talks_about"].string!)
                        }
//                    print("bhnbhn\(self.speaker_about_arr)")
                    }
                    DispatchQueue.main.async {
                        if self.speaker_name_arr.count == 0{
                            self.speakernotupdated.isHidden = false
                        }
                        self.scollection.reloadData()
                    }
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrrt")
                    DispatchQueue.main.async {
                        
                    }
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                
        }
        
        
    }

    func getSpeakers(ur : String, head : [String : String],completionHandler:((UIBackgroundFetchResult)->())!){
        
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
                    
                    let exploreArray = responseJSON["value"].array
                    for spk in exploreArray! {
                        self.speakeruuid.append(spk["speaker_uuid"].string!)
                        self.speakername.append(spk["speaker_name"].string!)
                        self.speakerbio.append(spk["speaker_bio"].string!)
                        self.speakerimg.append(spk["speaker_image_url"].string!)
                        print("thehehe\(self.venue)")
                    }
                    DispatchQueue.main.async {
                        if self.speakername.count == 0{
                            self.speakernotupdated.isHidden = false
                        }
                        self.scollection.reloadData()
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

    @IBAction func likeAction(_ sender: Any) {
        if flag == 0{
        likeBut.image = UIImage(named : "liked")
            flag = 1
        }
        else{
            likeBut.image = UIImage(named : "like")
            flag = 0

        }
    }
    
    @IBAction func ebutHomeAction(_ sender: Any) {
        KVNProgress.show(withStatus: "Loading schedule")
        getSchedule(ur : "http://sintillashunz.com/DesignFirst/schedule.php", completionHandler: { (UIBackgroundFetchResult) in
            self.performSegue(withIdentifier: "showschedule", sender: self)
            KVNProgress.dismiss()
        })
    }
    
    func getSchedule(ur : String,completionHandler:((UIBackgroundFetchResult)->())!){
        print("hahaaa")
        let params : Parameters = ["event_name":"DesignFirst"]
        Alamofire.request(ur, method: .post, parameters: params)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print("ressss\(response.result)")
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    print("hereeee;e")
                    
                    let responseJSON = JSON(resultValue)
                    print("reser\(responseJSON)")
                    
                    if responseJSON["result"] == 1 {
                    
                    self.event_title = responseJSON["event_title"].string!
                    self.event_image = responseJSON["event_image"].string!
                    self.hostedby = responseJSON["hostedby"].string!
                    self.event_date = responseJSON["event_date"].string!
                        let scheduleArray = responseJSON["schedule"].array
                        for schedule in scheduleArray! {
                            self.schedule_title.append(schedule["schedule_title"].string!)
                            self.schedule_info.append(schedule["schedule_info"].string!)
                            self.schedule_time.append(schedule["schedule_time"].string!)
                            self.schedule_image.append(schedule["schedule_image"].string!)
                            self.schedule_hashtag.append(schedule["schedule_hashtag"].string!)
                            self.schedule_sname.append(schedule["schedule_speaker_name"].string!)
                     

                        
                        }
                        self.schedule_title.append("")
                        self.schedule_info.append("")
                        self.schedule_time.append("")
                        self.schedule_image.append("")
                        self.schedule_hashtag.append("")
                        self.schedule_sname.append("")
                    print("thehehe\(self.venue)")
                    }
                    else{
                        
                    }
                    DispatchQueue.main.async {
                        
                    }
                    completionHandler(UIBackgroundFetchResult.newData)
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrr")
                    DispatchQueue.main.async {
                        
                    }
                    //completionHandler(UIBackgroundFetchResult.newData)

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
    @IBAction func buyButAct(_ sender: Any) {
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scell", for: indexPath) as! SpeakerCollectionViewCell
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:  cell.contentView.layer.cornerRadius).cgPath
        cell.layer.masksToBounds = true;
        cell.layer.cornerRadius = 6;
         cell.heading.text = self.speaker_name_arr[indexPath.row]
        cell.img_grad.clipsToBounds = true
        cell.img_grad.layer.cornerRadius = 5
        cell.img.sd_setImage(with:  URL(string:speaker_image_arr[indexPath.row]))
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //eturn self.exploreEvents.count
        return self.speaker_name_arr.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "showspeaker", sender: self)
        tempI = indexPath.row
        
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> ExploreHeaderCollectionViewCell
    {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath as IndexPath) as! ExploreHeaderCollectionViewCell
        header.heading.text = "All Events"
        return header
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showspeaker" {
            let dv : SpeakerViewController = (segue.destination as? SpeakerViewController)!
            dv.nam = self.speaker_name_arr[tempI]
            dv.bio = self.speaker_about_arr[tempI]
            dv.img = self.speaker_image_arr[tempI]
            dv.works = self.speaker_works_at_arr[tempI]
            dv.talks = self.speaker_talks_about_arr[tempI]
        }
        else{
            let dv : scheduleViewController = (segue.destination as? scheduleViewController)!
             dv.event_title = self.titl!
             dv.event_image = self.event_image
             dv.hostedby = self.hostedby
             dv.event_date = self.event_date
//             dv.schedule_title = self.schedule_title
//             dv.schedule_info = self.schedule_info
//             dv.schedule_time = self.schedule_time
//             dv.schedule_image = self.schedule_image
//             dv.schedule_hashtag = self.schedule_hashtag
//             dv.schedule_sname = self.schedule_sname
             dv.loadschedule(schedule_title: self.schedule_title, schedule_info: self.schedule_info, schedule_time: self.schedule_time, schedule_image: self.schedule_image, schedule_hashtag: self.schedule_hashtag, schedule_sname: self.schedule_sname)
        }
    }


}
extension UIColor {
    
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x0000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
}
extension UIView {
    
    func dropShadow(scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}
extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var amPM: String         { return Formatter.amPM.string(from: self) }
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).uppercased()
        // or use capitalized(with: locale) if you want
    }
}
