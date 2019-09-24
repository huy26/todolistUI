//
//  Task.swift
//  todolist
//
//  Created by Mac on 18/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

class Task: Encodable, Mappable
{
    var taskID: String? = ""
    var taskName: String? = ""
    var status: String? = ""
    var userID: String = ""
    
    required init?(map: Map) {
    }
    
    init(taskName: String,status: String)
    {
        self.taskName = taskName
        self.taskID = ""
        self.status = status
    }
    func mapping(map: Map) {
        self.taskID <- map["taskID"]
        self.taskName <- map["taskName"]
        self.status <- map["status"]
    }
    
    
    
}
