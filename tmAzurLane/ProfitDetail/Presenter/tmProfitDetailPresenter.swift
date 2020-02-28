//
//  tmProfitDetailPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitDetailPresenter {
    let model:tmProfitDetailModel
    
    init() {
        model = tmProfitDetailModel()
    }
    
    func getData(_ withHistoryId:Int) {
        guard let result = tmDataBaseManager.shareInstance.selectFromHistory(withHistoryId: withHistoryId) else {return}
        while result.next() {
            let profitMeterialId = result.long(forColumn: "profitMeterialId")
            let profitNumber = result.long(forColumn: "profitNumber")
            model.appendData(profitMeterialId,profitNumber)
        }
        
    }
    
    func getIcon(withRow row:Int) -> String {
        
        return ""
    }
}
