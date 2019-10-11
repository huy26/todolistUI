//
//  SignupViewViewController.swift
//  todolist
//
//  Created by Mac on 06/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SnapKit

class SignupViewViewController: UIViewController {
    
    
    private let datePicker = UIDatePicker()
    private var scrollview = UIScrollView()
    private var container = UIView()
    private var appLogo = UIImageView()
    private var welcome = UILabel()
    private var message = UILabel()
    private var firtnameLb = UILabel()
    private var firstnameTextField = UITextField()
    private var lastnameTextField = UITextField()
    private var lastnameLb = UILabel()
    private var birthday = UILabel()
    private var birthdayTextField = UITextField()
    private var emailTextField = UITextField()
    private var emailLb = UILabel()
    private var passwordTextField = UITextField()
    private var passwordLb = UILabel()
    private var confirmpasswordTextField = UITextField()
    private var confirmpwdLb = UILabel()
    private var getstarted = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmpasswordTextField.delegate = self
        getstarted.layer.cornerRadius = 10
        getstarted.layer.borderWidth = 1
        getstarted.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        passwordTextField.isSecureTextEntry = true
        confirmpasswordTextField.isSecureTextEntry = true
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        setupUI()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    private func setupUI() {
        self.view.addSubview(scrollview)
        scrollview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        scrollview.backgroundColor = UIColor.white
        
        scrollview.addSubview(container)
        container.snp.makeConstraints { (make) in
//            make.top.bottom.equalTo(self.scrollview)
//            make.left.right.equalTo(self.view)
//            make.width.equalTo(self.scrollview)
//            make.height.equalTo(self.scrollview)
            make.edges.equalToSuperview()
        }
        
        container.addSubview(appLogo)
        appLogo.snp.makeConstraints { (make) in
            make.top.equalTo(self.container).offset(30)
            make.left.equalTo(self.container).offset(46)
            make.width.equalTo(45)
            make.height.equalTo(26)
        }
        appLogo.image = UIImage(named: "icon")
        
        container.addSubview(welcome)
        welcome.snp.makeConstraints { (make) in
            make.top.equalTo(appLogo.snp.bottom).offset(26)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(36)
        }
        welcome.text = "Welcome,"
        welcome.font = UIFont.boldSystemFont(ofSize: 30)
   
        
        container.addSubview(message)
        message.snp.makeConstraints { (make) in
            make.top.equalTo(welcome.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(36)
        }
        message.font = UIFont.systemFont(ofSize: 30)
        message.text = "Sign up to continue"
        
        container.addSubview(firtnameLb)
        firtnameLb.snp.makeConstraints { (make) in
            make.top.equalTo(message.snp.bottom).offset(45)
            make.left.equalTo(self.container).offset(46)
            //make.width.equalTo(83)
            make.height.equalTo(21)
        }
        firtnameLb.text = "First Name"
        
        container.addSubview(firstnameTextField)
        firstnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firtnameLb.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.width.equalTo(322)
            make.height.equalTo(30)
        }
        firstnameTextField.borderStyle = .roundedRect
        
        container.addSubview(lastnameLb)
        lastnameLb.snp.makeConstraints { (make) in
            make.top.equalTo(firstnameTextField.snp.bottom).offset(11)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(21)
        }
        lastnameLb.text = "Last Name"

        container.addSubview(lastnameTextField)
        lastnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(lastnameLb.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.height.equalTo(30)
        }
        lastnameTextField.borderStyle = .roundedRect

        container.addSubview(birthday)
        birthday.snp.makeConstraints { (make) in
            make.top.equalTo(lastnameTextField.snp.bottom).offset(11)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(21)
        }
        birthday.text = "Birthday"

       container.addSubview(birthdayTextField)
        birthdayTextField.snp.makeConstraints { (make) in
            make.top.equalTo(birthday.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.height.equalTo(30)
        }
        birthdayTextField.borderStyle = .roundedRect

        container.addSubview(emailLb)
        emailLb.snp.makeConstraints { (make) in
            make.top.equalTo(birthdayTextField.snp.bottom).offset(11)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(21)
        }
        emailLb.text = "Email"

        container.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLb.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.height.equalTo(30)
        }
        emailTextField.borderStyle = .roundedRect

        container.addSubview(passwordLb)
        passwordLb.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(11)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(21)
        }
        passwordLb.text = "Password"

        container.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLb.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.height.equalTo(30)
        }
        passwordTextField.borderStyle = .roundedRect

        container.addSubview(confirmpwdLb)
        confirmpwdLb.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(11)
            make.left.equalTo(self.container).offset(46)
            make.height.equalTo(21)
        }
        confirmpwdLb.text = "Confirm Password"

        container.addSubview(confirmpasswordTextField)
        confirmpasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(confirmpwdLb.snp.bottom).offset(8)
            make.left.equalTo(self.container).offset(46)
            make.right.equalTo(self.container).offset(-46)
            make.height.equalTo(30)
        }
        confirmpasswordTextField.borderStyle = .roundedRect
        
        container.addSubview(getstarted)
        getstarted.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.container)
            make.bottom.equalTo(self.container).offset(-50)
            make.top.equalTo(confirmpasswordTextField.snp.bottom).offset(40)
            make.width.equalTo(148)
            make.height.equalTo(58)
        }
        getstarted.setTitle("Get Started", for: .normal)
        getstarted.titleLabel!.font = UIFont.boldSystemFont(ofSize: 22)
        getstarted.setTitleColor(.black, for: .normal)
        getstarted.backgroundColor = UIColor.groupTableViewBackground
        getstarted.layer.cornerRadius = 10
        getstarted.addTarget(self, action: #selector(getstarted(_sender:)), for: .touchUpInside)

        showdatePicker()
        
    }
    
    private func showdatePicker() {
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
    @objc func donedatePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdayTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func canceldatePicker() {
        self.view.endEditing(true)
    }
    
    func  validateField() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines
            ) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmpasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields"
        }
        else if passwordTextField.text != confirmpasswordTextField.text {
            return "Password and Confirm password are not matched"
        }
        return nil
    }
    
    @objc func getstarted(_sender: Any){
        let firstname = firstnameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let birthday = birthdayTextField.text
        let error = validateField()
        if error != nil
        {
            print(error!)
        }
        else
        {
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                if err != nil{
                    print("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data:[ "username": email!, "password" : password!, "uid": result!.user.uid ]){ (error) in
                        if error != nil {
                            print("Error saving user data")
                            return
                        }
                        uploadUserAPI(firstName: firstname!, lastName: lastname!, userPhone: "", birthDay: birthday! , avatarURL: "", email: email!)
                        self.transitiontoHome()
                    }
                    
                }
            }
        }
        
    }
    func transitiontoHome() {
        let homeViewcontroller = DashboardViewController()
        self.present(homeViewcontroller, animated: true, completion: nil)
    }

}
extension SignupViewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
