//
//  tmHeadView.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/21.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

typealias swiftBlock = () -> Void

class tmHeadView: UIView {

    @IBOutlet var bgView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var edit: UILabel!
    @IBOutlet weak var headerButton: UIButton!
    
    var callBack : swiftBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgView = loadViewFromNib()
        bgView.frame = bounds
        addSubview(bgView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bgView = loadViewFromNib()
        bgView.frame = bounds
        addSubview(bgView)
    }
    
    func loadViewFromNib() -> UIView {
        let nib = UINib(nibName: String(describing: tmHeadView.self), bundle: Bundle(for: tmHeadView.self))
        let view = nib.instantiate(withOwner: self, options: nil)[0]
        return view as! UIView
    }
    
    @IBAction func editButton(_ sender: Any) {
        if callBack != nil {
            callBack!()
        }
    }
    
    func callBackBlock(_ block: @escaping swiftBlock) {
        callBack = block
    }
}
