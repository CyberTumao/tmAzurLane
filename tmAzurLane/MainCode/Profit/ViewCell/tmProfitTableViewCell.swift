//
//  tmProfitTableViewCell.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmProfitTableViewCell: UITableViewCell {
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var dateText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let gradient = CAGradientLayer()
//        gradient.frame = addView.bounds
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 0)
//        gradient.colors = [kRGBA(r: 57, g: 123, b: 255, a: 1).cgColor, UIColor.white.cgColor]
//        addView.layer.addSublayer(gradient)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
