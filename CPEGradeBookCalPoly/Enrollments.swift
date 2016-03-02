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
    var canEditEnrollment: Int!
    var studentAge: Int! // age = year
    
    var major: String!
    var firstName: String!
    var middleName: String!
    var lastName: String!
    var bbId: String!
    var username: String!
    var cscUsername: String!
    
    var picture: [Picture] = [Picture]()
    
    // Image data
    internal class Picture {
        var id: Int!
        var type: String!
        var fileExtension: String!
        var URL: NSURL!
        
        init(id: Int, type: String, fileExtension: String, URL: NSURL) {
            self.id = id
            self.type = type
            self.fileExtension = fileExtension
            self.URL = URL
        }
        
        
    }
    
}