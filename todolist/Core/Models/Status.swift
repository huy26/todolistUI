//
//  Status.swift
//  todolist
//
//  Created by Mac on 23/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import ObjectMapper
class Status: Encodable, Mappable{
    var items = [Task]()
    var name: String? = ""
    required init?(map: Map) {
    }
    init(name: String, items: [Task])
    {
        self.items = items
        self.name = name
    }
    
    func mapping(map: Map) {
        self.name <- map["name"]
    }
    
    
}
