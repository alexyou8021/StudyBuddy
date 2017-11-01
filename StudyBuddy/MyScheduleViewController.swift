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
    var numClasses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        ref = Database.database().reference()
        
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        print(em2)
        
        self.ref.child("users").child(em2).child("classes").observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.numClasses = Int(snapshot.childrenCount)
                self.main_classes = snapshot.value as! [String:Bool]
                self.keys = Array(self.main_classes.keys)
                self.scheduleTableView.reloadData()
            } else {
                self.main_classes = [:]
                self.keys = []
                self.scheduleTableView.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func get_amount() -> Int {
        
        
        return self.numClasses
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
        return self.numClasses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
        
        // Configure the cell...
        
        let object = self.keys[indexPath.row]
        
        cell.textLabel?.text = object
        
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
