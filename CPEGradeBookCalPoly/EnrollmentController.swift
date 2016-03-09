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
    
    static let sharedInstance = EnrollmentController()
    
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
        
        //setupUserImageDataFromJSON()
        setupHeaderView()
        self.tableView.reloadData()
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
            print(userScores)
        
            for userScore in userScores {
                var assignmentScores: [UserScores.AssignmentScores] = []
                var currentAssignmentFeedbacks: [UserScores.Feedback] = []
                var submittedWorks: [UserScores.SubmittedWork] = []
                if let currentUserScore = userScore.dictionary {
                
                    
                    if let scores = currentUserScore["scores"]!.array {
                        for score in scores {
                            let currentAssignmentScore = UserScores.AssignmentScores(
                                counts: score["counts"].int!,
                                id: score["id"].int!,
                                assignmentScore: score["score"].int!,
                                assignmentPostDate: NSDate(timeIntervalSince1970:NSTimeInterval(score["post_date"].int!)))
                            assignmentScores.append(currentAssignmentScore)
                            
                            let feedback = score["feedback"]
                            if feedback != nil {
                            let currentAssignmentFeedback = UserScores.Feedback(
                                id: feedback["id"].int!,
                                type: feedback["mimetype"].string!,
                                fileExtension: feedback["file_extension"].string!,
                                URL: feedback["url"].string!)
                            currentAssignmentFeedbacks.append(currentAssignmentFeedback)

                            }
                            
                            let submittedWork = score["submitted_work"]
                            if submittedWork != nil {
                            let currentAssignmentSubmittedWork = UserScores.SubmittedWork(
                                    id: submittedWork["id"].int!,
                                    type: submittedWork["mimetype"].string!,
                                    fileExtension: submittedWork["file_extension"].string!,
                                    URL: submittedWork["url"].string!)
                                submittedWorks.append(currentAssignmentSubmittedWork)
                            }
                        }
                    }
                }
//                let currentPermissions = UserScores.Permissions(
//                    id: userScore["permissions"]["id"].int!,
//                    visible: userScore["permissions"]["visible"].int!,
//                   // viewFiles: userScore["permissions"]["view_stats"].int!, // #care
//                  //  viewStats: userScore["permissions"]["view_stats"].int!,
//                    histogram: userScore["permissions"]["view_histogram"].int!,
//                    viewProperties: userScore["permissions"]["view_properties"].int!,
//                    computedBy: userScore["permissions"]["view_computed_by"].int!)
//
                var dueDate = 0
                if userScore["due_date"] != nil {
                    dueDate = userScore["due_date"].int!
                }
                let currentUserScore = UserScores(
                    id: userScore["id"].int!,
                    name: userScore["name"].string!,
                    maxPoints: userScore["max_points"].int!,
                    abbreviatedName: userScore["abbreviated_name"].string!,
//                    extraCreditAllowed: userScore["extra_credit_allowed"].int!,
//                    emailNotification: userScore["email_notification"].int!,
//                    sortOrder: userScore["sort_order"].int!,
//                    computeFunc: userScore["compute_func"].int!,
//                    displayType: userScore["display_type"].int!,
                    dueDate: NSDate(timeIntervalSince1970:
                        NSTimeInterval(dueDate)),
                //    permissions: currentPermissions,
                    assignmentScores: assignmentScores,
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
                    cscUsername: enrollment["csc_username"].string!)
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
        return self.userScores.count
    }
    
    // TODO: Look up how to make an expandable cell.
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EnrollmentCell", forIndexPath: indexPath) as! EnrollmentCell
        let current = self.userScores[indexPath.row]
        cell.assignmentTitle.text = current.abbreviatedName + " - " + current.name
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AssignmentInformationController {
            if let cell = sender as? EnrollmentCell, let indexPath = tableView.indexPathForCell(cell) {
                var current = self.userScores[indexPath.row]
                destination.currentUserScore = current
            }
        }
    }

    
        // TODO:
        // Finish Enrollment
        // Finish last parsing
        // Autolayout
        // Done
}