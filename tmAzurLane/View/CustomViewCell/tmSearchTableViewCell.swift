//
//  tmSearchTableViewCell.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/18.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
