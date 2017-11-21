//
//  SettingsViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: UIViewController {
    @IBAction func autologin_switch(_ sender: Any) {
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        ref.child("users").child(em2).child("autologin").setValue(autologin.isOn)
    }
    @IBOutlet weak var autologin: UISwitch!

    @IBAction func blacklistSwitch(_ sender: Any) {
        if blacklist.isOn {
            toBlacklist.isHidden = false
        }
        else {
            toBlacklist.isHidden = true
        }
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        ref.child("users").child(em2).child("blacklisting").setValue(blacklist.isOn)
    }
    @IBOutlet weak var toBlacklist: UIButton!
    @IBOutlet weak var blacklist: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

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
