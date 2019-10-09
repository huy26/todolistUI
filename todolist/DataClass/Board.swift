//
//  Board.swift
//  firebase-test
//
//  Created by Mac on 9/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import ObjectMapper

class Board: NSObject, Encodable, Mappable, NSCoding {
    required init?(coder: NSCoder) {
        self.boardName = coder.decodeObject(forKey: "boardName") as? String
        self.boardID = coder.decodeObject(forKey: "boardID") as? String
        if let decoded  = UserDefaults.standard.data(forKey: "boardDetail"){
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Detail]
            self.detail = decodedTeams
        }
        

        if let items = coder.decodeObject(forKey: "boardItems") {
            self.items = items as! [String]
        }
        self.totalTasks = coder.decodeInteger(forKey: "boardTotalTasks")
        //        self.status = coder.decodeObject(forKey: "boardStatus") as! String
        //self.userID = coder.decodeObject(forKey: "boardUserID") as! String
        //Board.count = coder.decodeObject(forKey: "boardCount") as! Int
        if let count = coder.decodeObject(forKey: "boardCount") {
            Board.count = count as! Int
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(boardName, forKey: "boardName")
        coder.encode(boardID, forKey: "boardID")
        //coder.encode(detail, forKey: "boardDetail")
        let encodeData = NSKeyedArchiver.archivedData(withRootObject: self.detail)
        UserDefaults.standard.set(encodeData, forKey: "boardDetail")
        coder.encode(items, forKey: "boardItems")
        //coder.encode(userID, forKey: "boardUserID")
        coder.encode(status, forKey: "boardStatus")
        coder.encode(Board.count, forKey: "boardCount")
        print(Board.count)
        coder.encode(totalTasks, forKey: "boardTotalTasks")
    }
    
    var items = [String]()
    var boardID: String? = ""
    var status: String? = ""
    var boardName: String? = ""
    var userID: String? = ""
    var detail = [Detail]()
    var totalTasks: Int = 0
    static var count: Int = 0
    
    init(boardName: String, items: [String] ) {
        self.boardName = boardName
        self.items = items
        self.boardID = ""
        self.status = ""
        self.detail = [Detail]()
        self.totalTasks = 0
        //Board.count += 1
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.boardID <- map["boardID"]
        self.status <- map["status"]
        self.boardName <- map["boardName"]
        self.userID <- map["userID"]
        self.detail <- map["details"]
        self.totalTasks <- map["totalTasks"]
    }
    
    static func getBoardCount () -> Int {
        return Board.count
    }
    
    static func setBoardCount (value: Int) {
        Board.count += value
    }
    
    static func resetBoardCount(value: Int) {
        Board.count = value
    }
    
    func changeBoardName(value: String){
        self.boardName = value
    }
}
