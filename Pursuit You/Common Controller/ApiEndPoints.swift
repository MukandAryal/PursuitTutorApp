//
//  ApiEndPoints.swift
//  BookLover
//
//  Created by ios 7 on 07/05/18.
//  Copyright © 2018 iOS Team. All rights reserved.
//

import UIKit
import Alamofire

class Configurator: NSObject {
    static let baseURL = "http://krescentglobal.in/pursuit/public/api/"
    static let imageBaseUrl = "http://krescentglobal.in/pursuit/public/uploads/"
    static let tokenBearer = "Bearer "
}

class ApiEndPoints: NSObject {
    static let login = "login"
    static let register = "register"
    static let user = "user"
    static let getAllCourse = "Courses"
    static let tutorCourses = "TutorCourses"
    static let category = "category"
    static let tutorCoursesByCategory = "TutorCoursesByCategory"
    static let coursesByCategory = "CoursesByCategory"
    static let syllabus = "syllabus"
    static let addCourseToTutor = "addCourseToTutor"
    static let updateProfile = "updateProfile"
    static let createBatch = "addClass"
}

