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
    lazy var editModel:tmProfitDetailModel = {tmProfitDetailModel()}()
    var tmProtocol:tmProfitDetailedDelegate
    
    /// 是否显示进度条
    lazy var tmProgressFlag = {false}()
    /// 是否处于编辑状态
    lazy var editingStatus = {false}()
    lazy var pictures:[String] = {[]}()
    
    init(_ tmProtocol:tmProfitDetailedDelegate) {
        model = tmProfitDetailModel()
        self.tmProtocol = tmProtocol
    }
}

// MARK: - Model & getData
extension tmProfitDetailPresenter{
    
    /// 根据history id获取数据，并保存到model中
    /// - Parameter withHistoryId: history id
    func getData(_ withHistoryId:Int?) {
        var historyId = withHistoryId
        if withHistoryId == nil {
            historyId = 0
            return
        }
        guard let result = tmDataBaseManager.shareInstance.selectFromHistory(withHistoryId: historyId!) else {return}
        model.removeAllData()
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
        let count = modelSelect().profitDetails.count
        return editingStatus ? count+1 : count
//        return tmDataBaseManager.shareInstance.countForHistory(ofHistoryId: withHistoryId!)
    }
    
    func getIcon(withRow row:Int) -> UIImage? {
        let picture = getPicture(row)
        guard let docDir = kBundleDocumentPath() else {
            return nil
        }
        return UIImage(contentsOfFile: docDir+"/ShowPictures/"+picture+".png")
    }
    
    func isBluePrint(withRow row:Int) -> Bool {
        return getPicture(row).contains("blueprint")
        
    }
    
    private func getPicture(_ row:Int) -> String {
        guard let picture = modelSelect().profitDetails[row].picture else {
            return ""
        }
        return picture
    }
    
    func getName(withRow row:Int) -> String {
        guard let name = modelSelect().profitDetails[row].name else {
            return ""
        }
        return name
    }
    
    func getNumber(withRow row:Int) -> Int {
        modelSelect().profitDetails[row].profitNumber
    }
    
    func modelSelect() -> tmProfitDetailModel {
        if editingStatus {
            return editModel
        } else {
            return model
        }
    }
}

// MARK: - EditModel
extension tmProfitDetailPresenter {
    
    func startEdit() {
        editingStatus = true
        editModel = model.copy() as! tmProfitDetailModel
    }
    
    func addData(id: Int, name: String?, picture: String?) {
        for item in editModel.profitDetails {
            if item.profitMeterialId == id {
                return
            }
        }
        self.editModel.appendData(id, 1, name, picture)
    }
    
    func changeNumber(_ count:Int, _ row:Int) {
        let tempProfit = self.editModel.profitDetails[row]
        tempProfit.profitNumber = count
        self.editModel.profitDetails[row] = tempProfit
    }
    
    func removeData(_ row: Int) {
        
    }
    
    func saveData(_ historyId: Int?, _ profitNumbers: [Int]) {
        guard let historyId = historyId else { return }
        for profit in editModel.profitDetails.enumerated() {
            if profitNumbers[profit.offset] == 0 {
                tmDataBaseManager.shareInstance.removeData(inHistoryWith: historyId, profitMeterialId: profit.element.profitMeterialId)
            } else {
                tmDataBaseManager.shareInstance.insertData(inHistoryWith: historyId, profitMeterialId: profit.element.profitMeterialId, profitNumber: profitNumbers[profit.offset]) { (result) in
                    
                }
            }
        }
        editModel.removeAllData()
    }
    
}

// MARK: - OpenCV
extension tmProfitDetailPresenter {
    
    func progress(_ count:Int) {
        let maxCount:Float = 10.0
        var timeCount:Float = maxCount
        var temp = 1
        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .milliseconds(50))
        timer.setEventHandler {
            if self.tmProgressFlag {
                timeCount = 0
                self.tmProgressFlag = false
            }
            if timeCount == 1 {
                
            } else if timeCount <= 0 && temp < count {
                temp += 1
                DispatchQueue.main.sync {
                    self.tmProtocol.setProgress(1)
                    self.tmProtocol.setProgressText("\(temp)/\(count)")
                    timeCount = maxCount
                }
            } else {
                DispatchQueue.main.sync {
                    self.tmProtocol.setProgress((maxCount-timeCount)/maxCount)
                }
                timeCount -= 1
            }
            if temp >= count {
                DispatchQueue.main.sync {
                    self.tmProtocol.setProgress(1)
                    sleep(1)
                    self.tmProtocol.hideProgress()
                }
                timer.cancel()
            }
        }
        timer.resume()
    }
    
    func add(_ imagePath:String) {
        let manager = FileManager.default
        guard var paths = manager.subpaths(atPath: kBundleDocumentPath()!+"/Pictures") else {
            return
        }
        for (index, element) in paths.enumerated() {
            if !element.hasSuffix(".png") {
                paths.remove(at: index)
            }
        }
//        var paths:[String] = []
//        let pictures = tmDataBaseManager.shareInstance.selectFromProfitMeterialToUseOpenCV()
//        for item in pictures {
//            paths.append(kBundleDocumentPath()!+"/Pictures/"+item+".png")
//        }
        
        tmProtocol.showProgress()
        tmProtocol.setProgressText("1/\(paths.count)")
        progress(paths.count)
        
        DispatchQueue.global().async() { () in
            for element in paths {
                let tempPath = kBundleDocumentPath()!+"/Pictures/"+element
                let match = OpenCVMethods.matchImg(with: imagePath, tempPath: tempPath, matchMode: 0)
                self.tmProgressFlag = true
                if match {
                    self.pictures.append(element)
                }
            }
            for element in self.pictures {
                guard let result = tmDataBaseManager.shareInstance.getInfo(ofProfitMeterial: element) else {break}
                self.editModel.appendData(result.0, 1, result.1, element)
            }
        }
        
    }
    
}
