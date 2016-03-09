//
//  Enrollments.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 01/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import Foundation

class Enrollments {
    
    var enrollmentID: Int!
    var role: Int!
    var dropped: Int!
    var admimFailure: Int!
    var ferpa: Int!
    var emplID: Int!
    var studentAge: Int! // age = year
    
    var major: String!
    var firstName: String!
    var middleName: String!
    var lastName: String!
    var bbID: String!
    var username: String!
    var cscUsername: String!
    
    var picture: Picture!
    
    // Image data
    internal class Picture {
        var id: Int!
        var type: String!
        var fileExtension: String!
        var URL: String!
        
        init(id: Int, type: String, fileExtension: String, URL: String!) {
            self.id = id
            self.type = type
            self.fileExtension = fileExtension
            self.URL = URL
        }
    }
    
    init(enrollmentID: Int, role: Int, dropped: Int, adminFailure: Int, ferpa: Int, emplID: Int,  studentAge: Int, major: String, firstName: String, middleName: String, lastName: String, bbID: String, username: String, cscUsername: String) {
        self.enrollmentID = enrollmentID
        self.role = role
        self.dropped = dropped
        self.admimFailure = adminFailure
        self.ferpa = ferpa
        self.emplID = emplID
        self.studentAge = studentAge
        
        self.major = major
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.bbID = bbID
        self.username = username
        self.cscUsername = cscUsername
    }
    
}