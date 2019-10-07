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
    static let baseURL = "http://3.83.153.192/pursuit/public/api/"
    static let imageBaseUrl = "https://web7.staging02.com/booklover/"
    static let tokenBearer = "Bearer "
}

class ApiEndPoints: NSObject {
    static let login = "login"
    static let register = "register"
    static let user = "user"
}

