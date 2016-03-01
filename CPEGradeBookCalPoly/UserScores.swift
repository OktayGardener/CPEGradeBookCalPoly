//
//  UserScores.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 01/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import Foundation

class UserScores {
    
    class Permissions {
        var permissionId: Int!
        var permissionVisible: Int!
        var permissionViewFiles: Int!
        var permissionViewStats: Int!
        var permissionHistogram: Int!
        var permissionViewProperties: Int!
        var permissionComputedBy: Int!
        
    }
    
    class AssignmentScores {
        var assignmentCounts: Int!
        var assignmentID: Int!
        var assignmentScore: Int!
        var assignmentPostDate: UInt32!
        
    }
    
    class SubmittedWork {
        var submittedID: Int!
        var submittedType: String!
        var submittedFileExtension: String!
        var submittedURL: NSURL!
        
    }
    
    class Feedback {
        var feedbackID: Int!
        var feedbackType: String!
        var feedbackFileExtension: String!
        var feedbackURL: NSURL!
    }
    
    
}