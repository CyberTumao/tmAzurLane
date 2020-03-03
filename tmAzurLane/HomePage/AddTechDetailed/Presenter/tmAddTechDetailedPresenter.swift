//
//  tmAddTechDetailedPresenter.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/2.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

enum tmAddTech {
    case numberFirst
    case numberThird
    case quality
    case scale
    case name
}

class tmAddTechDetailedPresenter {
    var tmProtocol:tmAddTechDetailedDelegate
    lazy var value = {
        tmAddTech.name
    }()
    
    init(_ tmProtocol:tmAddTechDetailedDelegate) {
        self.tmProtocol = tmProtocol
    }
}

extension tmAddTechDetailedPresenter {
    func setAddTechValue(_ value:tmAddTech) {
        self.value = value
    }
    func changeData(_ data:Int, _ row:Int) {
        tmAddTechDetailedModel.shareInstance.data[row] = data
    }
    func getData(_ row:Int) -> Int {
        return tmAddTechDetailedModel.shareInstance.data[row]
    }
    func getPickerArray() -> [String] {
        switch value {
        case .name:
            return getPickerName()
        case .numberFirst:
            return getPickerNumberFirst()
        case .numberThird:
            return getPickerNumberThird()
        case .quality:
            return getPickerQuailty()
        case .scale:
            return getPickerScale()
        }
    }
    func getPickerArrayCount() -> Int {
        switch value {
        case .name:
            return getPickerName().count
        case .numberFirst:
            return getPickerNumberFirst().count
        case .numberThird:
            return getPickerNumberThird().count
        case .quality:
            return getPickerQuailty().count
        case .scale:
            return getPickerScale().count
        }
    }
    private func getPickerName() -> [String] {
        return tmAddTechDetailedModel.shareInstance.nameArray
    }
    private func getPickerNumberFirst() -> [String] {
        return tmAddTechDetailedModel.shareInstance.numberFirstArray
    }
    private func getPickerNumberThird() -> [String] {
        return tmAddTechDetailedModel.shareInstance.numberSecondArray
    }
    private func getPickerQuailty() -> [String] {
        return tmAddTechDetailedModel.shareInstance.qualityArray
    }
    private func getPickerScale() -> [String] {
        return tmAddTechDetailedModel.shareInstance.scaleArray
    }
    func saveData(withTechNumber:Int) {
        let number = String(tmAddTechDetailedModel.shareInstance.numberFirstArray[tmAddTechDetailedModel.shareInstance.data[0]])+"-"+String(tmAddTechDetailedModel.shareInstance.data[1])+"-"+String(tmAddTechDetailedModel.shareInstance.numberSecondArray[tmAddTechDetailedModel.shareInstance.data[2]])
        let name = tmAddTechDetailedModel.shareInstance.nameArray[tmAddTechDetailedModel.shareInstance.data[4]]
        /// $0 numberFirst $1 numberSecond $2 numberThid $3 scale $4 name $5 quality
        let quality = tmAddTechDetailedModel.shareInstance.data[5]
        let scale = tmAddTechDetailedModel.shareInstance.data[3]
//        let addition
        tmDataBaseManager.shareInstance.insertIntoTechDetailedInfo(withTechNumber: withTechNumber, name: name, number: number, quality: quality, scale: scale, addition: nil)
        
    }
}
