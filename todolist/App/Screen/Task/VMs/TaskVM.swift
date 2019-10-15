//
//  TaskVM.swift
//  todolist
//
//  Created by Mac on 15/10/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

protocol TaskVMDelegate: class {
    func onStatusChangeData(_ vm: TaskVM, data: [Status])
}

class TaskVM {
    
    weak var delegate: TaskVMDelegate?
    
    var status = [Status]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.delegate?.onStatusChangeData(self, data: self.status)
            }
        }
    }
    var tasks = [Task]()
    var boardID: String
    
    init (status: [Status], tasks: [Task], boardID: String) {
        self.status = status
        self.tasks = tasks
        self.boardID = boardID
        getTask()
    }
    
    
    
    func getTask () {
        readTaskApi(boardID: boardID) { (error, tasks) in
            if let error = error {
                self.getonTaskerror(error: error)
                print(error.localizedDescription)
                return
            }
            if let tasks = tasks {
                //UserDefaults.standard.removeObject(forKey: "Tasks")
                self.onreciveTask(tasks: tasks)
                self.createStatus()
//                self.collectionView.reloadData()
//                self.checkCollectionview.reloadData()
                return
            }
        }
    }
    func createStatus ()
    {
        for j in tasks
        {
            var check = true
            for i in status          {
                if j.status == i.name
                {
                    check = false
                    i.items.append(j)
                }
                
            }
            if check == true{
                status.append(Status(name: j.status!, items: [j]))
            }
        }
    }
    func checkStatus() -> Bool
    {
        var check = true
        for j in tasks
        {
            
            for i in status          {
                if j.status == i.name
                {
                    check = false
                    return check
                }
            }
        }
        return check
    }
    func getonTaskerror (error: Error)
    {
        
    }
    func onreciveTask (tasks: [Task])
    {
        self.tasks = tasks
        //        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.tasks)
        //        UserDefaults.standard.set(encodedData, forKey: "Tasks")
        //        UserDefaults.standard.synchronize()
    }
    func receiveStatus (status: [Status])
    {
        self.status = status
    }
    
}
