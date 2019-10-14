//
//  UserAPI.swift
//  todolist
//
//  Created by Mac on 10/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import SwiftyJSON
import AlamofireObjectMapper
import UIKit
import MobileCoreServices
import OneSignal

//private let url = "http://192.168.0.150:4000/api/user"

func getUserAPI (onCompleted: @escaping ((Error?, User?)-> Void)) {
    //var data = User(firstName: "", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "")
    var data: User?
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed user")
            return;
        }
     
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenID": "\(idToken!)",
        ]
        AF.request(url, method: .get,parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header)
            .responseDecodable{ (response: DataResponse<User>) in
                switch response.result {
                case let .success(value):
                    debugPrint(value)
                    data = value
                    User.setNamePrint(value: "\(data!.firstName) \(data!.lastName)")
                    User.setemailPrint(value: data!.email)
                    onCompleted(nil, value)
                    break
                case let .failure(error):
                    debugPrint(error)
                    onCompleted(error, nil)
                    break
                }
        }
    }
    
}

func getUserListAPI(onCompleted: @escaping ((Error?, [SearchUser]?)-> Void)){
    
    var data: [SearchUser]?
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed user")
            return;
        }
        
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = []
        
        let listuser = url + "/lists"
        print("list user: \(listuser)")
        
        AF.request(listuser, method: .get,parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header)
            .responseArray{ (response: DataResponse<[SearchUser]>) in
                switch response.result {
                case let .success(value):
                    debugPrint(value)
                    data = value
                    onCompleted(nil, value)
                    break
                case let .failure(error):
                    debugPrint(error)
                    onCompleted(error, nil)
                    break
                }
        }
    }
}

func uploadUserAPI(firstName: String, lastName: String, userPhone: String, birthDay: String, avatarURL: String, email: String){
    
    let data = User(firstName: firstName, lastName: lastName, userPhone: userPhone, birthDay: birthDay, avatarURL: avatarURL, email: email)
    
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed user")
            return;
        }
        
        // Send token to your backend via HTTPS
        // ...
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenIDS": "\(idToken!)",
        ]
        AF.request(url, method: .post, parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header).responseData(completionHandler: { data in
            print("==> Raw Data \(data)")
            print(data.response?.statusCode)
        }).responseJSON(completionHandler: { dataJson in
            print("==> JSON Data: \(dataJson)")
        })
        print(idToken!)
        print(email)
        print("http resquest succeed")
    }
}

func updateUserAPI(firstName: String, lastName: String, userPhone: String, birthDay: String, avatarURL: String, email: String) {
    let data = User(firstName: firstName, lastName: lastName, userPhone: userPhone, birthDay: birthDay, avatarURL: avatarURL, email: email)
    
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed user")
            return;
        }
        
        // Send token to your backend via HTTPS
        // ...
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokeniD": "\(idToken!)",
        ]
        AF.request(url, method: .put, parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header).responseData(completionHandler: { data in
            print("==> Raw Data \(data)")
            print(data.response?.statusCode)
        }).responseJSON(completionHandler: { dataJson in
            print("==> JSON Data: \(dataJson)")
        })
        print(idToken!)
        print(email)
        print("http resquest succeed")
    }
}
