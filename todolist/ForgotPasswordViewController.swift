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

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Finish(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { (error) in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else{
                let homeViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! UINavigationController
                self.present(homeViewcontroller, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
