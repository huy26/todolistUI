//
//  DashBoardVM.swift
//  todolist
//
//  Created by Mac on 10/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

protocol DashBoardVMDelegate: class {
    func onBoardChangeData(_ vm: DashBoardVM, data: [Board])
}

final class DashBoardVM {
    
    weak var delegate: DashBoardVMDelegate?
    
    private var board: [Board] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.onBoardChangeData(self, data: self.board)
            }
            
        }
    }
    
    
    private var user: User
    private var calendarLabel: String?
    //private var boardDetail: String?
    
    public init(){
        self.user = User(firstName: "An", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "asdadasd")
        //self.board = [Board(boardName: "test", items: []),Board(boardName: "sfads", items: [])]
        self.board = [Board]()
        self.calendarLabel = getCurrentDateTime()
        
    }
    
    
    public var usernameText: String {
        return "Hello, \(user.firstName)"
    }
    
}

//MARK:- API function
extension DashBoardVM{
    func requestGetBoard() {
        readBoardAPI { (error, boards) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let checkBoards = boards {
                self.board = checkBoards
            }
        }
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

//MARK:- add get set BOARD
extension DashBoardVM {
    
    // todo: configure here or inline ??
    //    final func configure(view: DashboardViewController){
    //        calendarLabel.text = getCurrentDateTime()
    //        helloUserName.text = viewModel.usernameText
    //        DashboardViewController.boards = viewModel.getBoard
    //        collectionView.reloadData()
    //    }
    final func getAllBoard() -> [Board] {
        return board
    }
    final func addBoard(board: Board){
        self.board.append(board)
    }
    
    final func getBoardCount() -> Int{
        return self.board.count
    }
    
    final func removeBoard(index: Int){
        self.board.remove(at: index)
    }
    
    final func returnBoardAtIndex(index: Int) -> Board {
        return board[index]
    }
    
    final func getBoardNameAtindex(index: Int) -> String {
        return board[index].boardName ?? "no board name"
    }
    
}

