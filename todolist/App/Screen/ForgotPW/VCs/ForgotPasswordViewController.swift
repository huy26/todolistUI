//
//  ForgotPasswordViewController.swift
//  todolist
//
//  Created by Mac on 17/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SnapKit

class ForgotPasswordViewController: UIViewController {
    //MARK:- UI Properties
    private var emailTextField = UITextField()
    private var getPassWordBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForgotPassUI()
    }
}

//MARK: setupUI
extension ForgotPasswordViewController {
    final private func setupForgotPassUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
        }
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter your email"
        emailTextField.autocapitalizationType = .none
        
        self.view.addSubview(getPassWordBtn)
        getPassWordBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField).offset(60)
        }
        getPassWordBtn.setTitle("Get Password", for: .normal)
        getPassWordBtn.setTitleColor(.black, for: .normal)
        getPassWordBtn.layer.cornerRadius = 10
        getPassWordBtn.backgroundColor = UIColor(red: 0x00, green: 0x00, blue: 0x00,alpha: 0.1)
        getPassWordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        getPassWordBtn.addTarget(self, action: #selector(Finish(_:)), for: .touchUpInside)
    }
}

//MARK:- Action functions
extension ForgotPasswordViewController {
    @objc final private func Finish(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { (error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
