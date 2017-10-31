//
//  RegisterViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/28/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func registerButton(_ sender: Any) {
        if emailField.text == "" {
            let alert = UIAlertController(title: "", message: "Please enter a valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            var user = ["email": emailField.text, "password": passwordField.text]
            var users = self.ref.child("users")
            var user_info = users.child(emailField.text! as String)
            users.observe(.value, with: { snapshot in
                let users_info = snapshot.value as! [String: Any]
                if users_info[self.emailField.text!] == nil {
                    users.child(self.emailField.text!).setValue(user)
                    self.performSegue(withIdentifier: "register", sender: self)
                }
                else {
                    print("alert")
                    let alert = UIAlertController(title: "", message: "This username is already in use.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
