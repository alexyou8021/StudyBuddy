//
//  LoginViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/28/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        let email = emailField.text
        let password = passwordField.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                let alert = UIAlertController(title: "", message: "The username or password is incorrect.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
            
    }
    var ref: DatabaseReference!
    var login_alert:UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Below code taken from TestKeyboardDismiss
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
