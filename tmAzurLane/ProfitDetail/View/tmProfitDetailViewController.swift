//
//  tmProfitDetailViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmProfitDetailViewController: UIViewController {
    var historyId:Int?
    lazy var presenter:tmProfitDetailPresenter? = {
        return tmProfitDetailPresenter()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
