//
//  DMViewController.swift
//  StudyBuddy
//
//  Created by Alexander You on 11/20/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class DMViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var friendEmail:String?
    var ref:DatabaseReference!
    var messages:[[String: String]] = []
    var messageCount = 0
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var messageInput: UITextField!
    @IBAction func sendBtn(_ sender: Any) {
        let user = Auth.auth().currentUser
        let em = user?.email
        let users = self.ref.child("users")
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        
        self.ref?.child("users").child(em2).child("messages").child(friendEmail!).observe(.value, with: { snapshot in
            if snapshot.exists() {
                self.messageCount = Int(snapshot.childrenCount)
            } else {
                self.messageCount = 0
            }
        })

        let convo = users.child(em2).child("messages").child(friendEmail!)
        convo.child("\(messageCount)").child(messageInput.text!).setValue(true)
        let convo2 = users.child(friendEmail!).child("messages").child(em2)
        convo2.child("\(messageCount)").child(messageInput.text!).setValue(false)
        messageInput.text = ""
        self.ref?.child("users").child(em2).child("messages").child(friendEmail!).observe(.value, with: { snapshot1 in
            if snapshot1.exists() {
                self.messageCount = Int(snapshot1.childrenCount)
            } else {
                self.messageCount = 0
            }
            var messageList:[[String: String]] = []
            for i in 0 ..< self.messageCount {
                self.ref?.child("users").child(em2).child("messages").child(self.friendEmail!).child("\(i)").observe(.value, with: { snapshot in
                    if snapshot.exists() {
                        let message = Array((snapshot.value as! [String: Bool]).keys)
                        if (snapshot.value as! [String:Bool])[message[0]]! {
                            var messageDict:[String: String] = [:]
                            messageDict["author"] = em!
                            messageDict["message"] = message[0]
                            messageList.append(messageDict)
                        }
                    } else {
                        self.messages = []
                    }
                    self.messageTable.reloadData()
                    self.messageTable.scrollToRow(at: IndexPath(item:self.messages.count-1, section: 0), at: .bottom, animated: false)
                })
            }
            self.messages = messageList
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.dataSource = self
        messageTable.delegate = self
        
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        let em = user?.email
        let em2 = em!.replacingOccurrences(of: ".", with: "dot", options: .literal, range: nil)
        self.ref?.child("users").child(em2).child("messages").child(friendEmail!).observe(.value, with: { snapshot1 in
            if snapshot1.exists() {
                self.messageCount = Int(snapshot1.childrenCount)
            } else {
                self.messageCount = 0
            }
            for i in 0 ..< self.messageCount {
                self.ref?.child("users").child(em2).child("messages").child(self.friendEmail!).child("\(i)").observe(.value, with: { snapshot in
                    if snapshot.exists() {
                        //print(snapshot.value)
                        let message = Array((snapshot.value as! [String: Bool]).keys)
                        if (snapshot.value as! [String:Bool])[message[0]]! {
                            var messageDict:[String: String] = [:]
                            messageDict["author"] = em!
                            messageDict["message"] = message[0]
                            self.messages.append(messageDict)
                        }
                        else {
                            var messageDict:[String: String] = [:]
                            messageDict["author"] = self.friendEmail!
                            messageDict["message"] = message[0]
                            self.messages.append(messageDict)
                        }
                    } else {
                        self.messages = []
                    }
                    self.messageTable.reloadData()
                    //self.messageTable.scrollToRow(at: IndexPath(item:self.messages.count-1, section: 0), at: .bottom, animated: false)
                })
            }
        })

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
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! DMTableViewCell
        // Configure the cell...
        let fem = messages[indexPath.item]["author"]
        var substrings = fem?.split(separator: "@")
        let ending = substrings![1].replacingOccurrences(of: "dot", with: ".")
        cell.nameLabel.text = substrings![0] + "@" + ending
        cell.messageLabel.text = messages[indexPath.item]["message"]
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
