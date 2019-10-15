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
import ObjectMapper

final class User: Encodable, Mappable, Decodable {
   
    
    ///var userID: String
    var firstName = ""
    var lastName = ""
    var userPhone = ""
    var birthDay = ""
    var avatarURL = ""
    var email = ""
    static var userNamePrint = "Name"
    static var emailPrint = "Email"
    
    init(firstName: String, lastName: String, userPhone: String, birthDay: String, avatarURL: String, email: String){
        //self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.userPhone = userPhone
        self.birthDay = birthDay
        self.avatarURL = avatarURL
        self.email = email
        User.userNamePrint = firstName + " \(lastName)"
        User.emailPrint = email
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.firstName <- map["firstName"]
        self.lastName <- map["lastName"]
        self.userPhone <- map["userPhone"]
        self.email <- map["email"]
        self.avatarURL <- map["avatarURL"]
    }
    
    func toJson() -> [String: Any] {
        var dict = [String: Any]()
        dict["firstName"] = firstName
        dict["lastName"] =  lastName
        dict["userPhone"] = userPhone
        dict["birthDay"] =  birthDay
        dict["avatarURL"] = avatarURL
        dict["email"] =  email
        User.emailPrint = email
        User.userNamePrint = firstName
        return dict
    }
    
    static func setNamePrint(value: String){
        User.userNamePrint = value  
    }
    
    static func getNamePrint() -> String {
        return User.userNamePrint
    }
    
    static func setemailPrint(value: String){
        User.emailPrint = value
    }
    
    static func getemailPrint() -> String {
        return User.emailPrint
    }
    
}

