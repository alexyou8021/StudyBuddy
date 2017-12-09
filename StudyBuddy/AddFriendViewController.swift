//
//  AddFriendViewController.swift
//  StudyBuddy
//
//  Created by Mitchell Minkoff on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class AddFriendViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var friendEmail: UITextField!
    
    @IBAction func addFriendButton(_ sender: Any) {
        if friendEmail.text == "" {
            let alert = UIAlertController(title: "", message: "Please enter email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        let user = Auth.auth().currentUser
        
        let friendName = friendEmail.text
        
        let em = user?.email
        let users = self.ref.child("users")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let friendName2 = friendName!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let friends = users.child(em2).child("friends")
        
        users.child("\(friendName2)/blacklisting").observe(.value, with: { snapshot in
            if snapshot.exists() {
                if snapshot.value! as! Bool == true {
                    users.child("\(friendName2)/blacklist/\(em2)").observe(.value, with: { snapshot in
                        if snapshot.exists() {
                            let alert = UIAlertController(title: "", message: "Cannot add this user as friend.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)

                        }
                        else {
                            friends.child(friendName2).setValue(true)
                        }
                    })
                }
                else {
                    friends.child(friendName2).setValue(true)
                }
            }
            else {
                friends.child(friendName2).setValue(true)
            }
        })
        
        performSegue(withIdentifier: "AddFriend2Schedule", sender: self)
    }
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendEmail.delegate = self
        
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
