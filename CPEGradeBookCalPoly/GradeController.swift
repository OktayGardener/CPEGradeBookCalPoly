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
    let enrollments: String = "?record=enrollments&term=<TERM>&course=<COURSE>"
    
    
    var fetchedJSONData: JSON!
    
    var userInformation: [String:AnyObject] = [String:AnyObject]()
    
    // TODO: Below is a ratchet mess that needs to be refactored into modules.
    
    // Section data
    var sectionData: [String:AnyObject] = [String:AnyObject]()
    
    var sectionID: Int!
    var polynum: Int!
    var courseNumber: Int!
    
    var term: String!
    var termname: String!
    var dept: String!
    var courseTitle: String!
    
    var firstDay: UInt32!
    var secondDay: UInt32!
    
    // Enrollment, student specific data
    var enrollmentData: [String:AnyObject] = [String:AnyObject]()
    
    var enrollmentID: Int!
    var role: Int!
    var dropped: Int!
    var admimFailure: Int!
    var ferpa: Int!
    var emplID: Int!
    var canEditEnrollment: Int!
    var studentAge: Int! // age = year
    
    var major: String!
    var firstName: String!
    var middleName: String!
    var lastName: String!
    var bbId: String!
    var username: String!
    var cscUsername: String!
    
    // Image data
    var imageData: [String:AnyObject] = [String:AnyObject]()
    
    var imageID: Int!
    var imageType: String!
    var imageFileExtension: String!
    var imageURL: NSURL!
    
    // User scores
    var userScores: [String:AnyObject] = [String:AnyObject]()
    
    var userScoreID: Int!
    var maxPoints: Int!
    
    var assignmentName: String!
    
    var extraCreditAllowed: Int!
    var emailNotification: Int!
    var sortOrder: Int!
    var computeFunc: Int!
    var displayType: Int!
    
    var dueDate: UInt32!
    
    // Assignment scores
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("fetchedJSON from GradeController: \(fetchedJSONData)")
        parseJSON(fetchedJSONData)
        
        /* Navbar test */
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44)) // Offset by 20 pixels vertically to take the status bar into account
        navigationBar.backgroundColor = UIColor.whiteColor()
        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Title"
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Save", style:   UIBarButtonItemStyle.Plain, target: self, action: "btn_clicked:")
        let rightButton = UIBarButtonItem(title: "Right", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: JSON
    func parseJSON(jsonData: JSON) {
        var currentSection: [String: AnyObject] = [String:AnyObject]()
        print("parseJSON:\(jsonData)")
        
//        if let userName = json[0]["user"]["name"].string {
//            //Now you got your value
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
