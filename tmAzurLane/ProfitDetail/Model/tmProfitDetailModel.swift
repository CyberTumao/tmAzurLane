
//
//  tmProfitDetailModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmProfitDetailModel: NSObject,NSCopying {
    //必须使用required关键字修饰
    required override init() {

    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let theCopyObj = type(of: self).init()
        theCopyObj.profitDetails = self.profitDetails
        return theCopyObj
    }
    
    
    lazy var profitDetails: [ProfitDetail] = {
        return []
    }()
    
    /// 添加数据到profiDetails
    /// - Parameters:
    ///   - id: ProfitMeterialId
    ///   - count: 数量（最少为1）
    func appendData(_ id:Int, _ count:Int) {
        let data = ProfitDetail(id, count)
        profitDetails.append(data)
    }
    
    /// 添加数据到profiDetails
    /// - Parameters:
    ///   - id: ProfitMeterialId
    ///   - count: 数量（最少为1）
    ///   - name: 名称
    ///   - picture: 图片
    func appendData(_ id:Int, _ count:Int,  _ name:String?, _ picture:String?) {
        let data = ProfitDetail(id, count, name, picture)
        profitDetails.append(data)
    }
    
}

class ProfitDetail {
    var profitMeterialId:Int
    var profitNumber:Int
    var name:String?
    var picture:String?
    
    init(_ id:Int, _ count:Int) {
        self.profitNumber = count
        self.profitMeterialId = id
    }
    
    init(_ id:Int, _ count:Int, _ name:String?, _ picture:String?) {
        self.profitNumber = count
        self.profitMeterialId = id
        self.name = name
        self.picture = picture
    }
    
}
