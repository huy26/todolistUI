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

class Task: NSObject, Encodable, Mappable, NSCoding
{
    required convenience init?(coder aDecoder: NSCoder) {
        let taskName = aDecoder.decodeObject(forKey: "taskName") as! String
        let status = aDecoder.decodeObject(forKey: "status") as! String
        self.init(taskName: taskName, status: status)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskName, forKey:  "taskName")
        aCoder.encode(status, forKey:  "status")
    }
    
    var taskID: String? = ""
    var taskName: String? = ""
    var status: String? = ""
    var userID: String = ""
    var des: String? = ""
    
    required init?(map: Map) {
    }
    
    init(taskName: String,status: String)
    {
        self.taskName = taskName
        self.taskID = ""
        self.status = status
        self.des = ""
    }
    func mapping(map: Map) {
        self.des <- map["description"]
        self.taskID <- map["taskID"]
        self.taskName <- map["taskName"]
        self.status <- map["status"]
    }
    
    func changeDescription(des: String){
        self.des = des
    }
    
    
    
}
