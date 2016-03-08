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
    
    var fetchedSectionJSONData: JSON!
    
    var loader: GradebookURLLoader!
    
    var userInformation: [Enrollments] = [Enrollments]()
    var sections: [Section] = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = try? self.loader.loadDataFromPath("?record=sections") {
            self.fetchedSectionJSONData = JSON(nsdataToJSON(data)!)
        }
        
        parseSectionJSON(fetchedSectionJSONData)
        
        
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.width / 2
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
    }
    
    // MARK: JSON
    func parseSectionJSON(jsonData: JSON) {
        if let sections = jsonData["sections"].array {
            print(sections.count)
            for section in sections {
                let currentSection = Section(
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
    
    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
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

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EnrollmentDetail", let destination = segue.destinationViewController as? EnrollmentController {
            if let cell = sender as? GradeCell, let indexPath = tableView.indexPathForCell(cell) {
                var current = self.sections[indexPath.row]
                destination.loader = self.loader
                destination.currentSection = current
            }
        }
    }

}
