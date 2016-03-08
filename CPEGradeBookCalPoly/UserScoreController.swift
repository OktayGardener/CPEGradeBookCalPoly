//
//  UserScoreController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 07/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//


import UIKit
import SwiftyJSON

class UserScoreController: UITableViewController, UINavigationBarDelegate {
    // Properties via segue from GradeController
    var loader: GradebookURLLoader!
    var currentSection: Section!
    
    var fetchedUserInformationJSONData: JSON!
    let enrollmentSuffix: String = "?record=enrollments&term=<TERM>&course=<COURSE>"
    
    var enrollments: [Enrollments] = [Enrollments]()
    
    
}