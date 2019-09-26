//
//  Board.swift
//  firebase-test
//
//  Created by Mac on 9/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//
import Foundation
import ObjectMapper

class Detail: NSObject, NSCoding, Encodable, Mappable {
    required convenience init?(coder aDecoder: NSCoder) {
        let status = aDecoder.decodeObject(forKey: "status") as! String
        let count = aDecoder.decodeObject(forKey: "count") as! Int
        self.init(status: status, count: count)
    }
    
    func encode(with aCoder: NSCoder) {
       aCoder.encode(status, forKey: "status")
        aCoder.encode(count, forKey: "count")
    }
    
    
    //var title: String
    var status: String? = ""
    var count: Int? = 0
    
    init(status: String, count: Int ) {
        self.status = status
        self.count = count
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.status <- map["status"]
        self.count <- map["count"]
    }
    
}
