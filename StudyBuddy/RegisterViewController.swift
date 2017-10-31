//
//  RegisterViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/28/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseAnalytics

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
            let email = emailField.text
            let password = passwordField.text
            if (password?.characters.count)! < 6 {
                let alert = UIAlertController(title: "", message: "Password must be at least 6 characters.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                    if error == nil {
                        let em = email
                        let users = self.ref.child("users")
                        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
                        users.child(em2).child("first_name").setValue(self.firstNameField.text)
                        users.child(em2).child("last_name").setValue(self.lastNameField.text)
                        
                        self.performSegue(withIdentifier: "register", sender: self)
                    } else {
                        let alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
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
