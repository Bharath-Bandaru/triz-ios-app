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

class scheduleViewController: ButtonBarPagerTabStripViewController {
    
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
    
    @IBOutlet weak var hostedbyO: UILabel!
    @IBOutlet weak var event_infoO: UILabel!
    @IBOutlet weak var event_imageO: UIImageView!
let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        event_infoO.text = self.event_title
        hostedbyO.text = self.hostedby
        print("urllll\(event_image)")
        event_imageO.sd_setImage(with: URL(string : event_image))

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }

        // Do any additional setup after loading the view.
    }

   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     override  func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
            let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child")
        let df = scheduleTableViewController(style: .plain, itemInfo: "Table View",date: event_date,schedule_time: schedule_time,schedule_title: schedule_title,schedule_info: schedule_info,schedule_speaker: schedule_sname,schedule_hashtag: schedule_hashtag,schedule_image: schedule_image)

            return [df]
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
