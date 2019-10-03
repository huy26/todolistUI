//
//  AddBoardViewController.swift
//  todolist
//
//  Created by Mac on 10/3/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AddBoardViewController: UIViewController {

    var boardNameTextField = UITextField()
    var colorImageView1 = UIImageView()
    var colorImageView2 = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddViewUI()
    }
    
    func setupAddViewUI(){
        self.view.addSubview(boardNameTextField)
        boardNameTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(30)
            make.width.equalToSuperview()
        }
        boardNameTextField.placeholder = "New Board"
        boardNameTextField.textColor = .lightGray
        
        self.view.addSubview(colorImageView1)
        colorImageView1.snp.makeConstraints{ make in
            make.top.equalTo(boardNameTextField).offset(100)
            make.left.equalToSuperview().offset(50)
        }
        colorImageView1.backgroundColor = UIColor(red:0.01, green:0.71, blue:0.85, alpha:1.0)
        
        self.view.addSubview(colorImageView2)
        colorImageView2.snp.makeConstraints{ make in
            make.top.equalTo(boardNameTextField).offset(100)
            make.right.equalToSuperview().offset(-50)
        }
        colorImageView2.backgroundColor = UIColor(red:0.93, green:0.58, blue:0.47, alpha:1.0)
    }
}
