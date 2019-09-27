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

class SignupViewViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var getstarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ongetstarted(_ sender: Any) {
        
    }
    func  validateField() -> String? {
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines
            ) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmpasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Please fill in all fields"
        }
        else if passwordTextField.text != confirmpasswordTextField.text {
            return "Password and Confirm password are not matched"
        }
        return nil
    }
    
    @IBAction func signupTapped(_sender: Any){
        let username = usernameTextField.text
        let password = passwordTextField.text
        let error = validateField()
        if error != nil
        {
            print(error!)
        }
        else
        {
            Auth.auth().createUser(withEmail: username!, password: password!) { (result, err) in
                if err != nil{
                    print("Error creating user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data:[ "username": username!, "password" : password!, "uid": result!.user.uid ]){ (error) in
                        if error != nil {
                            print("Error saving user data")
                            return
                        }
                        uploadUserAPI(firstName: "hello gia ba", lastName: "dm", userPhone: "", birthDay:"" , avatarURL: "", email: username!)
                        self.transitiontoHome()
                    }
                    
                }
            }
        }
        
    }
    func transitiontoHome() {
        let homeViewcontroller = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
        self.present(homeViewcontroller, animated: true, completion: nil)
    }

}
extension SignupViewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
