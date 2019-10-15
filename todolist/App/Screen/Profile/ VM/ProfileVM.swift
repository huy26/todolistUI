//
//  ProfileVM.swift
//  todolist
//
//  Created by Mac on 10/15/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

protocol ProfileVMdelegate: class {
    func onProfileChangeData(_
        vm: ProfileVM, data: User)
}

final class ProfileVM {
    
    weak var delegate: ProfileVMdelegate?
    
    
    private var user: User {
        didSet{
            //DispatchQueue.main.sync { [weak self] in
                //guard let self = self else {return}
                self.delegate?.onProfileChangeData(self, data: self.user)
            //}
        }
    }
    
    public init(){
        self.user = User(firstName: "", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "")
    }
}

//MARK:- API function
extension ProfileVM{
    final func resquestUserAPI(){
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
}

//MARK:- Profile function
extension ProfileVM{
    final func getUserFirstName() -> String{
        return user.firstName
    }
    
    final func getUserLastName() -> String{
        return user.lastName
    }
    
    final func getUserEmail() -> String{
        return user.email
    }
    
    final func getUserBirth() -> String{
        return user.birthDay
    }
    
    final func setUser(newuser: User){
        self.user = newuser
    }
}
