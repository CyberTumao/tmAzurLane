//
//  tmEquipmentBlueprintCollectionViewCell.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmEquipmentBlueprintCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var introduction: UILabel!
    @IBOutlet weak var introductionMiddle: UILabel!
    
    lazy var hasClicked = {
        return false
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func startAnimate(width:CGFloat) {
        if introduction.isHidden {
            print("\(#function)introduction.isHidden")
            return
        }
        if hasClicked {
            continueAnimate()
            print("\(#function)hasClicked==true")
            return
        }
        print("\(#function)hasClicked==false")
        hasClicked = true
        
        let option = UIView.AnimationOptions.repeat.rawValue|UIView.AnimationOptions.autoreverse.rawValue|UIView.AnimationOptions.curveLinear.rawValue
        let text = self.introduction.text! as NSString
        let offset = text.size(withAttributes: [.font:UIFont.systemFont(ofSize: 18)]).width-width
        
        UIView.animate(withDuration: TimeInterval(3.0*offset/100), delay: 0, options:  UIView.AnimationOptions(rawValue: option), animations: {
            self.introduction.transform = CGAffineTransform(translationX: -offset, y: 0)
        }, completion: nil)
    }

    func stopAnimate() {
        self.introduction.layer.removeAllAnimations()
    }
    
    func pauseAnimate() {
        self.introduction.layer.speed = 0
        self.introduction.layer.timeOffset = 0
    }
    
    func continueAnimate() {
        self.introduction.layer.speed = 1
        self.introduction.layer.timeOffset = 0
        self.introduction.layer.beginTime = 0
//        self.introduction.layer.beginTime = self.introduction.layer.convertTime(CACurrentMediaTime(), from: nil)
    }
}

extension tmEquipmentBlueprintCollectionViewCell {
    func setIntroductionText(_ text:String, width:CGFloat) {
        let offset = text.size(withAttributes: [.font:UIFont.systemFont(ofSize: 18)]).width-width
        guard offset >= 0 else {
            introductionMiddle.text = text
            introductionMiddle.isHidden = false
            introduction.isHidden = true
            return
        }
        introduction.text = text
    }
}
