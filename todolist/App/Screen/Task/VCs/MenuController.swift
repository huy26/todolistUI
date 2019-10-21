//
//  MenuController.swift
//  TestSlideMenu
//
//  Created by Mac on 17/10/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SnapKit

private let CellID = "MenuOptionCell"

class MenuController: UIViewController {

    var TaskVM: TaskVM
    var tableView: UITableView!
    weak var parentVC: ContainerController?
    
    init(VM: TaskVM) {
        self.TaskVM = VM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    func setup(invited: [String]) {
        self.TaskVM.board.invited = invited
    }
    
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: CellID)
        view.addSubview(tableView)
        view.backgroundColor = UIColor.orange
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        tableView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskVM.board.invited.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! MenuOptionCell
        cell.textLabel?.text = TaskVM.board.invited[indexPath.row]
        return cell
    }
    
  
    
}
