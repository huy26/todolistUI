//
//  GuestVM.swift
//  todolist
//
//  Created by Mac on 10/16/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

protocol GuestVmDelegate: class {
    func onGuestListChange(_ vm: GuestVm, data: [User])
}

final class GuestVm {
    
    weak var delegate: GuestVmDelegate?
    
    private var guestList: [User]? {
        didSet{
            self.delegate?.onGuestListChange(self, data: self.guestList!)
        }
    }
    
    public init(){
        self.guestList = [User(firstName: "", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "")]
    }
}

//MARK:- API function

extension GuestVm{
    final func requestGetGuest(boardID: String){
        getGuestListAPI(boardID: boardID) { (error, user) in
            if let error = error {
                debugPrint(error)
                return
            }
            if let checkboard = user {
                self.guestList = checkboard
            }
        }
    }
}

//MARK:- Guest function
extension GuestVm{
    final func getGuestCount() -> Int {
        return guestList?.count ?? -1 //return -1 if nil
    }
}
