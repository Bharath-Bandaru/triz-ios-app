//
//  ForgotPasswordViewController.swift
//  Triz
//
//  Created by Laxmi Rekha on 01/04/17.
//  Copyright © 2017 um. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import SwiftyJSON

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var newpass: SkyFloatingLabelTextField!
    @IBOutlet weak var oldpass: SkyFloatingLabelTextField!
    @IBOutlet weak var confnewpass: SkyFloatingLabelTextField!
    @IBOutlet weak var changepassbut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        newpass.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        newpass.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        oldpass.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        oldpass.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        confnewpass.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        confnewpass.selectedLineColor = UIColor(rgbValue: 0xEC0070)

        self.changepassbut.clipsToBounds = true
       self.changepassbut.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    @IBAction func changepass(_ sender: Any) {
        
        if self.newpass.text == self.confnewpass.text {
        let parameters: Parameters = ["old_password": self.oldpass.text ,"new_password": self.confnewpass.text ,"user_uuid":  "1" ,"hmac": ""]
        Alamofire.request("https://private-anon-f1146a6b19-conferenceapp1.apiary-mock.com/manageuser/changepassword", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
           
                    print("fffff: \(responseJSON["status"])")
                    if(responseJSON["status"]==1 ){
                        let alertController = UIAlertController(title: "Success", message: "Password changed successfully", preferredStyle: .alert)
                        self.present(alertController, animated: true, completion:nil)

                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { (action:UIAlertAction) in
                            print("You've pressed OK button")

                            let view: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                            let navController = UINavigationController(rootViewController: view)
                            self.present(navController, animated: true, completion: nil)
                            

                        }
                        alertController.addAction(OKAction)

                    }
                    DispatchQueue.main.async {
                        
                        
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
        else{
            self.newpass.text=""
            self.confnewpass.text = ""
            let alertController = UIAlertController(title: "Passwords not matched", message: "Please reenter your new password", preferredStyle: .alert)
            self.present(alertController, animated: true, completion:nil)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button")
            }
                alertController.addAction(OKAction)



        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
