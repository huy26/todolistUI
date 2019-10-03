//
//  ViewController.swift
//  todolist
//
//  Created by Mac on 06/09/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SnapKit

class ViewController: UIViewController {
    
    var logoImageView = UIImageView()
    var welcomeLabel = UILabel()
    var welcomeLabel2 = UILabel()
    var emailLabel = UILabel()
    var passwordLabel = UILabel()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var getStartedBtn = UIButton()
    var signUpBtn = UIButton()
    var forgotPasswordBtn = UIButton()
    
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var usernameTextField: UITextField!
//    @IBOutlet weak var Signup: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.passwordTextField.delegate = self
//        self.usernameTextField.delegate = self
//        // Do any additional setup after loading the view.
        let currentuser = Auth.auth().currentUser
        if currentuser != nil
        {
            getUserAPI()
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
            self.present(homeViewController, animated: true, completion: nil)
        }
//        passwordTextField?.isSecureTextEntry = true
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
        setupLoginUI()
    }
    
    func setupLoginUI() {
        self.view.backgroundColor = .white
        setupImageView()
        setupWelcomeLabel()
        setupTextField()
        setupForgotBtn()
        setupGetStartedBtn()
        setupSignUpBtn()
    }
    
    func setupImageView(){
        self.view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints{ make in
            logoImageView.image = UIImage(named: "logo")
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(48)
            make.height.equalTo(26)
            make.width.equalTo(43)
        }
    }
    
    func setupWelcomeLabel(){
        self.view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints{ make in
            make.top.equalTo(logoImageView).offset(47)
            make.left.equalToSuperview().offset(49)
        }
        welcomeLabel.text = "Welcome,"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        self.view.addSubview(welcomeLabel2)
        
        welcomeLabel2.snp.makeConstraints{ make in
            make.top.equalTo(welcomeLabel).offset(40)
            make.left.equalToSuperview().offset(48)
        }
        welcomeLabel2.text = "Sign in to continue"
        welcomeLabel2.font = UIFont.systemFont(ofSize: 23)
        welcomeLabel2.textColor = .gray
    }
    
    func setupTextField(){
        self.view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints{ make in
            make.top.equalTo(welcomeLabel2).offset(85)
            make.left.equalToSuperview().offset(49)
        }
        emailLabel.text = "Email"
        
        self.view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{ make in
            make.top.equalTo(emailLabel).offset(25)
            make.left.equalToSuperview().offset(48)
            //make.width.equalTo(322)
            make.right.equalToSuperview().offset(-48)
        }
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        
        self.view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints{ make in
            make.top.equalTo(emailTextField).offset(47)
            make.left.equalToSuperview().offset(49)
        }
       passwordLabel.text = "Password"
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(passwordLabel).offset(25)
            make.left.equalToSuperview().offset(48)
            //make.width.equalTo(322)
            make.right.equalToSuperview().offset(-48)
        }
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
    }
    
    func setupForgotBtn(){
        self.view.addSubview(forgotPasswordBtn)
        forgotPasswordBtn.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField).offset(30)
            make.right.equalToSuperview().offset(-48)
        }
        forgotPasswordBtn.setTitle("Forgot password?", for: .normal)
        forgotPasswordBtn.setTitleColor(.lightGray, for: .normal)
        forgotPasswordBtn.layer.cornerRadius = 10
        forgotPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        forgotPasswordBtn.addTarget(self, action: #selector(swithedToForgotView(_:)), for: .touchUpInside)  // To-do : add function move to forgot password view
    }
    
    func setupGetStartedBtn(){
        self.view.addSubview(getStartedBtn)
        getStartedBtn.snp.makeConstraints{ make in
            make.top.equalTo(passwordTextField).offset(110)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(180)
        }
        getStartedBtn.setTitle("Get Started ->", for: .normal)
        getStartedBtn.setTitleColor(.black, for: .normal)
        getStartedBtn.layer.cornerRadius = 10
        getStartedBtn.backgroundColor = UIColor(red: 0x00, green: 0x00, blue: 0x00,alpha: 0.1)
        getStartedBtn.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        getStartedBtn.addTarget(self, action: #selector(signinTapped(_:)), for: .touchUpInside)
    }
    
    func setupSignUpBtn() {
        self.view.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        signUpBtn.setTitle("Don't have an account? Sign up", for: .normal)
        signUpBtn.setTitleColor(.systemBlue, for: .normal)
        signUpBtn.layer.cornerRadius = 10
        signUpBtn.backgroundColor = UIColor(red: 0xe6, green: 0xe6, blue: 0xe6,alpha: 0.75)
        signUpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        signUpBtn.addTarget(self, action: #selector(onSignup(_:)), for: .touchUpInside)
    }
    
    @objc func onSignup(_ sender: Any) {
    }
    
    @objc func signinTapped(_ sender: Any) {
        let username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                print (error!.localizedDescription)
            }
            else
            {
                getUserAPI()
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
                self.present(homeViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func swithedToForgotView(_ sender: Any) {
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "forgotView") as! UIViewController
        self.present(homeViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
