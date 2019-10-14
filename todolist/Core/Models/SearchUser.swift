//
//  SearchItem.swift
//  todolist
//
//  Created by Mac on 10/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import ObjectMapper

final class SearchUser: Mappable, Encodable, Decodable{
   
    
    //MARK:- Local Properties
    var name = ""
    var email = ""
    
    
    public init(name: String, email: String){
        self.name = name
        self.email = email
    }
    
    public func getStringText() -> String{
        return "\(name), \(email)"
    }
    
    //MARK:- MAPPING
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.email <- map["email"]
        self.name <- map["firstName"]
    }
}
