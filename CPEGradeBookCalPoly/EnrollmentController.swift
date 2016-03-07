//
//  EnrollmentController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 06/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit
import SwiftyJSON

class EnrollmentController: UITableViewController, UINavigationBarDelegate {
    // Properties via segue from GradeController
    var loader: GradebookURLLoader!
    var currentSection: Section!
    
    var fetchedUserInformationJSONData: JSON!
    
    let enrollmentSuffix: String = "?record=enrollments&term=<TERM>&course=<COURSE>"
    
    var enrollments: [Enrollments] = [Enrollments]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestEnrollmentJSON()
        parseEnrollmentJSON(self.fetchedUserInformationJSONData)
    }
    
    // MARK: JSON
    
    func parseEnrollmentJSON(jsonData: JSON) {
        if let enrollments = jsonData["enrollments"].array {
            print(enrollments.count)
            for enrollment in enrollments {
                print(enrollment)
            }
        }
    }
    
        func requestEnrollmentJSON() {
            if let currentSection = currentSection {
                let path = self.enrollmentSuffix
                    .stringByReplacingOccurrencesOfString("<TERM>", withString: String(currentSection.term))
                    .stringByReplacingOccurrencesOfString("<COURSE>", withString: currentSection.courseNumber)
                if let data = try? self.loader.loadDataFromPath(path) {
                    self.fetchedUserInformationJSONData = JSON(nsdataToJSON(data)!)
                }
            }
        }
        
        func nsdataToJSON(data: NSData) -> AnyObject? {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            } catch let myJSONError {
                print(myJSONError)
            }
            return nil
        }
        
        // MARK: - Table view data source
        
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return enrollments.count
        }
        
        // TODO: Look up how to make an expandable cell.
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("GradeCell", forIndexPath: indexPath) as! GradeCell
            let current = self.enrollments[indexPath.row]
            
            return cell
        }
        
        // TODO:
        // Finish Enrollment
        // Finish last parsing
        // Autolayout
        // Done
}