//
//  BlacklistViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class BlacklistViewController: UIViewController {
    @IBOutlet weak var personField: UITextField!
    @IBAction func blacklistButton(_ sender: Any) {
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        bl.observe(.value, with: { snapshot in
            if snapshot.exists() {
                var blacklist = snapshot.value as! [String: Any]
                blacklist[self.personField.text!] = true
                bl.setValue(blacklist)
            }
            else {
                let blacklist = [self.personField.text!: true]
                bl.setValue(blacklist)
            }
        })
    }
    var ref: DatabaseReference!
    var blacklistArray:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        bl.observe(.value, with: { snapshot in
            if snapshot.exists() {
                var blacklist = snapshot.value as! [String: Any]
                for person in blacklist.keys {
                    self.blacklistArray.append(person)
                }
            }
        })

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
