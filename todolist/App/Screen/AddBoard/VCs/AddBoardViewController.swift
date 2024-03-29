//
//  AddBoardViewController.swift
//  todolist
//
//  Created by Mac on 10/3/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

final class AddBoardViewController: UIViewController {
    //MARK:- UI Properties
    private var boardNameTextField = UITextField()
    private let colorImageView1 = UIView()
    private let colorImageView2 = UIView()
    private let backgroundView = UIView()
    //MARK:- Intent Properties
    var viewModel = DashBoardVM()
    
    var onDismiss: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavBar()
        setupAddViewUI()
        setupBackbuttonItem()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.boardNameTextField.text = ""
        self.onDismiss?()
    }
}

    // MARK:- setupUI
extension AddBoardViewController {
    
    final private func setupNavBar(){
        let height = CGFloat(64)
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: height))
        navBar.translatesAutoresizingMaskIntoConstraints = true
        navBar.isTranslucent = true
        navBar.delegate = self
        view.addSubview(navBar)

        navBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
        }

        let navItem = UINavigationItem(title: "Add Board")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(backtoBoard(_:)))
        navItem.leftBarButtonItem = doneItem
        
        let addBoard = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(addBoard(_:)))
        navItem.rightBarButtonItem = addBoard
        navBar.items = [navItem]
    }
    
    final private func setupAddViewUI(){
        self.view.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        self.view.topAnchor.constraint(
          equalTo: self.view.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        
        self.view.addSubview(boardNameTextField)
        boardNameTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(70)
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        boardNameTextField.backgroundColor = .white
        boardNameTextField.placeholder = "New Board"
        boardNameTextField.textColor = .lightGray
        
        self.view.addSubview(colorImageView1)
        colorImageView1.snp.makeConstraints{ make in 
            make.top.equalTo(boardNameTextField).offset(100)
            make.left.equalToSuperview().offset(50)
            make.size.equalTo(100)
        }
        colorImageView1.backgroundColor = UIColor(red:0.01, green:0.71, blue:0.85, alpha:1.0)
        
        self.view.addSubview(colorImageView2)
        colorImageView2.snp.makeConstraints{ make in
            make.top.equalTo(boardNameTextField).offset(100)
            make.right.equalToSuperview().offset(-50)
            make.size.equalTo(100)
        }
        colorImageView2.backgroundColor = UIColor(red:0.93, green:0.58, blue:0.47, alpha:1.0)
    }
    
    final private func setupBackbuttonItem() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backtoBoard(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
}

//MARK:- Action functions
extension AddBoardViewController {
    
    @objc final private func backtoBoard(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc final private func addBoard (_ sender: Any){
        let boardName = self.boardNameTextField.text!
        let newboard = Board(boardName: boardName, items: [])
        //DashboardViewController.boards.append(newboard)
        viewModel.addBoard(board: newboard)

        //print("number of board after added: \(DashboardViewController.boards.count)")
        print("number of board after added: \(viewModel.getBoardCount())")
        uploadBoardAPI(board: newboard)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddBoardViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
}

