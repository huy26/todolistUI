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
    
    private let datePicker = UIDatePicker()
    private let backgroundView = UIView()
    private let userNameLabel = UILabel()
    private let logOutBtn = UIButton()
    private let profileImage = UIImageView()
    private let emailLabel = UILabel()
    private let firtnameLb = UILabel()
    private let lastnameLb = UILabel()
    private let birthday = UILabel()
    private let aboutLabel = UILabel()
    private let decorateView = UIView()
    private let saveBtn = UIButton()
    
    private var firstnameTextField = UITextField()
    private var lastnameTextField = UITextField()
    private var birthdayTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK:- Setup UI
    
    final private func setupUI(){
        
        setupProfileUI()
        setupLogOutBtn()
        setProfilefromAPI()
        setupProfileSetting()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    final private func setupProfileUI(){
        self.view.backgroundColor = .white
        //        self.tabBarController?.view.snp.makeConstraints{ make in
        //            make.bottom.equalToSuperview()
        //        }
        
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(300)
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
    
    final private func setupProfileSetting(){
        
        self.view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundView.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(46)
            //make.width.equalTo(83)
            make.height.equalTo(21)
        }
        aboutLabel.text = "About"
        aboutLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        
        
        
        self.view.addSubview(firtnameLb)
        firtnameLb.snp.makeConstraints { (make) in
            make.top.equalTo(aboutLabel.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(46)
            //make.width.equalTo(83)
            make.height.equalTo(21)
        }
        firtnameLb.text = "First Name"
        
        self.view.addSubview(firstnameTextField)
        firstnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firtnameLb.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-46)
            make.width.equalTo(322)
            make.height.equalTo(30)
        }
        firstnameTextField.borderStyle = .roundedRect
        
        self.view.addSubview(lastnameLb)
        lastnameLb.snp.makeConstraints { (make) in
            make.top.equalTo(firstnameTextField.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(46)
            make.height.equalTo(21)
        }
        lastnameLb.text = "Last Name"
        
        self.view.addSubview(lastnameTextField)
        lastnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(lastnameLb.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-46)
            make.height.equalTo(30)
        }
        lastnameTextField.borderStyle = .roundedRect
        
        self.view.addSubview(birthday)
        birthday.snp.makeConstraints { (make) in
            make.top.equalTo(lastnameTextField.snp.bottom).offset(11)
            make.left.equalToSuperview().offset(46)
            make.height.equalTo(21)
        }
        birthday.text = "Birthday"
        
        self.view.addSubview(birthdayTextField)
        birthdayTextField.snp.makeConstraints { (make) in
            make.top.equalTo(birthday.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-46)
            make.height.equalTo(30)
        }
        birthdayTextField.borderStyle = .roundedRect
        
        self.view.addSubview(saveBtn)
        saveBtn.snp.makeConstraints{ make in
            make.top.equalTo(birthdayTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(46)
            make.right.equalToSuperview().offset(-46)
        }
        saveBtn.addTarget(self, action: #selector(saveProfile(_sender:)), for: .touchUpInside)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.backgroundColor = .systemGreen
        saveBtn.layer.cornerRadius = 10
        
        showdatePicker()
    }
    
    private final func showdatePicker() {
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(canceldatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        birthdayTextField.inputAccessoryView = toolbar
        birthdayTextField.inputView = datePicker
    }
    @objc final private func donedatePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdayTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc final private func canceldatePicker() {
        self.view.endEditing(true)
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
    
    @objc final private func saveProfile(_sender: Any){
        let firstname = firstnameTextField.text
        let lastname = lastnameTextField.text
        let birthday = birthdayTextField.text
        
        let currentuser = Auth.auth().currentUser
        if currentuser != nil{
            
            updateUserAPI(firstName: firstname!, lastName: lastname!, userPhone: "", birthDay: birthday! , avatarURL: "", email: "")
            
        }
    }
}
