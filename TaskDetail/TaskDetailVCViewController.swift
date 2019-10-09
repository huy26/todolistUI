//
//  TaskDetailVCViewController.swift
//  todolist
//
//  Created by Mac on 07/10/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TaskDetailVCViewController: UIViewController {
    
    var task: Task?
    var Taskname = UITextField()
    var status = UILabel()
    var taptoadddes = UIButton()
    var subviewcolor = UIView()
    var activity = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI() {
        view.backgroundColor = .groupTableViewBackground
        
        self.view.addSubview(subviewcolor)
        subviewcolor.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(180)
        }
        subviewcolor.backgroundColor = UIColor.orange
        
        self.subviewcolor.addSubview(Taskname)
        Taskname.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(90)
            make.left.equalToSuperview().offset(20)
        }
        Taskname.text = "Task Name"
        Taskname.textColor = .black
        Taskname.font = UIFont.boldSystemFont(ofSize: 30)
        
        self.subviewcolor.addSubview(status)
        status.snp.makeConstraints { (make) in
            make.top.equalTo(Taskname.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        status.text = "In Status: "
        
        self.view.addSubview(taptoadddes)
        taptoadddes.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subviewcolor.snp.bottom).offset(5)
        }
        taptoadddes.setTitle("Tap to add a description", for: .normal)
        taptoadddes.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15)
        taptoadddes.setTitleColor(.black, for: .normal)
        taptoadddes.backgroundColor = .white
        taptoadddes.addTarget(self, action: #selector(editDescription), for: .touchUpInside)
        
        self.view.addSubview(activity)
        activity.snp.makeConstraints { (make) in
            make.top.equalTo(taptoadddes.snp.bottom).offset(150)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc func editDescription(){
        let vc = DescriptionVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
