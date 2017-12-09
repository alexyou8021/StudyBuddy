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

class AddClassViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fieldStudyField: UITextField!
    @IBOutlet weak var courseNumField: UITextField!
    
    @IBAction func addClass(_ sender: Any) {
        if fieldStudyField.text == "" {
            let alert = UIAlertController(title: "", message: "Please enter field of study.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        if courseNumField.text == "" {
            let alert = UIAlertController(title: "", message: "Please enter course number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return
        }
        let user = Auth.auth().currentUser
        let fieldStudy = (fieldStudyField.text)!
        let courseNum = (courseNumField.text)!
        
        var className = "\(fieldStudy)\(courseNum)"
        className = className.replacingOccurrences(of: ".", with: "")
        className = className.replacingOccurrences(of: "#", with: "")
        className = className.replacingOccurrences(of: "$", with: "")
        className = className.replacingOccurrences(of: "[", with: "")
        className = className.replacingOccurrences(of: "]", with: "")
        
        let em = user?.email
        let users = self.ref.child("users")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        let classes = self.ref.child("classes")
        
        classes.child(className).child(em2).setValue(true)
        users.child(em2).child("classes").child(className).setValue(true)
    }
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        fieldStudyField.delegate = self
        courseNumField.delegate = self
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
