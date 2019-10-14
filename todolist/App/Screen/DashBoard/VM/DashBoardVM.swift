//
//  DashBoardVM.swift
//  todolist
//
//  Created by Mac on 10/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

final class DashBoardVM {
    private var board: [Board]
    private var user: User
    private var calendarLabel: String?
    
    public init(){
        self.user = User(firstName: "An", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "asdadasd")
        self.board = [Board]()
        self.calendarLabel = getCurrentDateTime()
    }
    
    public var usernameText: String {
        return "Hello, \(user.firstName)"
    }
    
    public var getBoard: [Board] {
//        readBoardAPI { (error, boards) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            if let checkBoards = boards {
//                self.board = checkBoards
//            }
//        }
        self.board = [Board(boardName: "test", items: []),Board(boardName: "sfads", items: [])]
        return self.board
    }
    
    public var getUser: User{
        getUserAPI { (error, user) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let checkUser = user {
                self.user = checkUser
            }
        }
        return self.user
    }
}

