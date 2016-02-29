//
//  SignInViewController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 28/02/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var loginButton: UIButton!
    
    @IBAction func loginTapped() {
        self.performSegueWithIdentifier("LoginSuccessful", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
