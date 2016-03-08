//
//  AssignmentInformationController.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 07/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit

class AssignmentInformationController: UIViewController {
    var currentUserScore: UserScores!
    
    @IBOutlet var submissionInfoLabel: UILabel! = UILabel()
    @IBOutlet weak var assignmentInfoTextField: UITextView!
    @IBOutlet var scoreInfoLabel: UILabel! = UILabel()
    @IBOutlet var feedbackInfoLabel: UILabel! = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Assignment main info
        var allText: String =
        "ID: \(self.currentUserScore.id) \n Max Points: \(self.currentUserScore.maxPoints) \n Assignment Name: \(self.currentUserScore.name) \n Assignment Abbreviated Name: \(self.currentUserScore.abbreviatedName as String) \n Due Date: \(self.currentUserScore.dueDate) \n\n"
        
            for (key, val) in self.currentUserScore.submittedWork.enumerate() {
                print(key, val)
            }
        
            for val in self.currentUserScore.feedback.enumerate() {
                print(val)
            }
        
            for val in self.currentUserScore.assignmentScores.enumerate() {
                print(val)
            }
        
        
        allText += "Submitted Work Data: \n ID: \(self.currentUserScore.submittedWork.first?.id)\n Mimetype: \(self.currentUserScore.submittedWork.first?.type) \n File Extension: \(self.currentUserScore.submittedWork.first?.fileExtension) \n URL: \(self.currentUserScore.submittedWork.first?.URL) \n\n"
        
        if self.currentUserScore.assignmentScores.first != nil {
            if self.currentUserScore.assignmentScores.count > 1 {
                for score in self.currentUserScore.assignmentScores {
                    allText += "Assignment Score: \n Counts: \((score.counts)! as Int) \n Assignment Score: \((score.assignmentScore)! as Int) \n Assignment Score Post Date: \((score.assignmentPostDate)! as NSDate) \n\n"
                }
            } else {
                allText += "Assignment Score: \n Counts: \((self.currentUserScore.assignmentScores.first?.counts)! as Int) \n Assignment Score: \((self.currentUserScore.assignmentScores.first?.assignmentScore)! as Int) \n Assignment Score Post Date: \((self.currentUserScore.assignmentScores.first?.assignmentPostDate)! as NSDate) \n\n"
            }
        }
        
        
        if self.currentUserScore.feedback.first != nil {
            if self.currentUserScore.feedback.count > 1 {
                for feedback in self.currentUserScore.feedback {
                    allText += "Feedback: \n ID: \((feedback.id)! as Int) \n Type: \((feedback.type)! as String) \n File Extension: \((feedback.fileExtension)! as String) \n \((feedback.URL)! as String)"
                }
            } else {
                allText += "Feedback: \n ID: \((self.currentUserScore.feedback.first?.id)! as Int) \n Type: \((self.currentUserScore.feedback.first?.type)! as String) \n File Extension: \((self.currentUserScore.feedback.first?.fileExtension)! as String) \n \((self.currentUserScore.feedback.first?.URL)! as String)"
            }
        }
        
        
        
        
        self.assignmentInfoTextField.text = allText
//            
//            "ID: \(self.currentUserScore.id)" + "\n"
//            + "Max Points: \(self.currentUserScore.maxPoints)" + "\n"
//            + "Name: \(currentUserScore.name)" + "\n"
//            + "Extra Credit Allowed: \(self.currentUserScore.extraCreditAllowed)" + "\n"
//            + "Email Notification? \(self.currentUserScore.emailNotification)" + "\n"
    
    }
    
    
}