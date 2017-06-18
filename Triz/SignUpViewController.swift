//
//  SignUpViewController.swift
//  LoginScreenApp
//
//  Copyright © 2017 kaleidosstudio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField
import CryptoSwift

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var signUpView: UIView!
    @IBOutlet weak var lastname: SkyFloatingLabelTextField!
    @IBOutlet weak var mobile: SkyFloatingLabelTextField!
    @IBOutlet weak var pass: SkyFloatingLabelTextField!
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var namw: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lastname.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        lastname.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        namw.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        namw.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        email.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        email.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        mobile.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        mobile.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        pass.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        pass.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        signUpView.addGestureRecognizer(tap)
        self.navigationController?.navigationBar.applyg(gradient: [UIColor(rgbValue :0xF02529) , UIColor(rgbValue :0xFF0D8D)])

     //   NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= keyboardSize.height
            
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    @IBAction func LoginButAct(_ sender: Any) {
        self.performSegue(withIdentifier: "logins", sender: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController :LoginViewController = storyboard.instantiateViewController(withIdentifier :"LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(viewController, animated: true)
          }
    
    @IBAction func completeSignUp(_ sender: Any) {
      //  print("shaaaa ....\("harshithharshith313@gmail.comTriz&1234Triz&1234_1234567890".sha1())")
       let sha =  namw.text! + email.text! + pass.text! + mobile.text!
        let parameters: Parameters = ["email": email.text ,"password": pass.text ,"confirmpassword": pass.text ,"name":  namw.text ,"hmac": (sha + "_1234567890").sha1(),"requesttype" : 2]
        Alamofire.request("http://lowcost-env.hr2dk2nnep.us-west-2.elasticbeanstalk.com/account/signup", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                print("resssss \(response)")
                switch response.result {
                case .success( _):
                    guard let resultValue = response.result.value else {
                        NSLog("Result value in response is nil")
                        return
                    }
                    
                    let responseJSON = JSON(resultValue)
                    //                    for index in responseJSON["responseCode"].array!{
                    //
                    //
                    //                    }
                    let o = responseJSON["value"].array?[0]["errors"][0]
                    if  let msg = o?["errorMessage"].string {
                            let alertController = UIAlertController(title: "Error", message: o?["errorMessage"].string, preferredStyle: .alert)
                            self.present(alertController, animated: true, completion:nil)
                        
                            let OKAction = UIAlertAction(title: "OK", style: .default)
                            { (action:UIAlertAction) in
                                print("You've pressed OK button")
                            }
                            alertController.addAction(OKAction)
                    }
                    else if(responseJSON["requesttype"] == 2 ){
                        let alertController = UIAlertController(title: "Success", message: "SignUp successful!", preferredStyle: .alert)
                        self.present(alertController, animated: true, completion:nil)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { (action:UIAlertAction) in
                            print("You've pressed OK button")
                        }
                        alertController.addAction(OKAction)
                        
                    }
                    else {
                        let alertController = UIAlertController(title: "", message: responseJSON["value"].string, preferredStyle: .alert)
                        self.present(alertController, animated: true, completion:nil)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { (action:UIAlertAction) in
                            print("You've pressed OK button")
                        }
                        alertController.addAction(OKAction)

                    }
                    
                    

                    
                    print("fffff: \(responseJSON["status"])")
                    if(responseJSON["status"]==1 ){
                        
                        let preferences = UserDefaults.standard
                        
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "secondtime")
                        print("logged in")
                        defaults.set(self.namw.text, forKey: "email")
                        
                        let view: ExploreViewController = self.storyboard?.instantiateViewController(withIdentifier: "explore") as! ExploreViewController
                        let navController = UINavigationController(rootViewController: view)
                        self.present(navController, animated: true, completion: nil)
                        
                        
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
