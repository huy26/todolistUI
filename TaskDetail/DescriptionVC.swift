//
//  DescriptionVC.swift
//  todolist
//
//  Created by Mac on 08/10/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {
    var textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }

            }
    

    

}
