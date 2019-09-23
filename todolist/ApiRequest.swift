//
//  ApiRequest.swift
//  todolist
//
//  Created by Mac on 16/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import Alamofire
import Firebase
import SwiftyJSON
import AlamofireObjectMapper

let url = "http://103.221.223.126:4000/api/user"

func getUserAPI(){
    let data = User(firstName: "", lastName: "", userPhone: "", birthDay: "", avatarURL: "", email: "")
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed")
            return;
        }
        
        // Send token to your backend via HTTPS
        // ...
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenIDS": "\(idToken as! String)",
        ]
        AF.request(url, method: .get, parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header).responseData(completionHandler: { data in
            print("==> Raw Data \(data)")
        }).responseJSON(completionHandler: { dataJson in
            print("==> JSON Data: \(dataJson)")
        })
        print(idToken)
        print("Get user completed")
    }
}

func uploadUserAPI(firstName: String, lastName: String, userPhone: String, birthDay: String, avatarURL: String, email: String){
    
    let data = User(firstName: firstName, lastName: lastName, userPhone: userPhone, birthDay: birthDay, avatarURL: avatarURL, email: email)
    
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed")
            return;
        }
        
        // Send token to your backend via HTTPS
        // ...
        
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenIDS": "\(idToken as! String)",
        ]
        AF.request(url, method: .post, parameters: data,encoder: URLEncodedFormParameterEncoder(destination: .httpBody), headers: header).responseData(completionHandler: { data in
            print("==> Raw Data \(data)")
            print(data.response?.statusCode)
        }).responseJSON(completionHandler: { dataJson in
            print("==> JSON Data: \(dataJson)")
        })
        print(idToken)
        print(email)
        print("http resquest succeed")
    }
}
func APIboard(board: Board){
    let currentuser = Auth.auth().currentUser
    currentuser?.getIDTokenForcingRefresh(true, completion: { tokenID, error in
        if error != nil {
            print ("Fail to get token")
            return
        }
        guard let tokenID = tokenID else {return}
        let headers: HTTPHeaders = [
            "tokenID": tokenID
        ]
        AF.request(url + "/board", method: .post, parameters: board, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseData(completionHandler: {data in
            print ("==> Raw data \(data)")
        }).responseJSON(completionHandler: {dataJSON in
            print ("==>data JSON \(dataJSON)")
        })
    })
}


func readBoardAPI(onCompleted: @escaping ((Error?, [Board]?)-> Void)) {
    print("reading board")
    var board = Board(boardName: "", items: [""]) // alo alo
    //Board.setBoardCount(value: -1)
    var arrayboard: [Board]?
    var returnboard = [board]
    let currentUser = Auth.auth().currentUser
    currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
        if error != nil {
            print("get token failed")
            return;
        }
        
        guard let idToken = idToken else { return }
        // Send token to your backend via HTTPS
        // ....
        //let idToken = returnFirebaseToken()
        let header: HTTPHeaders = [
            "tokenID": "\(idToken as! String)",
        ]
        //print(board.boardName)
        
        guard let newurl = URL(string: "http://103.221.223.126:4000/api/user/boards") else { return }
        
        AF.request(
            newurl,
            method: .get,
            parameters: arrayboard,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: header
            )
            .responseString{ response in
                switch response.result {
                case .success(let string):
                    debugPrint("Request success \(string)")
                //                    return string.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
                case .failure(let error):
                    debugPrint(error)
                    break
                }
                //                debugPrint(response)
            }
            .responseArray { (response: DataResponse<[Board]>) in
                
                print("try to map")
                //let board = response.result
                if  let status = response.response?.statusCode {
                    switch(response.result){
                    case let .success(value):
                        returnboard = value
                        Board.resetBoardCount(value: value.count)
                        print("number of board ger from api: \(Board.getBoardCount())")
                        for item in value {
                            debugPrint("BOARD ID: \(item.boardID)")
                        }
                        onCompleted(nil, value)
                        break
                    case let .failure(error):
                        print("case error")
                        onCompleted(error, nil)
                        print(error.localizedDescription)
                        break
                    }
                }
        }
        
        print(idToken)
        print("http resquest succeed")
    }
    
}
func uploadBoardAPI(board: Board){
    
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
        print(board.boardName)
        
        guard let newurl = URL(string: "http://192.168.2.48:4000/api/user/board") else { return }
        AF.request(
            newurl,
            method: .post,
            parameters: board,
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

func deleteBoardAPI(board: Board) {
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
        print(board.boardID)
        
        guard let newurl = URL(string: "http://192.168.2.48:4000/api/user/board") else { return }
        //        AF.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: Encodable?, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>)
        AF.request(
            newurl,
            method: .delete,
            parameters: board,
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

func uploadtaskAPI(task: Task)
{
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
        AF.request(url + "/board/13/task", method: .post, parameters: task, encoder: JSONParameterEncoder.default, headers: headers).responseData(completionHandler: { data in
            print ("Data Response: \(data)")
        }).responseJSON(completionHandler: { dataJSON in
            debugPrint(dataJSON)
        })
    }
}
func readTaskApi(boardID: String)
{
    var task = Task(taskName: "", items: [])
    var taskarray = [Task]()
    var returntask = [task]
    let currentuser = Auth.auth().currentUser
    currentuser?.getIDTokenForcingRefresh(true) { (tokenID, error) in
        if error != nil
        {
            print ("Fail to get token")
            return
        }
        guard let tokenID = tokenID else {return}
        let headers: HTTPHeaders = ["tokenID": tokenID]
        AF.request(url + "/board/\(boardID)/tasks", method: .get, parameters: returntask, encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseString{ (response) in
            switch response.result {
            case let .success(string):
                    debugPrint("Request success \(string)")
                    break
            case let .failure(error):
                debugPrint(error)
                break
            }
        }.responseArray{ (response: DataResponse<[Task]>) in
            switch response.result {
            case let .success(value):
                for item in value
                {
                    debugPrint("TASK ID \(item.taskID)")
                }
                break
            case let .failure(error):
                debugPrint(error)
                break
            }
        }
    }
}

