//
//  ViewController.swift
//  LoginScreenApp
//


import UIKit
import Alamofire
import SwiftyJSON
import SkyFloatingLabelTextField
import CryptoSwift
import SWRevealViewController
import KVNProgress
class LoginViewController: UIViewController {
    
    
    let login_url = "http://lowcost-env.hr2dk2nnep.us-west-2.elasticbeanstalk.com/account/login/level1"
    let cp_url = "http://lowcost-env.hr2dk2nnep.us-west-2.elasticbeanstalk.com/account/forgotpassword"

    
    @IBOutlet weak var fpass: UILabel!
    @IBOutlet var LoginView: UIView!
    @IBOutlet weak var gotoSignUp: UIButton!
    @IBOutlet var username_input: SkyFloatingLabelTextField!
    @IBOutlet var password_input: SkyFloatingLabelTextField!
    @IBOutlet var login_button: UIButton!
    
    var login_session:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        username_input.tintColor = UIColorFromRGB(rgbValue: <#T##UInt#>) // the color of the blinking cursor
//        username_input.textColor = UIColorFromRGB(rgbValue: <#T##UInt#>)
//        username_input.lineColor = UIColorFromRGB(rgbValue: <#T##UInt#>)
        username_input.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        username_input.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        password_input.selectedTitleColor = UIColor(rgbValue: 0xEC0070)
        password_input.selectedLineColor = UIColor(rgbValue: 0xEC0070)
        username_input.text = ""
        password_input.text = ""
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.fpassAction))
        fpass.isUserInteractionEnabled = true
       fpass.addGestureRecognizer(tap1)
        LoginView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.navigationController?.navigationBar.applyg(gradient: [UIColor(rgbValue :0xF02529) , UIColor(rgbValue :0xFF0D8D)])

        
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y = 0
            }
        }
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func fpassAction(){
        let alertController = UIAlertController(title: "Enter your email", message: "A random password will be generated to login", preferredStyle: .alert)
        
        
        
        
             let saveAction = UIAlertAction(title: "Send", style: .default, handler: {
            alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField

               

            self.sendEmailService(em: firstTextField.text!);
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Email ID"
            textField.text = self.username_input.text

        }
  
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
       // self.performSegue(withIdentifier: "fpass", sender: self)
    }
    
    func sendEmailService(em:String)
    {
        KVNProgress.show()
        let hmac = em+"_1234567890"
        let parameters: Parameters = ["username":em ,"hmac": hmac.sha1()]
        Alamofire.request(self.cp_url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                    //                    for index in responseJSON["responseCode"].array!{
                    //
                    //
                    //                    }
                    print("fffff: \(responseJSON["value"])")
                    let jo = responseJSON["value"]
                    if let pass = jo["password"].string{
                        let alertController = UIAlertController(title: jo["password"].string, message: "Please remember! Here is your new password to login", preferredStyle: .alert)
                        
                 
                        
                        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: {
                            (action : UIAlertAction!) -> Void in
                            
                        })
                        let copyAction = UIAlertAction(title: "Copy", style: .default, handler: {
                            (action : UIAlertAction!) -> Void in
                            UIPasteboard.general.string =  jo["password"].string
                            self.password_input.text = jo["password"].string
                            let alertController = UIAlertController(title: "Password copied to clipboard!", message: "", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: {
                                (action : UIAlertAction!) -> Void in
                                
                            })
                            alertController.addAction(cancelAction)

                            self.present(alertController, animated: true, completion: nil)


                        })

                      
                        
                        alertController.addAction(cancelAction)
                        alertController.addAction(copyAction)
                        self.present(alertController, animated: true, completion: nil)

                        
                        
                    }
                    else{
                        let alertController = UIAlertController(title: "Sorry!", message:"Somthing went wrong", preferredStyle: .alert)
                        self.present(alertController, animated: true, completion:nil)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        { (action:UIAlertAction) in
                            print("You've pressed OK button")
                        }
                        alertController.addAction(OKAction)
                    }
                    KVNProgress.dismiss()

                    DispatchQueue.main.async {
                        
                        
                    }
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrr")
                    KVNProgress.dismiss()
                    DispatchQueue.main.async {
                        
                    }
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                
                
                
                print("Background Fetch Complete")
    }
    }
    
    @IBAction func signUpAct(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"signup") as! SignUpViewController
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true)
        //        self.performSegue(withIdentifier: "signup", sender: self)
    }
    
    @IBAction func DoLogin(_ sender: AnyObject) {
        let sha =  "password" + username_input.text! + password_input.text!
        KVNProgress.show()
        if  self.username_input.text != "" && self.password_input.text != "" {
        let parameters: Parameters = ["username": username_input.text ?? "" ,"password": password_input.text ?? "" ,"granttype":  "password" ,"hmac": (sha + "_1234567890").sha1()]
        Alamofire.request(self.login_url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                    //                    for index in responseJSON["responseCode"].array!{
                    //
                    //
                    //                    }
                    if let o = responseJSON["value"].array {
                    }
                    else if  let o = responseJSON["value"].dictionaryObject{
                        let preferences = UserDefaults.standard
                        
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "secondtime")
                        print("logged in")
                        defaults.set(self.username_input.text, forKey: "email")
                        defaults.set(o["token"], forKey: "token")
                        defaults.set(o["user_uuid"], forKey: "uuid")
                        let view: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "explore") as! SWRevealViewController
                        self.present(view, animated: true, completion: nil)

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
                        
                        
                        
                    }
                    KVNProgress.dismiss()

                    DispatchQueue.main.async {
                        
                        
                    }
                    
                    break
                case .failure(let error):
                    NSLog("Error result: \(error)")
                    print("Errrrrrr")
                    KVNProgress.dismiss()

                    DispatchQueue.main.async {
                        
                    }
                    // Here I call a completionHandler I wrote for the failure case
                    return
                }
                
                
                
                print("Background Fetch Complete")
                
                
        }
    
    }
    else if self.username_input.text == "" {
            let alertController = UIAlertController(title: "Enter Username", message: "Please enter your username", preferredStyle: .alert)
            self.present(alertController, animated: true, completion:nil)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)

    
    }
    else if self.password_input.text == "" {
            let alertController = UIAlertController(title: "Enter Password", message: "Please enter your password", preferredStyle: .alert)
            self.present(alertController, animated: true, completion:nil)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("You've pressed OK button");
            }
            alertController.addAction(OKAction)

    }
    else{
    
    }
    }
}
extension UIColor {
    convenience init(rgbValue: UInt) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
