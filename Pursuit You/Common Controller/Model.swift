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
        var fee : Int?
        var category_id : Int?
        var status: String?
        var created_at: String?
        var updated_at: String?
    }
    struct allTutorCourse {
        var course_id : Int?
        var course_name : String?
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

