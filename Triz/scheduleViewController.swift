//
//  scheduleViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 06/05/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import SDWebImage
import  XLPagerTabStrip

class scheduleViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
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
    
    @IBOutlet weak var wview: UIView!
    @IBOutlet weak var stable: UITableView!
    @IBOutlet weak var sscroll: UIScrollView!
    @IBOutlet weak var hostedbyO: UILabel!
    @IBOutlet weak var event_infoO: UILabel!
    @IBOutlet weak var event_imageO: UIImageView!
    
    @IBOutlet weak var spscroll: UIView!
    
    @IBOutlet weak var tasp: NSLayoutConstraint!
    @IBOutlet weak var scrollns: NSLayoutConstraint!
    @IBOutlet weak var topc: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var heigt : CGFloat?
    
    //let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        
        //        settings.style.buttonBarBackgroundColor = .white
        //        settings.style.buttonBarItemBackgroundColor = .white
        //        settings.style.selectedBarBackgroundColor = purpleInspireColor
        //        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        //        settings.style.selectedBarHeight = 2.0
        //        settings.style.buttonBarMinimumLineSpacing = 0
        //        settings.style.buttonBarItemTitleColor = .black
        //        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        //        settings.style.buttonBarLeftContentInset = 0
        //        settings.style.buttonBarRightContentInset = 0
        
        event_infoO.text = self.event_title
        hostedbyO.text = self.hostedby
        print("urllll\(event_image)")
        event_imageO.sd_setImage(with: URL(string : event_image))
        
        
        self.event_imageO.layer.cornerRadius = 5.0
        self.event_imageO.clipsToBounds = true
        self.event_imageO.layer.shadowColor = UIColor.darkGray.cgColor
        self.event_imageO.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.event_imageO.layer.shadowRadius = 2.0
        self.event_imageO.layer.shadowOpacity = 5.0
        self.event_imageO.layer.masksToBounds = false
        self.event_imageO.layer.shadowPath = UIBezierPath(roundedRect: self.event_imageO.bounds, cornerRadius: self.event_imageO.layer.cornerRadius).cgPath
        
        
        
        
        //        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
        //            guard changeCurrentIndex == true else { return }
        //            oldCell?.label.textColor = .black
        //            newCell?.label.textColor = self?.purpleInspireColor
        //        }
        //
        // Do any additional setup after loading the view.
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: {() -> Void in
            let path = UIBezierPath(roundedRect:self.wview.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width :15, height : 15))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.wview.bounds;
            maskLayer.path = path.cgPath
            self.wview.layer.mask = maskLayer;
            let height = min(self.view.bounds.size.height, self.stable.contentSize.height)
            self.tasp.constant = height
            self.view.layoutIfNeeded()
            self.sscroll.contentSize.height =  height + self.topc.constant/2
            self.heigt =  self.sscroll.contentSize.height
            
        })
        
    }
    
    
    func loadschedule( schedule_title : Array<String>,  schedule_info : Array<String>, schedule_time : Array<String>, schedule_image : Array<String>, schedule_hashtag : Array<String>, schedule_sname : Array<String>){
        
        // var schedule_title = schedule_title
        self.schedule_title = schedule_title
        self.schedule_info = schedule_info
        self.schedule_time = schedule_time
        self.schedule_image = schedule_image
        self.schedule_hashtag = schedule_hashtag
        self.schedule_sname = schedule_sname
    }
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //               navigationController?.hidesBarsOnSwipe = true
    //
    //    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        //        if yOffset == self.heigt{
        //            self.sscroll.isScrollEnabled = false
        //            self.stable.isScrollEnabled = true
        //        }
        //        print("yoff\(yOffset)")
        var fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.5
        fadeTextAnimation.type = kCATransitionFade
        if scrollView == self.sscroll {
            if yOffset >= self.topc.constant {
                self.sscroll.isScrollEnabled = false
                self.stable.isScrollEnabled = true
                
                    self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "DesignFirst")
                    self.navigationItem.title = "DesignFirst";
                    
                    
                
            }
        }
        
        if scrollView == self.stable {
            if yOffset <= 0 {
                self.sscroll.isScrollEnabled = true
                self.stable.isScrollEnabled = false
                UIView.animate(withDuration: 1.0, animations: {
                    self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "")
                    self.navigationItem.title = "";
                    
                    
                })
            }
        }
    }
    //    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        let yOffset = scrollView.contentOffset.y
    //        if yOffset == self.heigt{
    //            self.sscroll.isScrollEnabled = false
    //            self.stable.isScrollEnabled = true
    //        }
    //        print("yoff\(yOffset)")
    //    }
    //    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        let translation: CGPoint = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
    //        var fadeTextAnimation = CATransition()
    //        fadeTextAnimation.duration = 0.5
    //        fadeTextAnimation.type = kCATransitionFade
    //
    //        if translation.y > 0 {
    //            // react to dragging down
    //            UIView.animate(withDuration: 1.0, animations: {
    //                self.sscroll.contentOffset = CGPoint(x: 0, y: 0)
    //                self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "")
    //                self.navigationItem.title = "";
    //
    //
    //            })
    //                       print()
    //        }
    //        else {
    //            UIView.animate(withDuration: 2.0, animations: {
    //                self.sscroll.contentOffset = CGPoint(x: 0, y: self.spscroll.layer.bounds.height)
    //                self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "DesignFirst")
    //                self.navigationItem.title = "DesignFirst";
    //
    //
    //            })
    //                  }
    //    }
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //     override  func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    //
    //        let df = scheduleTableViewController(style: .plain, itemInfo: "Table View",date: event_date,schedule_time: schedule_time,schedule_title: schedule_title,schedule_info: schedule_info,schedule_speaker: schedule_sname,schedule_hashtag: schedule_hashtag,schedule_image: schedule_image)
    //
    //            return [df]
    //        }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
        //        if imagenames[(indexPath as NSIndexPath).section]  == ""
        //        {
        //            return nil
        //        }
        //    else if imagenames1[(indexPath as NSIndexPath).section] != "" || section3imagesnames1[(indexPath as NSIndexPath).row] != "" || section5imagesnames1[(indexPath as NSIndexPath).row] != "" || section6imagesnames1[(indexPath as NSIndexPath).row] != ""{
        //                      return indexPath
        //                }
        //        else if imagenames2[(indexPath as NSIndexPath).section] != "" || section3imagenames2[(indexPath as NSIndexPath).row] != "" || section5imagenames2[(indexPath as NSIndexPath).row] != ""{
        //            return indexPath
        //        }
        //        else{
        return indexPath
        //        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        print("stimeee\(self.schedule_time.count)")
        return self.schedule_time.count
        
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MatterTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MatterTableViewCell
        
        
        cell.heading?.text = self.schedule_title[(indexPath as NSIndexPath).section]
        cell.matter?.text = self.schedule_info[(indexPath as NSIndexPath).section]
        cell.roomno?.text = self.schedule_hashtag[(indexPath as NSIndexPath).section]
        let ur = self.schedule_image[(indexPath as NSIndexPath).section]
        cell.imgv.sd_setImage(with: URL(string : ur))
        cell.imgname?.text = self.schedule_sname[(indexPath as NSIndexPath).section]
        print("timmmm\(self.schedule_time)")
        //        if self.sc hedule_info[(indexPath as NSIndexPath).section + 1] != "" {
        //            self.schedule_time.remove(at: (indexPath as NSIndexPath).section + 1)
        //        }
        //        else{
        //
        //        }
        
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CustomHeaderCell
        
        headerCell.headerLabel.text = self.schedule_time[section];
        
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section < self.schedule_time.count - 2{
            if self.schedule_info[section+1] == ""
            {
                print("one")
                return 40.0
            }
            else {
                print("zero")
                
                return 0
            }
            
        }
        else {
            print("zero")
            
            return 0
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 35))
        
        
        footerView.backgroundColor = UIColor(rgbValue : 0xFF0D8D)
        
        let version = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        version.font = version.font.withSize(15)
        version.textColor = UIColor.white
        version.center = CGPoint(x: footerView.bounds.size.width - 50, y: 20)
        version.translatesAutoresizingMaskIntoConstraints = true
        footerView.addSubview(version)
        let version1 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        version1.font = version.font.withSize(15)
        version1.textColor = UIColor.white
        version1.center = CGPoint(x :110, y: 20)
        version1.translatesAutoresizingMaskIntoConstraints = true
        footerView.addSubview(version1)
        
        
        //        let footerView1 = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        //
        //
        //        footerView1.backgroundColor = UIColorFromRGB(0x4D3291)
        //
        //        let version2 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        //        version2.font = version2.font.withSize(15)
        //        version2.textColor = UIColor.white
        //        version2.center = CGPoint(x: footerView1.bounds.size.width - 50, y: 20)
        //        version2.translatesAutoresizingMaskIntoConstraints = true
        //        footerView1.addSubview(version2)
        //        let version3 = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        //        version3.font = version.font.withSize(15)
        //        version3.textColor = UIColor.white
        //        version3.center = CGPoint(x :110, y: 20)
        //        version3.translatesAutoresizingMaskIntoConstraints = true
        //        footerView1.addSubview(version3)
        
        if self.schedule_title[section+1] == "Coffee Break"
        {
            version.text = self.schedule_time[section+1]
            version1.text = self.schedule_title[section+1]
            
        }
        else     if self.schedule_title[section+1] == "Lunch Break"
        {
            version.text = self.schedule_time[section+1]
            version1.text = self.schedule_title[section+1]
            
        }
        else {
            print("zero")
            
        }
        return footerView
        
    }
    
}
