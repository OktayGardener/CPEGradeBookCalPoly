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
    
    var userInformation: [Enrollments] = [Enrollments]()
    var sections: [Section] = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseSectionJSON(fetchedJSONData)
        
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.width / 2
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: JSON
    func parseSectionJSON(jsonData: JSON) {
        if let sections = jsonData["sections"].array {
            print(sections.count)
            for section in sections {
                var currentSection = Section(
                id: section["id"].int!,
                polynum: section["polynum"].int!,
                term: section["term"].int!,
                termName: section["termname"].string!,
                dept: section["dept"].string!,
                courseNumber: section["course"].string!,
                courseTitle: section["title"].string!,
                firstDay: NSDate(timeIntervalSince1970: NSTimeInterval(section["first_day"].int!)),
                lastDay: NSDate(timeIntervalSince1970: NSTimeInterval(section["last_day"].int!)))
                
                self.sections.append(currentSection)
            }
        }
        self.tableView.reloadData()
    }
// TODO:
    // Implement Locksmith and store accounts, cache whats needed
    // GradeController->EnrollmentController->SubmissionController?
    // Make sure JSON requests and parsing is happening where they should be
      // request info about student first login, cache it maybe
    // Autolayout
    // Done
    
//    func retrieveEnrollmentJSON(term: Int, course: String) -> JSON {
//        
//    }
//    
//    func parseEnrollmentJSON(jsonData: JSON) {
//        if let sections = jsonData["sections"].array {
//            print(sections.count)
//            for section in sections {
//                var currentSection = Section(
//                    id: section["id"].int!,
//                    polynum: section["polynum"].int!,
//                    term: section["term"].int!,
//                    termName: section["termname"].string!,
//                    dept: section["dept"].string!,
//                    courseNumber: section["course"].string!,
//                    courseTitle: section["title"].string!,
//                    firstDay: NSDate(timeIntervalSince1970: NSTimeInterval(section["first_day"].int!)),
//                    lastDay: NSDate(timeIntervalSince1970: NSTimeInterval(section["last_day"].int!)))
//                
//                self.sections.append(currentSection)
//            }
//        }
//        self.tableView.reloadData()
//    }
    
    
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
        return sections.count
    }

    // TODO: Look up how to make an expandable cell.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GradeCell", forIndexPath: indexPath) as! GradeCell
        let current = self.sections[indexPath.row]
        
        cell.courseName.text = current.courseTitle
        cell.courseNumber.text = current.courseNumber
        cell.dept.text = current.dept
        cell.termName.text = current.termName
        cell.startDate.text = String(current.firstDay)
        cell.endDate.text = String(current.lastDay)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
