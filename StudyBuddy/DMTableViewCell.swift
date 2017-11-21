//
//  DMTableViewCell.swift
//  StudyBuddy
//
//  Created by Alexander You on 11/20/17.
//  Copyright © 2017 Alexander You. All rights reserved.
//

import UIKit

class DMTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
