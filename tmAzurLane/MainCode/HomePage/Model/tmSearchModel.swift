//
//  tmSearchModel.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/26.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmSearchModel:NSObject {
    /// 一期科研
    lazy var techDetailedInfosFirst = {
        return [tmTechInfo]()
    }()
    /// 二期科研
    lazy var techDetailedInfosSecond = {
        return [tmTechInfo]()
    }()
    
    func appendTmTechInfo(toTech:Int, techInfoId:Int, name:String, number:String, quality:Int, scale:Int, addition:
    String?) -> Void {
        let techInfo = tmTechInfo(techInfoId:techInfoId, name: name, number: number, quality: quality, scale: scale, addition: addition)
        switch toTech {
        case 1:
            techDetailedInfosFirst.append(techInfo)
        case 2:
            techDetailedInfosSecond.append(techInfo)
        default:
            break
        }
    }
}

class tmTechInfo:NSObject {
    var techInfoId:Int
    var name:String
    var number:String
    var quality:Int
    var scale:Int
    lazy var addition:String? = {
        return nil
    }()
    
    init(_ techInfoId:Int, _ name:String, _ number:String, _ quality:Int, _ scale:Int) {
        self.techInfoId = techInfoId
        self.name = name
        self.number = number
        self.quality = quality
        self.scale = scale
    }
    convenience init(techInfoId:Int, name:String, number:String, quality:Int, scale:Int, addition:String?) {
        self.init(techInfoId, name, number, quality, scale)
        self.addition = addition
    }
}
