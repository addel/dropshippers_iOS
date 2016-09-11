//
//  User.swift
//  Dropshippers
//
//  Created by DARKNIGHT on 03/09/2016.
//  Copyright © 2016 DARKNIGHT. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    
    var username: String!
    var email: String!
    var lastLogin: NSDate!
    var avatar: UIImage!
    
    init(username: String, email: String, lastLogin: NSDate, avatar: UIImage) {
        self.username = username
        self.email = email
        self.lastLogin = lastLogin
        self.avatar = avatar
    }
    
    init(json: JSON) {
        // Faudrai voir pour pouvoir avoir toute les autres infos, pourquoi pas creer des route spécifique au mobile
        username = json["username"].stringValue
        username = json["email"].stringValue
    }
    
}
