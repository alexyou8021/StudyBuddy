//
//  MyScheduleViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class MyScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scheduleTableView: UITableView!
    
    var main_classes:[String:Bool] = [:]
    var keys:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    var ref: DatabaseReference!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        var num = 0
        
        self.ref.child("users").child(em2).child("classes").observe(.value, with: { snapshot in
            num = Int(snapshot.childrenCount)
        })
        
        return num
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        // Configure the cell...
        self.ref.child("users").child(em2).child("classes").observe(.value, with: { snapshot in
            self.main_classes = snapshot.value as! [String:Bool]
            self.keys = Array(self.main_classes.keys)
        })
        
        let object = self.keys[indexPath.row]
        
        cell.textLabel?.text =  object
        
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
