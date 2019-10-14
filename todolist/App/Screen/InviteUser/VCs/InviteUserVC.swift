//
//  InviteUserVC.swift
//  todolist
//
//  Created by Mac on 10/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import CoreData

class InviteUserVC: UIViewController{
    //MARK:- UI Properties
    private var searchBox = UITextField()
    private let showUserTable = UITableView()
    private let cancelBtn = UIButton()
    
    //MARK:- Local Properties
    private var datalist = [SearchUser]()
    private var resultslist = [SearchUser]()
    
    //MARK:- Intent Properties
    var boardID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserListAPI { (error, userlist) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let datalist = userlist {
                for str in datalist {
                    self.resultslist.append(str)
                    self.datalist.append(str)
                }
                self.showUserTable.reloadData()
            }
            self.checkabledata()
        }
    }
}

//MARK:- setupUI

extension InviteUserVC {
    
    final private func setupUI(){
        self.view.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        //self.navigationController?.isNavigationBarHidden = true
        setupNavBar()
        setupSearchBox()
        setupTableView()
    }
    
    final private func setupNavBar(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        view.addSubview(navBar)
        
        let navItem = UINavigationItem(title: "Invite member")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: nil, action: #selector(backtoBar))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    final private func setupSearchBox(){
        self.view.addSubview(searchBox)
        searchBox.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(35)
        }
        searchBox.layer.cornerRadius = 10
        searchBox.backgroundColor = .white
        searchBox.placeholder = "Search by name or email..."
        searchBox.textColor = .lightGray
        searchBox.autocapitalizationType = .none
        searchBox.delegate = self
        searchBox.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        self.view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints{ make in
            make.top.equalTo(searchBox)
            make.left.equalTo(searchBox.snp.right).offset(5)
            make.right.equalToSuperview().offset(5)
        }
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(.blue, for: .normal)
        cancelBtn.addTarget(self, action: #selector(clearSearchBox), for: .touchUpInside)
    }
    
    final private func setupTableView(){
        self.view.addSubview(showUserTable)
        showUserTable.snp.makeConstraints{ make in
            make.top.equalTo(searchBox.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        showUserTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        showUserTable.delegate = self
        showUserTable.dataSource = self
    }
    
}

//MARK: private function
extension InviteUserVC{
    final private func addData(){
        //datalist.append("test")
        //        let a = SearchUser(name: "An", email: "ban@gmail.com")
        //
        //        let b = SearchUser(name: "Bao", email: "hieu@g.com")
        //
        //        let c = SearchUser(name: "Hieu", email: "hieu@apcs.vn")
        //
        //        let d = SearchUser(name: "Huy", email: "huy@yahoo.com")
        //
        //        let e = SearchUser(name: "Heo", email: "heo@utut.com")
        //
        //
        //
        //        datalist.append(a)
        //        datalist.append(b)
        //        datalist.append(c)
        //        datalist.append(d)
        //        datalist.append(e)
        
        for str in datalist {
            resultslist.append(str)
        }
    }
    
    final private func updateTableView() {
        showUserTable.reloadData()
    }
    
    func filter() {
        
        showUserTable.reloadData()
    }
    
    final private func checkabledata(){
        print("datalist: \(datalist.count)")
        print("resultlist: \(resultslist.count)")
    }
    
}

//MARK:- Action function

extension InviteUserVC{
    @objc final private func backtoBar(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc final private func clearSearchBox(){
        self.searchBox.text = ""
        self.resultslist.removeAll()
        for str in datalist {
            resultslist.append(str)
        }
        updateTableView()
    }
    
    @objc final private func textFieldDidChange(){
        print("Text changed ...")
        //addData()
        updateTableView()
        
    }
}
//MARK:- tableView dataSource
extension InviteUserVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = resultslist[indexPath.row].email
        return cell
    }
    
    
}

//MARK:- tableview delegate
extension InviteUserVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Confirm invite", message: "Invite user to your board", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            guard let text = alertController.textFields![0].text, !text.isEmpty else {
                return
            }
            let currentcell = tableView.cellForRow(at: indexPath)
            if let email = currentcell?.textLabel?.text {
                inviteBoardAPI(board: DashboardViewController.boards[self.boardID!], email: email)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        self.present(InviteUserVC(), animated: true, completion: nil)
    }
}

//MARK:- textfield delegate
extension InviteUserVC: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBox.resignFirstResponder()
        self.resultslist.removeAll()
        clearSearchBox()
        for str in datalist {
            resultslist.append(str)
        }
        updateTableView()
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        //compare searchbox with tableview
        if searchBox.text?.count != 0 {
            self.resultslist.removeAll()
            for str in datalist {
                let range = str.email.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil{
                    resultslist.append(str)
                }
            }
        }
        
        //show table data if searchbox null
        if searchBox.text == "" {
            clearSearchBox()
        }
        updateTableView()
        return true
    }
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        self.view.endEditing(true)
    //        return false
    //    }
}
