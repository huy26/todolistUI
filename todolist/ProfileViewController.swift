//
//  ProfileViewController.swift
//  todolist
//
//  Created by Mac on 10/4/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {

    private let backgroundView = UIView()
    private let userNameLabel = UILabel()
    private let logOutBtn = UIButton()
    private let profileImage = UIImageView()
    private let emailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK:- Setup UI
    
    final private func setupUI(){
        
        setupProfileUI()
        setupLogOutBtn()
        setProfilefromAPI()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    final private func setupProfileUI(){
        self.view.backgroundColor = .white
//        self.tabBarController?.view.snp.makeConstraints{ make in
//            make.bottom.equalToSuperview()
//        }
        
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        backgroundView.backgroundColor = UIColor(red:1.00, green:0.19, blue:0.31, alpha:1.0)
        
        self.view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        userNameLabel.textColor = .white
        userNameLabel.text = ""
        
        self.view.addSubview(profileImage)
        profileImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.size.equalTo(70)
            make.top.equalTo(userNameLabel).offset(45)
        }
        //profileImage.image = UIImage(named: "profile_selected")
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = .white
        profileImage.contentMode = .scaleAspectFill
        
        self.view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints{ make in
            make.top.equalTo(profileImage).offset(80)
            make.centerX.equalToSuperview()
        }
        emailLabel.text = "Email"
        emailLabel.textColor = .white
    }
    
    final private func setupLogOutBtn(){
        self.view.addSubview(logOutBtn)
        logOutBtn.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.setTitleColor(.black, for: .normal)
        logOutBtn.layer.cornerRadius = 10
        logOutBtn.backgroundColor = UIColor(red: 0x00, green: 0x00, blue: 0x00,alpha: 0.1)
        logOutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        logOutBtn.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    final private func setProfilefromAPI(){
        self.emailLabel.text = User.getNamePrint()
        print("username : \(User.getNamePrint())")
        self.userNameLabel.text = User.getNamePrint()
        print("email: \(User.getNamePrint())")
    }
    
    @objc final private func logOutTapped(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Board.resetBoardCount(value: 0)
            self.tabBarController?.navigationController?.viewControllers = [ViewController()]
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
