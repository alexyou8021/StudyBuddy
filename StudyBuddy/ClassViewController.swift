//
//  ClassViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 12/5/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ClassViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var studentView: UITableView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var classId: String!
    var user_map:[String:Bool] = [:]
    var user_keys:[String] = []
    var scheduleViewVC: MyScheduleViewController!
    var numUsers = 0
    var ref: DatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classLabel.text = classId
        studentView.delegate = self
        studentView.dataSource = self
        ref = Database.database().reference()
        
        self.ref.child("classes").child(classId).observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.numUsers = Int(snapshot.childrenCount)
                self.user_map = snapshot.value as! [String:Bool]
                self.user_keys = Array(self.user_map.keys)
                self.studentView.reloadData()
            } else {
                self.numUsers = 0
                self.user_map = [:]
                self.user_keys = []
                self.studentView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteClass(_ sender: Any) {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        self.ref.child("users").child(em2).child("classes").child(classId).removeValue()
        self.ref.child("classes").child(classId).child(em2).removeValue()
        self.deleteButton.isEnabled = false
        self.deleteButton.setTitle("Class Deleted", for: .normal)
        self.scheduleViewVC.scheduleTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numUsers;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classUserCell", for: indexPath)
        
        // Configure the cell...
        
        let object = self.user_keys[indexPath.row]
        
        var substrings = object.components(separatedBy: "@")
        let ending = substrings[1].replacingOccurrences(of: "dot", with: ".")
        cell.textLabel?.text = substrings[0] + "@" + ending
        
        return cell
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
