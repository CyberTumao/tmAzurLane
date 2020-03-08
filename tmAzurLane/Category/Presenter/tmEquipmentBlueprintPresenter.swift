//
//  tmEquipmentBlueprintPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/23.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmEquipmentBlueprintPresenter: NSObject {
    var model:tmEquipmentBlueprintModel
    var tmProtocol:tmEquipmentBlueprintDelegate
    
    init(_ tmProtocol:tmEquipmentBlueprintDelegate) {
        model = tmEquipmentBlueprintModel()
        self.tmProtocol = tmProtocol
    }
    
}

// MARK: - database methods
extension tmEquipmentBlueprintPresenter {
    func getFMResultSetFromProfitMaterial(withTechNumber techNumber:Int) {
        guard let result = tmDataBaseManager.shareInstance.selectFromProfitMaterial(withTechNumber: techNumber) else { return }
        while result.next() {
            guard let name = result.string(forColumn: "name") else { break }
            guard let picture = result.string(forColumn: "picture") else { break }
            model.names.append(name)
            model.pictures.append(picture)
            model.ProfitIds.append(result.long(forColumn: "id"))
        }
    }
    
    func getNumberOfProfitMaterial(withTechNumber techNumber:Int) -> Int? {
        return tmDataBaseManager.shareInstance.countForProfitMaterial(withTechNumber: techNumber)
    }
    
    func getProfitId(withRow row:Int) -> Int {
        if row<0||row>=model.ProfitIds.count {
            return 0
        }
        return model.ProfitIds[row]
    }
    
    func getName(withRow row:Int) -> String {
        if row<0||row>=model.names.count {
            return ""
        }
        return model.names[row]
    }
    
    func getPicture(withRow row:Int) -> String {
        if row<0||row>=model.pictures.count {
            return ""
        }
        return model.pictures[row]
    }
    
    /// profitId, pictureName, name)
    /// - Parameter row: 被选中的元素
    func getBlockData(_ row:Int) -> blockData {
        let pictureName = getPicture(withRow: row)
        let name = getName(withRow: row)
        let profitId = getProfitId(withRow: row)
        return (profitId, pictureName, name)
    }
    
}
