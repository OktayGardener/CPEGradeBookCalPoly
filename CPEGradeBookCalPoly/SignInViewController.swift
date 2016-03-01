//
//  SignInViewController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 28/02/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {

    @IBOutlet weak var loginContainer: UIView!

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var testLoginButton: UIButton!
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var urlField: UITextField!
    
    let jsonEndpoint: String = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/test/grades.json"
    
    var fetchedJSONData: JSON!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlField.text = self.jsonEndpoint
        
        self.loginContainer.layer.cornerRadius = self.loginContainer.frame.size.width / 16
        
        let originalFrame: CGRect = self.loginContainer.frame
        self.loginContainer.alpha = 0.0
        
        UIView.animateWithDuration(1.5) { () -> Void in
            self.loginContainer.frame = CGRectMake(0, 0, self.loginContainer.frame.width, self.loginContainer.frame.height)
            self.loginContainer.alpha = 1.0
            self.loginContainer.frame = originalFrame
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
    }
    
    // MARK: Login
    
    @IBAction func testLogin(sender: AnyObject) {
        urlField.text = self.jsonEndpoint
        usernameField.text = "test"
        passwordField.text = "xSTUULjV"
        login(sender)
    }
    
    @IBAction func checkCredentials(sender: AnyObject) {
        if usernameField.text != "" && passwordField.text != "" && urlField != "" {
            login(sender)
        } else {
            presentAlert("Authentication error", alertMessage: "All fields are required for authentication.", dismissMessage: "Ok")
        }
    }
    
    func presentAlert(alertTitle: String, alertMessage: String, dismissMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: dismissMessage, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func login(sender: AnyObject) {
        let gradesEndpoint = self.jsonEndpoint + "?record=sections"
        Alamofire.request(.GET, gradesEndpoint)
            .authenticate(user: usernameField.text!, password: passwordField.text!)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        self.fetchedJSONData = JSON(value)
                        print("JSON: \(self.fetchedJSONData)")
                        self.performSegueWithIdentifier("LoginSuccessful", sender: self)
                    }
                case .Failure(let error):
                    print(error)
                    print("Auth failed!")
                    self.presentAlert("Authentication error", alertMessage: "Authentication failed. Check your credentials!", dismissMessage: "Ok")
                }
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoginSuccessful") {
            
            let navController = segue.destinationViewController as! UINavigationController
            let tabBarController = navController.viewControllers.first as! UITabBarController
            let destionationController = tabBarController.viewControllers!.first as! GradeController
            
            destionationController.fetchedJSONData = self.fetchedJSONData
        }
    }
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
