//
//  SettingsController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 28/02/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    var settingItems = [Int : [Int:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingItems[0] = [1: "logout", 2: "bye felicia"]
        settingItems[1] = [1: "about", 2: "wat is dis"]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: About view
    func presentAboutView() {
        performSegueWithIdentifier("presentAboutViewController", sender: nil)
    }
    
    // MARK: Log out

    func handleLogOut() {
        let alert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:{_ in self.logOut()}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func logOut() {
        print("logout called")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInViewController: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("SignInViewController")
        presentViewController(signInViewController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.settingItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell", forIndexPath: indexPath) as! SettingsCell
        if let entry = settingItems[indexPath.row] {
            for (key, value) in entry {
                switch key {
                    case _ where (key == 1): cell.titleLabel.text = value
                    case _ where (key == 2): cell.descriptionLabel.text = value
                    default: break
                }
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
            case 0: self.handleLogOut()
            case 1: self.presentAboutView()
            default: break
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
