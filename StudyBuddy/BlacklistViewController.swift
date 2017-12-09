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

class BlacklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var personField: UITextField!
    @IBAction func blacklistButton(_ sender: Any) {
        if personField.text == "" {
            let alert = UIAlertController(title: "", message: "Please enter an email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        bl.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.blacklist = snapshot.value as! [String: Any]
                self.blacklist[self.personField.text!.replacingOccurrences(of: ".", with: "dot")] = true
                self.blacklist.removeValue(forKey: "")
                self.personField.text! = ""
                self.blacklistArray = []
                for person in self.blacklist.keys {
                    print(person)
                    self.blacklistArray.append(person)
                }
                print(bl.key)
                print("x")
                bl.setValue(self.blacklist)
            }
            else {
                self.blacklist = [self.personField.text!.replacingOccurrences(of: ".", with: "dot"): true]
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
        personField.delegate = self
        blacklistTableView.allowsMultipleSelection = false
        ref = Database.database().reference()
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        
        bl.observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.blacklist = snapshot.value as! [String: Any]
                self.blacklist.removeValue(forKey: "")
                //print(self.blacklist)
                self.blacklistArray = []
                for person in self.blacklist.keys {
                    self.blacklistArray.append(person)
                }
                self.blacklistTableView.reloadData()
            }
        })
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as! BlacklistTableViewCell).deleteButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as! BlacklistTableViewCell).deleteButton.isHidden = true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blacklistCell", for: indexPath) as! BlacklistTableViewCell
        cell.emailLabel?.text = blacklistArray[indexPath.item].replacingOccurrences(of: "dot", with: ".")
        cell.deleteButton.addTarget(self, action: #selector(removeUser), for: .touchUpInside)
        cell.deleteButton.isHidden = true
        return cell
    }
    
    func removeUser() {
        let users = ref.child("users")
        let em = Auth.auth().currentUser!.email!.replacingOccurrences(of: ".", with: "dot")
        let user = users.child(em)
        let bl = user.child("blacklist")
        self.blacklist.removeValue(forKey: blacklistArray[(blacklistTableView.indexPathForSelectedRow?.item)!])
        self.blacklistArray = []
        for person in self.blacklist.keys {
            print(person)
            self.blacklistArray.append(person)
        }
        bl.setValue(self.blacklist)
    
        self.blacklistTableView.reloadData()
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
