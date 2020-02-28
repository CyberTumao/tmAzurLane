
//
//  tmProfitDetailModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitDetailModel {
    lazy var profitDetails: [ProfitDetail] = {
        return []
    }()
    func appendData(_ id:Int, _ count:Int) {
        let data = ProfitDetail(id, count)
        profitDetails.append(data)
    }
}

class ProfitDetail {
    var profitMeterialId:Int
    var profitNumber:Int
    
    init(_ id:Int, _ count:Int) {
        self.profitNumber = count
        self.profitMeterialId = id
    }
}
