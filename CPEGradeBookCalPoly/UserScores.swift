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
    
    var permissions: Permissions!
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
        
        init(id: Int, visible: Int, viewFiles: Int, viewStats: Int, histogram: Int, viewProperties: Int, computedBy: Int) {
            self.id = id
            self.visible = visible
            self.viewFiles = viewFiles
            self.viewStats = viewStats
            self.histogram = histogram
            self.viewProperties = viewProperties
            self.computedBy = computedBy
        }
    }
    
    class AssignmentScores {
        var counts: Int!
        var id: Int!
        var assignmentScore: Int!
        var assignmentPostDate: NSDate!
        init(counts: Int, id: Int, assignmentScore: Int, assignmentPostDate: NSDate) {
            self.counts = counts
            self.id = id
            self.assignmentScore = assignmentScore
            self.assignmentPostDate = assignmentPostDate
        }
        
        
    }
    
    class SubmittedWork {
        var id: Int!
        var type: String!
        var fileExtension: String!
        var URL: String!
        init(id: Int, type: String, fileExtension: String, URL: String) {
            self.id = id
            self.type = type
            self.fileExtension = fileExtension
            self.URL = URL
        }
        
        init() {
            
        }
    }
    
    class Feedback {
        var id: Int!
        var type: String!
        var fileExtension: String!
        var URL: String!
        init(id: Int, type: String, fileExtension: String, URL: String) {
            self.id = id
            self.type = type
            self.fileExtension = fileExtension
            self.URL = URL
        }
    }
    
    init(id: Int, name: String, maxPoints: Int, abbreviatedName: String, extraCreditAllowed: Int, emailNotification: Int, sortOrder: Int, computeFunc: Int, displayType: Int, dueDate: NSDate, permissions: Permissions, assignmentScores: [AssignmentScores], submittedWork: [SubmittedWork], feedback: [Feedback]) {
        self.id = id
        self.name = name
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