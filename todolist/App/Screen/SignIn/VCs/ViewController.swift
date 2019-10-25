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
    
    private var logoImageView = UIImageView()
    private var welcomeLabel = UILabel()
    private var welcomeLabel2 = UILabel()
    private var emailLabel = UILabel()
    private var passwordLabel = UILabel()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var getStartedBtn = UIButton()
    private var signUpBtn = UIButton()
    private var forgotPasswordBtn = UIButton()
    
    private let dashboard = DashboardViewController()
    private let tabbarController = TabBarController()

    // MARK:- Load View
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self

        setupLoginUI()
        
        
        
        // MARK:- auto login
        let currentuser = Auth.auth().currentUser
        if currentuser != nil{
            getUserAPI { (error, user) in
                if let error = error {
                    return
                }
                if user != nil {
                    self.navigationController?.pushViewController(self.tabbarController, animated: true)
                }
            }
        }
    }
}

//MARK:- Private function
extension ViewController {
    final private func showLoginAlert(){
        let alertController = UIAlertController(title: "Login failed", message: "email or password is incorrect", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController,animated: true)
    }
}

//MARK:- setupUI
extension ViewController {
    final private func setupLoginUI() {
        self.view.backgroundColor = .white
        setupImageView()
        setupWelcomeLabel()
        setupTextField()
        setupForgotBtn()
        setupGetStartedBtn()
        setupSignUpBtn()
    }
    
    final private func setupImageView(){
        self.view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints{ make in
            logoImageView.image = UIImage(named: "logo")
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(48)
            make.height.equalTo(26)
            make.width.equalTo(43)
        }
    }
    
    final private func setupWelcomeLabel(){
        self.view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints{ make in
            make.top.equalTo(logoImageView).offset(47)
            make.left.equalToSuperview().offset(49)
        }
        welcomeLabel.text = "Welcome,"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        welcomeLabel.textColor = .black
        
        
        self.view.addSubview(welcomeLabel2)
        
        welcomeLabel2.snp.makeConstraints{ make in
            make.top.equalTo(welcomeLabel).offset(40)
            make.left.equalToSuperview().offset(48)
        }
        welcomeLabel2.text = "Sign in to continue"
        welcomeLabel2.font = UIFont.systemFont(ofSize: 23)
        welcomeLabel2.textColor = .gray
    }
    
    final private func setupTextField(){
        self.view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints{ make in
            make.top.equalTo(welcomeLabel2).offset(85)
            make.left.equalToSuperview().offset(49)
        }
        emailLabel.text = "Email"
        emailLabel.textColor = .black
        
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
        passwordLabel.textColor = .black
        
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
    //MARK: Button
    final private func setupForgotBtn(){
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
    
    final private func setupGetStartedBtn(){
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
    
    final private func setupSignUpBtn() {
        self.view.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-5)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        signUpBtn.setTitle("Don't have an account? Sign up", for: .normal)
        signUpBtn.setTitleColor(.blue, for: .normal)
        signUpBtn.layer.cornerRadius = 10
        signUpBtn.backgroundColor = UIColor(red: 0xe6, green: 0xe6, blue: 0xe6,alpha: 0.75)
        signUpBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        signUpBtn.addTarget(self, action: #selector(onSignup(_:)), for: .touchUpInside)
    }
}

 //MARK:- Action Function
extension ViewController {
   
    @objc final private func onSignup(_ sender: Any) {

        //self.show(SignupViewViewController(), sender: self)

        let vc = SignupViewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc final private func signinTapped(_ sender: Any) {
        let username = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                print (error!.localizedDescription)
                self.showLoginAlert()
            }
            else{
                getUserAPI { (error, user) in
                    if let error = error {
                        debugPrint(error)
                        self.showLoginAlert()
                    }
                    if let user = user {
                        self.navigationController?.pushViewController(self.tabbarController, animated: true)
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                    }
                }
                
            }
        }
    }
    
    @objc final private func swithedToForgotView(_ sender: Any) {
        //self.show(ForgotPasswordViewController() ,sender: self)
        self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

