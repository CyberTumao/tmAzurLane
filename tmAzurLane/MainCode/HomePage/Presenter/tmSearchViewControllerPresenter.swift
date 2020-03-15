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
            let techInfoId = result.long(forColumn: "id")
            guard let name = result.string(forColumn: "name") else { break }
            guard let number = result.string(forColumn: "number") else { break }
            let quality = result.long(forColumn: "quality")
            let scale = result.long(forColumn: "scale")
            let addition = result.string(forColumn: "addition")
            model.appendTmTechInfo(toTech:techNumber, techInfoId:techInfoId, name: name, number: number, quality: quality, scale: scale, addition: addition)
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
    
    /// 获取tableviewcell的底色（不使用）
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
    
    /// 获取tableview的背景图片
    /// - Parameters:
    ///   - section: <#section description#>
    ///   - row: <#row description#>
    func getBackground(withSection section:Int, andRow row:Int) -> UIImage? {
        var quality = 0
        var image:UIImage?
        guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
            quality = 3
            return image
        }
        quality = techInfo.quality
        switch quality {
        case 0:
            image = UIImage(named: "techInfoBackground_0")
        case 1:
            image = UIImage(named: "techInfoBackground_1")
        case 2:
            image = UIImage(named: "techInfoBackground_2")
        default:
            break
        }
        return image
    }
    
    func getIcon(withSection section:Int, andRow row:Int, hasAddition:(UIImage?) -> Void, hasNotAddition:() -> Void) {
        let number = getNumber(withSection: section, andRow: row)
        if number.hasPrefix("D") {
            guard let techInfo = getTmTechInfo(withTechNumber: section, row: row) else {
                hasNotAddition()
                return
            }
            guard let addition = techInfo.addition else {
                hasNotAddition()
                return
            }
            if section == 0 { //Monarch Ibuki Izumo Roon Saint_Louis Seattle Georgia Kitakaze Azuma Friedrich_der_Große Gascogne
                if addition == nameOfTechShips.Neptune.value {
                    hasAddition(UIImage(named: "ship_1_1"))
                } else if addition == nameOfTechShips.Monarch.value {
                    hasAddition(UIImage(named: "ship_1_2"))
                } else if addition == nameOfTechShips.Ibuki.value {
                    hasAddition(UIImage(named: "ship_1_3"))
                } else if addition == nameOfTechShips.Izumo.value {
                    hasAddition(UIImage(named: "ship_1_4"))
                } else if addition == nameOfTechShips.Roon.value {
                    hasAddition(UIImage(named: "ship_1_5"))
                } else if addition == nameOfTechShips.Saint_Louis.value {
                    hasAddition(UIImage(named: "ship_1_6"))
                }
            } else {
                if addition == nameOfTechShips.Seattle.value {
                    hasAddition(UIImage(named: "ship_2_1"))
                } else if addition == nameOfTechShips.Georgia.value {
                    hasAddition(UIImage(named: "ship_2_2"))
                } else if addition == nameOfTechShips.Kitakaze.value {
                    hasAddition(UIImage(named: "ship_2_3"))
                } else if addition == nameOfTechShips.Azuma.value {
                    hasAddition(UIImage(named: "ship_2_4"))
                } else if addition == nameOfTechShips.Friedrich_der_Große.value {
                    hasAddition(UIImage(named: "ship_2_5"))
                } else if addition == nameOfTechShips.Gascogne.value {
                    hasAddition(UIImage(named: "ship_2_6"))
                }
            }
        } else {
            hasNotAddition()
        }
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
    
    func getTechInfoId(withSection number:Int, row:Int) -> Int {
        var techInfo:tmTechInfo?
        switch number {
        case 0:
            techInfo = model.techDetailedInfosFirst[row]
        case 1:
            techInfo = model.techDetailedInfosSecond[row]
        default:
            break
        }
        if techInfo == nil {
            return 0
        }
        return techInfo!.techInfoId
    }
}
