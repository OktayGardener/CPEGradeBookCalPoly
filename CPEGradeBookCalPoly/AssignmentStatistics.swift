//
//  AssignmentStatistics.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 01/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import Foundation

class AssignmentStatistics {
    var assignmentID: Int!
    var assignmentPoints: Int!
    var assignmentUniqueStudents: Int!
    var assignmentMinScore: Int!
    
    var assignmentMeanScore: Double!
    var assignmentMedianScore: Double!
    var assignmentStDev: Double!
    
    var assignmentAttempts: Int!
    
    init(assignmentID: Int, assignmentPoints: Int, assignmentUniqueStudents: Int,
        assignmentMinScore: Int, assignmentMeanScore: Double, assignmentMedianScore: Double, assignmentStDev: Double, assignmentAttempts: Int) {
            self.assignmentID = assignmentID
            self.assignmentPoints = assignmentPoints
            self.assignmentUniqueStudents = assignmentUniqueStudents
            self.assignmentMinScore = assignmentMinScore
            self.assignmentStDev = assignmentStDev
            self.assignmentAttempts = assignmentAttempts
    }
    
    
}