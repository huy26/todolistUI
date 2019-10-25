//
//  DashBoardVM.swift
//  todolist
//
//  Created by Mac on 10/14/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol DashBoardVMDelegate: class {
    func onBoardChangeData(_ vm: DashBoardVM, data: [Board])
    
    func onUserChangeData(_ vm: DashBoardVM, data: User)
    
    func onGuestListChange(_ vm: DashBoardVM, data: [User])
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
    
    private var guestList: [User]? {
        didSet{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.delegate?.onGuestListChange(self, data: self.guestList!)
            }
        }
    }
    
    private var user: User {
        didSet {
            self.delegate?.onUserChangeData(self, data: self.user)
        }
    }
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
        SVProgressHUD.show()
        DispatchQueue.main.async {
            readBoardAPI { (error, boards) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                        SVProgressHUD.dismiss()
                }
                if let checkBoards = boards {
                    self.board = checkBoards
                    SVProgressHUD.dismiss()
                }
            }
        }
        
    }
    
    public func getUser(){
        getUserAPI { (error, user) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let checkUser = user {
                self.user = checkUser
            }
        }
    }
    
    final func requestGetGuest(boardID: String){
        getGuestListAPI(boardID: boardID) { (error, user) in
            if let error = error {
                debugPrint(error)
                return
            }
            if let checkuser = user {
                self.guestList = user
            }
        }
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
    
    final func getBoardIDatIndex(index: Int) -> String{
        return board[index].boardID ?? "-1"
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
    
    final func getGuestCount() -> Int {
        return guestList?.count ?? -1 //return -1 if nil
    }
    
}

