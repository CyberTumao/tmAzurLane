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
    case addition
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
        tmAddTechDetailedModel.shareInstance.data[row]
    }
    func getPickerArray(_ techNumber:Int) -> [String] {
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
        case .addition:
            return getPickerAddition(techNumber)
        }
    }
    func getPickerArrayCount(_ techNumber:Int) -> Int {
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
        case .addition:
            return getPickerAddition(techNumber).count
        }
    }
    private func getPickerName() -> [String] {
        tmAddTechDetailedModel.shareInstance.nameArray
    }
    private func getPickerNumberFirst() -> [String] {
        tmAddTechDetailedModel.shareInstance.numberFirstArray
    }
    private func getPickerNumberThird() -> [String] {
        tmAddTechDetailedModel.shareInstance.numberSecondArray
    }
    private func getPickerQuailty() -> [String] {
        tmAddTechDetailedModel.shareInstance.qualityArray
    }
    private func getPickerScale() -> [String] {
        tmAddTechDetailedModel.shareInstance.scaleArray
    }
    private func getPickerAddition(_ techNumber:Int) -> [String] {
        techNumber == 1 ? tmAddTechDetailedModel.shareInstance.additionTech1st : tmAddTechDetailedModel.shareInstance.additionTech2nd
    }
    func saveData(withTechNumber:Int) {
        //判断 tmAddTechDetailedModel.shareInstance.data[1] 的位数
        var secondNumber:String = ""
        let num = tmAddTechDetailedModel.shareInstance.data[1]
        if num < 10 {
            secondNumber = "00"+String(tmAddTechDetailedModel.shareInstance.data[1])
        } else if num < 100 {
            secondNumber = "0"+String(tmAddTechDetailedModel.shareInstance.data[1])
        } else {
            secondNumber = String(tmAddTechDetailedModel.shareInstance.data[1])
        }
        
        let number = String(tmAddTechDetailedModel.shareInstance.numberFirstArray[tmAddTechDetailedModel.shareInstance.data[0]])+"-"+secondNumber+"-"+String(tmAddTechDetailedModel.shareInstance.numberSecondArray[tmAddTechDetailedModel.shareInstance.data[2]])
        let name = tmAddTechDetailedModel.shareInstance.nameArray[tmAddTechDetailedModel.shareInstance.data[4]]
        /// $0 numberFirst $1 numberSecond $2 numberThid $3 scale $4 name $5 quality
        let quality = tmAddTechDetailedModel.shareInstance.data[5]
        let scale = tmAddTechDetailedModel.shareInstance.data[3]
//        let addition
        var addition:String?
        if tmAddTechDetailedModel.shareInstance.numberFirstArray[tmAddTechDetailedModel.shareInstance.data[0]] == "D" {
            addition = withTechNumber == 1 ? tmAddTechDetailedModel.shareInstance.additionTech1st[tmAddTechDetailedModel.shareInstance.data[6]] : tmAddTechDetailedModel.shareInstance.additionTech2nd[tmAddTechDetailedModel.shareInstance.data[6]]
        }
        tmDataBaseManager.shareInstance.checkExist(withTechNumber: withTechNumber, name: name, number: number, quality: quality, scale: scale) {
            tmDataBaseManager.shareInstance.insertIntoTechDetailedInfo(withTechNumber: withTechNumber, name: name, number: number, quality: quality, scale: scale, addition: addition, success: {
                tmProtocol.saveDataSuccess()
            }, failure: {
                tmProtocol.saveDataFailure()
            })
        }
    }
}
