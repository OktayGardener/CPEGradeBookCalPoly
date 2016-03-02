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
    
    var dueDate: UInt32!
    
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
    
    
}