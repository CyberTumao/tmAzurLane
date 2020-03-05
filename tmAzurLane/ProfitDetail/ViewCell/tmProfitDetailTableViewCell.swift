//
//  tmProfitDetailTableViewCell.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmProfitDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var introduction: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    var count:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Button Click
    @IBAction func plusClick(_ sender: Any) {
        count += 1
        if count > 0 {
            minus.isEnabled = true
        }
        number.text = String(count)
    }
    
    @IBAction func minusClick(_ sender: Any) {
        count -= 1
        if count <= 0 {
            count = 0
            minus.isEnabled = false
        }
        number.text = String(count)
    }
    
    func setCount(_ count:Int) {
        self.count = count
        if count <= 0 {
            minus.isEnabled = false
        }
    }
    
}
