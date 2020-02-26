//
//  tmSearchViewControllerPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/26.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation
import UIKit

class tmSearchViewControllerPresenter {
    var model:tmSearchModel
    var tmProtocol:tmSearchDelegate
    
    init(_ tmProtocol:tmSearchDelegate) {
        model = tmSearchModel()
        self.tmProtocol = tmProtocol
    }
    
    func getProfitMaterialData() {
        getProfitMaterialData(withNumber: 1)
        getProfitMaterialData(withNumber: 2)
    }
    
    /// 根据techNumber从数据库获取数据
    /// - Parameter techNumber: techNumber
    func getProfitMaterialData(withNumber techNumber:Int) {
        guard let result = tmDataBaseManager.shareInstance.selectFromTechDetailedInfo(withNumber: techNumber) else { return }
        
        while result.next() {
            guard let name = result.string(forColumn: "name") else { break }
            guard let number = result.string(forColumn: "number") else { break }
            let quality = result.long(forColumn: "quality")
            let scale = result.long(forColumn: "scale")
            let addition = result.string(forColumn: "addition")
            model.appendTmTechInfo(toTech:techNumber, name: name, number: number, quality: quality, scale: scale, addition: addition)
        }
    }
    
    /// 科研种类
    /// - Parameter withTechNumber: withTechNumber description
    func getProfitMaterialListNumber(_ withTechNumber:Int) -> Int? {
        switch withTechNumber {
        case 1:
            return model.techDetailedInfosFirst.count
        case 2:
            return model.techDetailedInfosSecond.count
        default:
            return nil
        }
    }
    
    /// 获取tableviewcell的底色
    /// - Parameters:
    ///   - section: <#section description#>
    ///   - row: <#row description#>
    func getColor(withSection section:Int, andRow row:Int) -> UIColor {
        var quality = 0
        var color = UIColor.white
        guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
            quality = 3
            return color
        }
        quality = techInfo.quality
        switch quality {
        case 0:
            color = kRGBA(r: 81, g: 118, b: 191, a: 0.75)
        case 1:
            color = kRGBA(r: 135, g: 127, b: 183, a: 0.75)
        case 2:
            color = kRGBA(r: 210, g: 171, b: 128, a: 1)
        default:
            break
        }
        return color
    }
    
    func getNumber(withSection section:Int, andRow row:Int) -> String {
        guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
            return ""
        }
        return techInfo.number
    }
    
    func getName(withSection section:Int, andRow row:Int) -> String {
        guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
            return ""
        }
        return techInfo.name
    }
    
    func getScale(withSection section:Int, andRow row:Int) -> String {
        guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
            return ""
        }
        let scale = techInfo.scale
        switch scale {
        case 0:
            return "小型项目"
        case 1:
            return "中型项目"
        case 2:
            return "大型项目"
        default:
            return ""
        }
    }
    
    func getTmTechInfo(withTechNumber number:Int, row:Int) -> tmTechInfo? {
        var techInfo:tmTechInfo?
        
        switch number {
        case 0:
            techInfo = model.techDetailedInfosFirst[row]
        case 1:
            techInfo = model.techDetailedInfosSecond[row]
        default:
            break
        }
        return techInfo
    }
}
