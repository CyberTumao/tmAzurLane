//
//  tmProfitDetailPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation
import UIKit

class tmProfitDetailPresenter {
    let model:tmProfitDetailModel
    
    init() {
        model = tmProfitDetailModel()
    }
    
    func getData(_ withHistoryId:Int?) {
        var historyId = withHistoryId
        if withHistoryId == nil {
            historyId = 0
        }
        guard let result = tmDataBaseManager.shareInstance.selectFromHistory(withHistoryId: historyId!) else {return}
        while result.next() {
            let profitMeterialId = result.long(forColumn: "profitMeterialId")
            let profitNumber = result.long(forColumn: "profitNumber")
            let profitMeterialData = getProfitMeterialData(withId: profitMeterialId)
            model.appendData(profitMeterialId, profitNumber, profitMeterialData.0, profitMeterialData.1)
        }
    }
    
    func getProfitMeterialData(withId id:Int) -> (String?, String?) {
        guard let result = tmDataBaseManager.shareInstance.selectFromProfitMaterial(withId: id) else {return (nil, nil)}
        var name:String?
        var picture:String?
        while result.next() {
            name = result.string(forColumn: "name")
            picture = result.string(forColumn: "picture")
        }
        return (name, picture)
    }
    
    func getCount(_ withHistoryId:Int?) ->Int? {
        if withHistoryId == nil {
            return nil
        }
        return tmDataBaseManager.shareInstance.countForHistory(ofHistoryId: withHistoryId!)
    }
    
    func getIcon(withRow row:Int) -> UIImage? {
        guard let picture = model.profitDetails[row].picture else {
            return nil
        }
        guard let docDir = kBundleDocumentPath() else {
            return nil
        }
        return UIImage(contentsOfFile: docDir+"/Pictures/"+picture+".png")
    }
    
    func getName(withRow row:Int) -> String {
        guard let name = model.profitDetails[row].name else {
            return ""
        }
        return name
    }
    
    func getNumber(withRow row:Int) -> Int {
        return model.profitDetails[row].profitNumber
    }
}
