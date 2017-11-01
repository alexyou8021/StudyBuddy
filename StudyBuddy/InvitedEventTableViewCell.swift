//
//  InvitedEventTableViewCell.swift
//  StudyBuddy
//
//  Created by Vikram Idury on 10/31/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit

class InvitedEventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    var event: Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func eventAccepted(_ sender: UIButton) {
        EventDataService.acceptEventInvite(event: event)
    }
    
    @IBAction func eventDeclined(_ sender: UIButton) {
        EventDataService.declineEventInvite(event: self.event)
    }
    
}
