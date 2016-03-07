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
    var loader: GradebookURLLoader!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
    
}