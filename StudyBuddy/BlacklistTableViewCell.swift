//
//  BlacklistTableViewCell.swift
//  StudyBuddy
//
//  Created by Alexander You on 12/9/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit

class BlacklistTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func removeUser(_ sender: Any) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
