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
    
    let testJsonEndpoint: String = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/test/grades.json"
    let jsonEndpoint: String = "https://users.csc.calpoly.edu/~bellardo/cgi-bin/grades.json"
    
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
        
        urlField.text = self.testJsonEndpoint
        
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
        urlField.text = self.testJsonEndpoint
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
        let loader = GradebookURLLoader()
        loader.baseURL = NSURL(string: self.jsonEndpoint)!
        if loader.loginWithUsername(usernameField.text!, andPassword: passwordField.text!) {
            print("Auth worked!")
            
            let data = try? loader.loadDataFromPath("?record=sections")
            
            if let data = try? loader.loadDataFromPath("?record=sections") {
                self.fetchedJSONData = JSON(nsdataToJSON(data)!)
                print("data json: ", fetchedJSONData)
            }
            
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            print("Data: \(str)")
            self.performSegueWithIdentifier("LoginSuccessful", sender: self)
        }
        else {
            print("Auth failed!")
            self.presentAlert("Authentication error", alertMessage: "Authentication failed. Check your credentials!", dismissMessage: "Ok")
        }
    }
    
    // MARK: JSON
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
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
