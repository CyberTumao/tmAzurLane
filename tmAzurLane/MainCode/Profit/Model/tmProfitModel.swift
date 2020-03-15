//
//  tmProfitModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitModel {
    lazy var profitArray = {
        return []
    }()
    var count:Int?
    
    func appendData(_ historyId:Int, _ date:String) {
        let profit = Profit(historyId, date)
        profitArray.append(profit)
    }
}

class Profit {
    var historyId:Int
    var date:String
    
    init(_ historyId:Int, _ date:String) {
        self.historyId = historyId
        self.date = date
    }
}
    
