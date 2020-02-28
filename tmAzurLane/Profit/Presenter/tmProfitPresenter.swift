//
//  tmProfitPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitPresenter {
    var model:tmSearchModel
//    var tmProtocol:tmSearchDelegate
    
    init() {
        model = tmSearchModel()
    }
    
    func getCellNumber(_ number:Int) -> Int {
        guard let count = tmDataBaseManager.shareInstance.countForHistoryAdd(withTechInfoId: number) else {
            return 0
        }
        return count
    }
}
