//
//  AddEventViewController.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/29/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    var selectedFriends: Set<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFriends = Set<String>()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEvent(_ sender: UIButton) {
        let name = nameField.text!
        let time = timeField.text!
        let location = locationField.text!
        if (name.count > 0 && time.count > 0 && location.count > 0){
            EventDataService.saveEvent(name: name, time: time, location: location, invites: selectedFriends)
            statusLabel.text = "Event added successfully"
        } else {
           statusLabel.text = "Must fill out all fields"
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seg = segue.destination as! EventFriendsTableViewController
        // Pass the selected object to the new view controller.
        seg.addEventVC = self
    }
    

}
