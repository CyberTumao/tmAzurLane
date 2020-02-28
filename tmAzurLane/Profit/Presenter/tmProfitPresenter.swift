//
//  tmProfitPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitPresenter {
    var model:tmProfitModel
    
    init() {
        model = tmProfitModel()
    }
    
    func getCellNumber(_ number:Int) -> Int {
        guard let count = tmDataBaseManager.shareInstance.countForHistoryAdd(withTechInfoId: number) else {
            return 0
        }
        return count
    }
    
    func getData(_ techInfoId:Int) -> Void {
        guard let result = tmDataBaseManager.shareInstance.selectFromHistoryAdd(withTechInfoId: techInfoId) else {return}
        while result.next() {
            guard let date = result.string(forColumn: "date") else {break}
            model.appendData(result.long(forColumn: "historyId"), date)
        }
    }
    
    func getDate(atRow:Int) -> String {
        let profit = model.profitArray[atRow] as! Profit
        return profit.date
    }
    
    func getHistoryId(atRow:Int) -> Int {
        let profit = model.profitArray[atRow] as! Profit
        return profit.historyId
    }
}
