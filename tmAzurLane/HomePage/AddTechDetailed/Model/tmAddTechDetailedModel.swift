//
//  tmAddTechDetailedModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/2.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

/// Neptune Monarch Ibuki Izumo Roon Saint_Louis Seattle Georgia Kitakaze Azuma Friedrich_der_Große Gascogne
enum nameOfTechShips {
    case Neptune
    case Monarch
    case Ibuki
    case Izumo
    case Roon
    case Saint_Louis
    case Seattle
    case Georgia
    case Kitakaze
    case Azuma
    case Friedrich_der_Große
    case Gascogne
    
    var value:String {
        switch self {
        case .Seattle:
            return "西雅图"
        case .Georgia:
            return "佐治亚"
        case .Kitakaze:
            return "北风"
        case .Azuma:
            return "吾妻"
        case .Friedrich_der_Große:
            return "腓特烈大帝"
        case .Gascogne:
            return "加斯科涅"
        case .Neptune:
            return "海王星"
        case .Monarch:
            return "君主"
        case .Ibuki:
            return "伊吹"
        case .Izumo:
            return "出云"
        case .Roon:
            return "罗恩"
        case .Saint_Louis:
            return "路易九世"
        }
    }
}

class tmAddTechDetailedModel {
    static let shareInstance = tmAddTechDetailedModel()
    private init() {}
    
    lazy var numberFirstArray:[String] = {
        ["C", "D", "E", "G", "H", "Q", "T"]
    }()
    lazy var numberSecondArray:[String] = {
        ["MI", "RF", "UL"]
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
    lazy var additionTech1st = {
        [nameOfTechShips.Neptune.value, nameOfTechShips.Monarch.value, nameOfTechShips.Ibuki.value, nameOfTechShips.Izumo.value, nameOfTechShips.Roon.value, nameOfTechShips.Saint_Louis.value]
    }()
    lazy var additionTech2nd:[String] = {
        [nameOfTechShips.Seattle.value, nameOfTechShips.Georgia.value, nameOfTechShips.Kitakaze.value, nameOfTechShips.Azuma.value, nameOfTechShips.Friedrich_der_Große.value, nameOfTechShips.Gascogne.value]
    }()
    /// $0 numberFirst $1 numberSecond $2 numberThid $3 scale $4 name $5 quality $6 addition
    lazy var data = {
        [0, 0, 0, 0, 0, 0, 0]
    }()
}
