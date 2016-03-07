//
//  UserScores.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 01/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import Foundation

class UserScores {
    var id: Int!
    var maxPoints: Int!
    
    var name: String!
    var abbreviatedName: String!
    
    var extraCreditAllowed: Int!
    var emailNotification: Int!
    var sortOrder: Int!
    var computeFunc: Int!
    var displayType: Int!
    
    var dueDate: NSDate!
    
    var permissions = [Permissions]()
    var assignmentScores = [AssignmentScores]()
    var submittedWork = [SubmittedWork]()
    var feedback = [Feedback]()
    
    class Permissions {
        var id: Int!
        var visible: Int!
        var viewFiles: Int!
        var viewStats: Int!
        var histogram: Int!
        var viewProperties: Int!
        var computedBy: Int!
    }
    
    class AssignmentScores {
        var counts: Int!
        var id: Int!
        var assignmentScore: Int!
        var assignmentPostDate: UInt32!
    }
    
    class SubmittedWork {
        var id: Int!
        var type: String!
        var fileExtension: String!
        var URL: NSURL!
    }
    
    class Feedback {
        var id: Int!
        var type: Int!
        var fileExtension: String!
        var URL: NSURL!
    }
    
    init(id: Int, maxPoints: Int, abbreviatedName: String, extraCreditAllowed: Int, emailNotification: Int, sortOrder: Int, computeFunc: Int, displayType: Int, dueDate: NSDate, permissions: [Permissions], assignmentScores: [AssignmentScores], submittedWork: [SubmittedWork], feedback: [Feedback]) {
        self.id = id
        self.maxPoints = maxPoints
        self.abbreviatedName = abbreviatedName
        self.extraCreditAllowed = extraCreditAllowed
        self.emailNotification = emailNotification
        self.sortOrder = sortOrder
        self.computeFunc = computeFunc
        self.displayType = displayType
        self.dueDate = dueDate
        self.permissions = permissions
        self.assignmentScores = assignmentScores
        self.submittedWork = submittedWork
        self.feedback = feedback
    }
    
}