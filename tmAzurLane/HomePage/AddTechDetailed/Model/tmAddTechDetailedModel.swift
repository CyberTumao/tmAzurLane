//
//  tmAddTechDetailedModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/2.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmAddTechDetailedModel {
    static let shareInstance = tmAddTechDetailedModel()
    private init() {}
    
    lazy var numberFirstArray:[String] = {
        ["C", "D", "E", "G", "H", "Q", "T"]
    }()
    lazy var numberSecondArray:[String] = {
        ["MI", "RF"]
    }()
    lazy var qualityArray = {
        ["蓝", "紫", "金"]
    }()
    lazy var scaleArray = {
        ["小型项目", "中型项目", "大型项目"]
    }()
    lazy var nameArray = {
        ["定向研发", "基础研究", "舰装解析", "魔方解析", "试验品募集", "研究委托", "资金募集"]
    }()
    /// $0 numberFirst $1 numberSecond $2 numberThid $3 scale $4 name $5 quality
    lazy var data = {
        [0, 0, 0, 0, 0, 0]
    }()
}
