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

class AddFriendViewController: UIViewController {

    @IBOutlet weak var friendEmail: UITextField!
    
    @IBAction func addFriendButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        let friendName = friendEmail.text
        
        let em = user?.email
        let users = self.ref.child("users")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let friendName2 = friendName!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let friends = users.child(em2).child("friends")
        
        friends.child(friendName2).setValue(true)
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
