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
import Locksmith

class SignInViewController: UIViewController {

    @IBOutlet weak var loginContainer: UIView!

    @IBOutlet var loginButton: UIButton!
    @IBOutlet var testLoginButton: UIButton!
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var urlField: UITextField!
    
    let jsonEndpoint: String = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/grades.json"
    
    let loader = GradebookURLLoader()
    
    var fetchedJSONData: JSON!
    
    struct GradeBookAccount: ReadableSecureStorable,
        CreateableSecureStorable,
        DeleteableSecureStorable,
    GenericPasswordSecureStorable {
        let username: String
        let password: String
        
        let service = "GradeBook"
        var account: String { return username }
        var data: [String: AnyObject] {
            return ["password": password]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loader.baseURL = NSURL(string: self.jsonEndpoint)!
        
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
    
    override func viewDidAppear(animated: Bool) {
        if checkPreviousUser() {
            let alert = UIAlertController(title: "Continuing", message: "Continuing as previous user?", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { action in
                self.continueAsPreviousUser(self)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
    }
    
    // MARK: - Login

    func checkPreviousUser() -> Bool {
        let credentials = Locksmith.loadDataForUserAccount("currentUser")
        if credentials == nil {
            return false
        }
        
        for (key, value) in credentials! {
            if self.loader.loginWithUsername((key), andPassword: value as! String) {
                return true
            } else {
                print("Could not load user data")
                presentAlert("Keychain error", alertMessage: "Could not login with previous login credentials", dismissMessage: "OK")
                return false
            }
        }
        return false
    }

    
    func saveCurrentUser(username: String, password: String) {
        try! Locksmith.saveData([username:password], forUserAccount: "currentUser")
    }

    @IBAction func continueAsPreviousUser(sender:AnyObject) {
        self.performSegueWithIdentifier("LoginSuccessful", sender: self)
    }
    
    @IBAction func checkCredentials(sender: AnyObject) {
        if usernameField.text != "" && passwordField.text != "" && urlField != "" {
            login(sender)
        } else {
            presentAlert("Authentication error", alertMessage: "All fields are required for authentication.", dismissMessage: "Ok")
        }
    }
    
    @IBAction func login(sender: AnyObject) {
        if self.loader.loginWithUsername(usernameField.text!, andPassword: passwordField.text!) {
            print("Auth worked!")
            saveCurrentUser(usernameField.text!, password: passwordField.text!)
            self.performSegueWithIdentifier("LoginSuccessful", sender: self)
        }
        else {
            print("Auth failed!")
            self.presentAlert("Authentication error", alertMessage: "Authentication failed. Check your credentials!", dismissMessage: "Ok")
        }
    }
    
    // MARK: - Alerts
    
    func presentAlert(alertTitle: String, alertMessage: String, dismissMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: dismissMessage, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "LoginSuccessful") {
            
            let navController = segue.destinationViewController as! UINavigationController
            let tabBarController = navController.viewControllers.first as! UITabBarController
            let destionationController = tabBarController.viewControllers!.first as! GradeController
            
            destionationController.fetchedJSONData = self.fetchedJSONData
            destionationController.loader = self.loader
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
