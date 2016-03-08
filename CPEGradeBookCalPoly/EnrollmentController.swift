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
    var fetchedUserScoreJSONData: JSON!
    
    let enrollmentSuffix: String = "?record=enrollments&term=<TERM>&course=<COURSE>"
    let userScoreSuffix: String = "?record=userscores&term=<TERM>&course=<COURSE>&user=<USER>"
    
    
    var enrollments: [Enrollments] = [Enrollments]()
    var userScores: [UserScores] = [UserScores]()
    
    @IBOutlet weak var headerView: EnrollmentHeaderView!
    
    var userImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestEnrollmentJSON()
        parseEnrollmentJSON(self.fetchedUserInformationJSONData)
        
        requestUserScoreJSON()
        parseUserScoreJSON(self.fetchedUserScoreJSONData)
        
        setupUserImageDataFromJSON()
        setupHeaderView()
    }
    
    // MARK: JSON
    func requestUserScoreJSON() {
        if let currentSection = currentSection {
            if let currentEnrollment = enrollments.first {
                let path = self.userScoreSuffix
                    .stringByReplacingOccurrencesOfString("<TERM>", withString: String(currentSection.term))
                    .stringByReplacingOccurrencesOfString("<COURSE>", withString: currentSection.courseNumber).stringByReplacingOccurrencesOfString("<USER>", withString: currentEnrollment.username)
                if let data = try? self.loader.loadDataFromPath(path) {
                    self.fetchedUserScoreJSONData = JSON(nsdataToJSON(data)!)
                }
            }
        }
    }
    
    func parseUserScoreJSON(jsonData: JSON) {
        if let userScores = jsonData["userscores"].array {
            print(userScores.count)
            for userScore in userScores {
                let currentAssignmentScore = UserScores.AssignmentScores(
                    counts: userScore["scores"]["counts"].int!,
                    id: userScore["scores"]["id"].int!,
                    assignmentScore: userScore["scores"]["score"].int!,
                    assignmentPostDate: NSDate(timeIntervalSince1970:
                        NSTimeInterval(userScore["scores"]["post_date"].int!)))

                let currentPermissions = UserScores.Permissions(
                    id: userScore["permissions"]["id"].int!,
                    visible: userScore["permissions"]["visible"].int!,
                    viewFiles: userScore["permissions"]["view_files"].int!,
                    viewStats: userScore["permissions"]["view_stats"].int!,
                    histogram: userScore["permissions"]["view_histogram"].int!,
                    viewProperties: userScore["permissions"]["view_properties"].int!,
                    computedBy: userScore["permissions"]["computed_by"].int!)
                
                var submittedWorks: [UserScores.SubmittedWork] = []
                
                for submittedWork in userScore["scores"].array! {
                    let currentAssignmentSubmittedWork = UserScores.SubmittedWork(
                        id: userScore["scores"]["id"].int!,
                        type: userScore["scores"]["type"].string!,
                        fileExtension: userScore["scores"]["file_extension"].string!,
                        URL: userScore["scores"]["url"].string!)
                    submittedWorks.append(currentAssignmentSubmittedWork)
                }
                
                var currentAssignmentFeedbacks: [UserScores.Feedback] = []
                
                if userScore["scores"]["feedback"] != nil {
                    let currentAssignmentFeedback = UserScores.Feedback(
                        id: userScore["scores"]["feedback"]["id"].int!,
                        type: userScore["scores"]["feedback"]["type"].int!,
                        fileExtension: userScore["scores"]["feedback"]["file_extension"].string!,
                        URL: userScore["scores"]["feedback"]["url"].string!)
                    currentAssignmentFeedbacks.append(currentAssignmentFeedback)
                }
                
                
                let currentUserScore = UserScores(
                    id: userScore["id"].int!,
                    maxPoints: userScore["max_points"].int!,
                    abbreviatedName: userScore["abbreviated_name"].string!,
                    extraCreditAllowed: userScore["extra_credit_allowed"].int!,
                    emailNotification: userScore["email_notification"].int!,
                    sortOrder: userScore["sort_order"].int!,
                    computeFunc: userScore["compute_func"].int!,
                    displayType: userScore["display_type"].int!,
                    dueDate: NSDate(timeIntervalSince1970:
                    NSTimeInterval(userScore["due_date"].int!)),
                    permissions: currentPermissions,
                    assignmentScores: currentAssignmentScore,
                    submittedWork: submittedWorks,
                    feedback: currentAssignmentFeedbacks)
                self.userScores.append(currentUserScore)
            }
        }
        
    }
    
    func parseEnrollmentJSON(jsonData: JSON) {
        if let enrollments = jsonData["enrollments"].array {
            print(enrollments.count)
            for enrollment in enrollments {
                var enrollment =
                Enrollments(enrollmentID: enrollment["id"].int!,
                    role: enrollment["role"].int!,
                    dropped: enrollment["dropped"].int!,
                    adminFailure: enrollment["admin_failure"].int!,
                    ferpa: enrollment["ferpa"].int!,
                    emplID: enrollment["emplid"].int!,
                    studentAge: enrollment["age"].int!,
                    major: enrollment["major"].string!,
                    firstName: enrollment["first_name"].string!,
                    middleName: enrollment["middle_name"].string!,
                    lastName: enrollment["last_name"].string!,
                    bbID: enrollment["bb_id"].string!,
                    username: enrollment["username"].string!,
                    cscUsername: enrollment["csc_username"].string!,
                    picture:
                        Enrollments.Picture(id: enrollment["picture"]["id"].int!,
                            type: enrollment["picture"]["mimetype"].string!,
                            fileExtension: enrollment["picture"]["file_extension"].string!,
                            URL: enrollment["picture"]["url"].string!
                    ))
                self.enrollments.append(enrollment)
                print(enrollment)
            }
        }
        self.tableView.reloadData()
    }
    
    func setupUserImageDataFromJSON() {
        if let path = self.enrollments.first?.picture.URL {
            if let data = try? self.loader.loadDataFromPath(path) {
                self.userImage = UIImage(data: data)
            }
        }
        self.tableView.reloadData()
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
    
    // MARK: - Header view
    func setupHeaderView() {
        let current = self.enrollments[0]
        self.headerView.userName.text = current.username
        self.headerView.major.text = current.major
        self.headerView.firstMiddleLastName.text = current.firstName + " " + current.middleName + " " + current.lastName
        self.headerView.picture.image = self.userImage
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
        let cell = tableView.dequeueReusableCellWithIdentifier("EnrollmentCell", forIndexPath: indexPath) as! EnrollmentCell
        let current = self.enrollments[indexPath.row]
        
        return cell
    }
    
        // TODO:
        // Finish Enrollment
        // Finish last parsing
        // Autolayout
        // Done
}