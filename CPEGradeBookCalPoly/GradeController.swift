//
//  GradeController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 28/02/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit
import SwiftyJSON

class GradeController: UITableViewController, UINavigationBarDelegate {
    
    @IBOutlet var welcomeLabel: UILabel! = UILabel()
    @IBOutlet var userAvatar: UIImageView! = UIImageView()
    
    let enrollments: String = "?record=enrollments&term=<TERM>&course=<COURSE>"
    
    var fetchedJSONData: JSON!
    
    var userInformation: [String:AnyObject] = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("fetchedJSON from GradeController: \(fetchedJSONData)")
        parseJSON(fetchedJSONData)
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.width / 2
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: JSON
    func parseJSON(jsonData: JSON) {
        var currentSection: [String: AnyObject] = [String:AnyObject]()
        print("parseJSON:")
        
        for section in jsonData["sections"] {
            // how to know how many sections? for 0..<section.length? no. lol maybe
            3
        }
        
        if let dept = jsonData["sections"]["dept"].string {
            print("second ", dept)
        }
        
        for (key,subJson):(String, JSON) in jsonData {
            print(key, subJson)
        }
        
//        if let userName = json[0]["user"]["name"].string {
//            //Now you got your value
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableViewHeader
    func resetTableViewHeaderView() {
        self.tableView.beginUpdates()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userInformation.count
    }

    // TODO: Look up how to make an expandable cell.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! GradeCell
        
        return cell
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
