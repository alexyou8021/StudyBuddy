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

class BlacklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var personField: UITextField!
    @IBAction func blacklistButton(_ sender: Any) {
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        bl.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.blacklist = snapshot.value as! [String: Any]
                self.blacklist[self.personField.text!] = true
                self.blacklistArray = []
                for person in self.blacklist.keys {
                    print(person)
                    self.blacklistArray.append(person)
                }
                bl.setValue(self.blacklist)
            }
            else {
                self.blacklist = [self.personField.text!: true]
                self.blacklistArray = []
                for person in self.blacklist.keys {
                    print(person)
                    self.blacklistArray.append(person)
                }
                bl.setValue(self.blacklist)
            }
            self.blacklistTableView.reloadData()
        })
    }
    @IBOutlet weak var blacklistTableView: UITableView!
    var ref: DatabaseReference!
    var blacklist:[String:Any] = [:]
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
                self.blacklist = snapshot.value as! [String: Any]
                //print(self.blacklist)
                self.blacklistArray = []
                for person in self.blacklist.keys {
                    print(person)
                    self.blacklistArray.append(person)
                }
                self.blacklistTableView.reloadData()
            }
        })
        
        print(blacklistArray)
        blacklistTableView.delegate = self
        blacklistTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blacklistArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blacklistCell", for: indexPath)
        cell.textLabel?.text = blacklistArray[indexPath.item]
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
