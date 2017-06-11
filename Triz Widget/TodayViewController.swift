//
//  TodayViewController.swift
//  Triz Widget
//
//  Created by Laxmi Rekha on 07/06/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        img1.isUserInteractionEnabled = true
        img1.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer2:)))
        img2.isUserInteractionEnabled = true
        img2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped3(tapGestureRecognizer3:)))
        img3.isUserInteractionEnabled = true
        img3.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped4(tapGestureRecognizer4:)))
        img4.isUserInteractionEnabled = true
        img4.addGestureRecognizer(tapGestureRecognizer4)
        // Do any additional setup after loading the view from its nib.
    }
    
    func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("HERE")
        extensionContext?.open(URL(string: "foo://")! , completionHandler: nil)

        
        // Your action
    }
    
    func imageTapped2(tapGestureRecognizer2: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer2.view as! UIImageView
        print("HERE")
        extensionContext?.open(URL(string: "foo://")! , completionHandler: nil)



        
        // Your action
    }
    func imageTapped3(tapGestureRecognizer3: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer3.view as! UIImageView
        print("HERE")
        extensionContext?.open(URL(string: "foo://")! , completionHandler: nil)



        
        // Your action
    }
    func imageTapped4(tapGestureRecognizer4: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer4.view as! UIImageView
        print("HERE")
        extensionContext?.open(URL(string: "foo://")! , completionHandler: nil)

        
        // Your action
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
