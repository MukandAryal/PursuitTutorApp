//
//  Model.swift
//  Pursuit TutorApp
//
//  Created by Apple SSD2 on 09/10/19.
//  Copyright © 2019 Apple SSD2. All rights reserved.
//

import UIKit

class getAllCourse {
    struct course {
        var id : Int?
        var name : String?
        var des : String?
        var fee : String?
        var category_id : Int?
        var status: String?
        var created_at: String?
        var updated_at: String?
        var imageProfile : String?
    }
    struct allTutorCourse {
        var course_id : Int?
        var course_name : String?
        var created_at : String?
        var id : Int?
        var status : String?
        var tutorName : String?
        var tutor_relation_id :Int?
        var updated_at : String?
        var user_id : Int?
        var imageProfile : String?
    }
    
    struct allCategory {
        var id : Int?
        var name : String?
        var image : String?
        var status : String?
        var created_at : String?
        var updated_at : String?
    }
    
    struct syllabusInfo {
        var id : Int?
        var course_id : Int?
        var tutor_id : Int?
        var title : String?
        var description : String?
        var status : String?
        var created_at : String?
        var updated_at : String?
    }
    
    struct UserDetails {
         var id : Int?
         var name : String?
         var email : String?
         var dob : String?
         var profileImage : String?
         var Organization : String?
         var email_verified_at : String?
         var role : Int?
    }
}


//enum getAllCourse {
//    struct allCourse {
//
//    }

//
//    struct allCategory {
//       var id : Int?
//       var name : String?
//       var image : String?
//       var status : String?
//       var created_at : String?
//       var updated_at : String?
//    }
//}

