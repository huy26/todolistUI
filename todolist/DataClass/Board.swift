//
//  Board.swift
//  firebase-test
//
//  Created by Mac on 9/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//
import Foundation
import ObjectMapper

class Board: Encodable, Mappable {
    
    //var title: String
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
        self.status = "good"
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
