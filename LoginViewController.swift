//
//  LoginViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/28/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        var users = self.ref.child("users")
        users.observe(.value, with: { snapshot in
            let users_info = snapshot.value as! [String: Any]
            if users_info[self.emailField.text!] == nil {
                print("alert")
            }
            else {
                var potential_user = users.child(self.emailField.text!)
                potential_user.observe(.value, with: { snapshot in
                    var user_info = snapshot.value as! [String: String]
                    if user_info["password"] == self.passwordField.text! {
                        self.performSegue(withIdentifier: "login", sender: self)
                    }
                    else {
                        print("alert")
                    }
                })
            }
        })
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
