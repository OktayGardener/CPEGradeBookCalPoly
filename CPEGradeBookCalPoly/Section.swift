//
//  Section.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 01/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import Foundation

class Section {
    var id: Int!
    var polynum: Int!
    var term: Int!
    
    var termName: String!
    var dept: String!
    
    var courseNumber: String!
    var courseTitle: String!
    
    var firstDay: NSDate!
    var lastDay: NSDate!
    
    
    init(id: Int, polynum: Int, term: Int, termName: String, dept: String, courseNumber: String, courseTitle: String, firstDay: NSDate, lastDay: NSDate) {
        self.id = id
        self.polynum = polynum
        self.term = term
        
        self.termName = termName
        self.dept = dept
        
        self.courseNumber = courseNumber
        self.courseTitle = courseTitle
        
        self.firstDay = firstDay
        self.lastDay = lastDay
    }
    
}