//
//  AboutUsViewController.swift
//  Triz
//
//  Created by Bharath Bandaru on 19/06/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBAction func closeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var close: UIBarButtonItem!
    @IBOutlet weak var gradview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.applyg(gradient: [UIColor(rgbValue :0xF02529) , UIColor(rgbValue :0xFF0D8D)])
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        // Do any additional setup after loading the view.
    }
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                break
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                closeAction("")
               //navigationController?.popViewController(animated: true)
                //dismiss(animated: true, completion: nil)
                break
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                break
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                break
            default:
                break
            }
        }
    }
    @IBOutlet weak var scroll_view: UIScrollView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async(execute: {() -> Void in
            let path = UIBezierPath(roundedRect:self.gradview.bounds, byRoundingCorners:[.topLeft, .topRight], cornerRadii: CGSize(width :15, height : 15))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.gradview.bounds;
            maskLayer.path = path.cgPath
            self.gradview.layer.mask = maskLayer;
            let backItem = UIBarButtonItem()
            backItem.title = "Home"
            self.navigationItem.backBarButtonItem = backItem
            
//            self.scroll_view.contentSize = CGSize(width: 375, height: 740);
        })
        
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
