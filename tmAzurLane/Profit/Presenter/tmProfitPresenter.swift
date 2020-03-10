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
        guard let modelCount = model.count else {
            guard let count = tmDataBaseManager.shareInstance.countForHistoryAdd(withTechInfoId: number) else {
                return 0
            }
            model.count = count
            return count
        }
        return modelCount
    }
    
    func getData(_ techInfoId:Int) -> Void {
        guard let result = tmDataBaseManager.shareInstance.selectFromHistoryAdd(withTechInfoId: techInfoId) else {return}
        while result.next() {
            guard let date = result.string(forColumn: "date") else {continue}
            model.appendData(result.long(forColumn: "historyId"), date)
        }
    }
    
    func reloadData(_ techinfoId:Int) -> Void {
        model.count = nil
        model.profitArray.removeAll()
        getData(techinfoId)
    }
    
    func getDate(atRow:Int) -> String {
        let profit = model.profitArray[atRow] as! Profit
        return profit.date
    }
    
    func getHistoryId(atRow:Int) -> Int {
        let profit = model.profitArray[atRow] as! Profit
        return profit.historyId
    }
    
    func addProfit(withTechInfoId:Int, date:String) {
        tmDataBaseManager.shareInstance.insertIntoHistoryAdd(withTechInfoId: withTechInfoId, historyId: tmDataBaseManager.shareInstance.getMaxHistoryId(), date: date)
    }
}
