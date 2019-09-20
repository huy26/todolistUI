//
//  User.swift
//  firebase-test
//
//  Created by Mac on 9/16/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Alamofire
import Firebase


struct User: Encodable {
    ///var userID: String
    var firstName: String
    var lastName: String
    var userPhone: String
    var birthDay: String
    var avatarURL: String
    var email: String
    
    init(firstName: String, lastName: String, userPhone: String, birthDay: String, avatarURL: String, email: String){
        //self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.userPhone = userPhone
        self.birthDay = birthDay
        self.avatarURL = avatarURL
        self.email = email
    }
    
    func toJson() -> [String: Any] {
        var dict = [String: Any]()
        dict["firstName"] = firstName
        dict["lastName"] =  lastName
        dict["userPhone"] = userPhone
        dict["birthDay"] =  birthDay
        dict["avatarURL"] = avatarURL
        dict["email"] =  email
        return dict
    }

   
    
}

