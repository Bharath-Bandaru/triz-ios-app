//
//  scheduleTableViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 06/05/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class scheduleTableViewController: UITableViewController,IndicatorInfoProvider {
 
    var schedule_title = Array<String>()
    var schedule_info = Array<String>()
    var schedule_time = Array<String>()
    var schedule_image = Array<String>()
    var schedule_hashtag = Array<String>()
    var schedule_sname = Array<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
//       tv.reloadData()
        // Do any additional setup after loading the view.
    }
    var itemInfo = IndicatorInfo(title: "View")
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo,date: String,schedule_time: Array<String>,schedule_title: Array<String>,schedule_info: Array<String>,schedule_speaker: Array<String>,schedule_hashtag: Array<String>,schedule_image: Array<String>) {
        self.itemInfo.title = date
        self.schedule_image = schedule_image
        self.schedule_title = schedule_title
        self.schedule_hashtag = schedule_hashtag
        self.schedule_sname = schedule_speaker
        self.schedule_time = schedule_time
        self.schedule_info = schedule_info
    
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
     //   fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // 1
        // Return the number of sections.
        print("stimeee\(self.schedule_time.count)")
            return self.schedule_time.count
   
        
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
            return 6
 
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        cell.
                cell.heading?.text = self.schedule_title[indexPath.row]
                cell.matter?.text = self.schedule_info[indexPath.row]
                //cell.roomno?.text = roomsnos[(indexPath as NSIndexPath).section]
               let ur = self.schedule_image[indexPath.row]
               cell.imgv.sd_setImage(with: URL(string : ur))
               cell.imgname?.text = self.schedule_sname[indexPath.row]
        print("timmmm\(self.schedule_time)")

        
        
        
        return cell
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
