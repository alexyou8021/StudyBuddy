//
//  AddClassViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddClassViewController: UIViewController {
    @IBOutlet weak var fieldStudyField: UITextField!
    @IBOutlet weak var courseNumField: UITextField!
    
    @IBAction func addClass(_ sender: Any) {
        let user = Auth.auth().currentUser
        let fieldStudy = (fieldStudyField.text)!
        let courseNum = (courseNumField.text)!
        let className = "\(fieldStudy)\(courseNum)"
        
        let em = user?.email
        let users = self.ref.child("users")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        users.child(em2).child("classes").child(className).setValue(true)
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
