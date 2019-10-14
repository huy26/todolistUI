//
//  SearchItem.swift
//  todolist
//
//  Created by Mac on 10/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class SearchUser{
    //MARK:- Local Properties
    var name: String
    var email: String
    
    var attributedCityName: NSMutableAttributedString?
    var attributedCountryName: NSMutableAttributedString?
    var allAttributedName : NSMutableAttributedString?
    
    public init(name: String, email: String){
        self.name = name
        self.email = email
    }
    
    public func getFormatedText() -> NSMutableAttributedString{
        allAttributedName = NSMutableAttributedString()
        allAttributedName!.append(attributedCityName!)
        allAttributedName!.append(NSMutableAttributedString(string: ", "))
        allAttributedName!.append(attributedCountryName!)
        
        return allAttributedName!
    }
    
    public func getStringText() -> String{
        return "\(name), \(email)"
    }
}
