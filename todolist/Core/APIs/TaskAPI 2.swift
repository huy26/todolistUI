//
//  TaskAPI.swift
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



func uploadtaskAPI(boardID: String, task: Task){
    let curuser = Auth.auth().currentUser
    curuser?.getIDTokenForcingRefresh(true) { (tokenID, error) in
        if error != nil
        {
            print ("Fail to get token")
            return
        }
        guard let tokenID = tokenID else{return}
        let headers: HTTPHeaders = [
            "tokenID": tokenID
        ]
        AF.request(url + "/board/\(boardID)/task", method: .post, parameters: task, encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: headers).responseData(completionHandler: { data in
            print ("Data Response: \(data)")
            
        }).responseJSON(completionHandler: { response in
            debugPrint(response)
        })
    }
}

func readTaskApi(boardID: String,onCompleted: @escaping ((Error?, [Task]?)-> Void)){
    var task = Task(taskName: "",status: "")
    var taskarray: [Task]?
    let currentuser = Auth.auth().currentUser
    currentuser?.getIDTokenForcingRefresh(true) { (tokenID, error) in
        if error != nil
        {
            print ("Fail to get token")
            return
        }
        guard let tokenID = tokenID else {return}
        let headers: HTTPHeaders = ["tokenID": tokenID]
        AF.request(url + "/board/\(boardID)/tasks", method: .get, parameters: taskarray , encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseString{ (response) in
            switch response.result {
            case let .success(string):
                debugPrint("Request success \(string)")
                break
            case let .failure(error):
                debugPrint(error)
                break
            }
        }.responseArray{ (response: AFDataResponse<[Task]>) in
            switch response.result {
            case let .success(value):
                print(value.count)
                for item in value
                {
                    debugPrint("TASK ID \(item.taskID)")
                }
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

func deleteTaskAPI(task: Task, boardID: String) {
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed")
            return;
        }
        
        guard let idToken = idToken else { return }
        // Send token to your backend via HTTPS
        // ...
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenID": idToken,
        ]
        print("task id: \(task.taskID)")
        
        //guard let newurl = URL(string: "http://103.221.223.126:4000/api/user/board") else { return }
        
        AF.request(
            url + "/board/\(boardID)/task",
            method: .delete,
            parameters: task,
            encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
            headers: header
        )
            .responseString(completionHandler: { data in
                if let responseData = data.data {
                    let responseString = String(data: responseData, encoding: .utf8)
                    print("Response String \(responseString)")
                }
                
                print(data.response?.statusCode)
                print("==> Raw Data \(data)")
            }).responseJSON(completionHandler: { response in
                debugPrint(response)
            })
        print(idToken)
        print("http resquest succeed")
    }
}



func updateTaskAPI(task: Task, boardID: String) {
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed")
            return;
        }
        
        guard let idToken = idToken else { return }
        // Send token to your backend via HTTPS
        // ...
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenID": idToken,
        ]
        print("Task update: \(task.taskID!)")
        
        guard let newurl = URL(string: "http://192.168.0.150:4000/api/user/board/\(boardID)/task") else { return }
        AF.request(
            newurl,
            method: .put,
            parameters: task,
            encoder: URLEncodedFormParameterEncoder(destination: .httpBody),
            headers: header
        )
            .responseString(completionHandler: { data in
                if let responseData = data.data {
                    let responseString = String(data: responseData, encoding: .utf8)
                    print("Response String \(responseString)")
                }
                
                print(data.response?.statusCode)
                print("==> Raw Data \(data)")
            }).responseJSON(completionHandler: { (response) in
                debugPrint(response)
            })
        print(idToken)
        print("http resquest succeed")
    }
}


