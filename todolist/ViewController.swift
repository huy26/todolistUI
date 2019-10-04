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

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var Signup: UIButton!

    @IBOutlet weak var appLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.delegate = self
        self.usernameTextField.delegate = self
        // Do any additional setup after loading the view.
        let currentuser = Auth.auth().currentUser
        if currentuser != nil
        {
            getUserAPI()
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
            self.present(homeViewController, animated: true, completion: nil)
        }
        passwordTextField?.isSecureTextEntry = true
        appLogo.image = UIImage(named: "icon")!
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    @IBAction func onSignup(_ sender: Any) {
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        let username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
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
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

