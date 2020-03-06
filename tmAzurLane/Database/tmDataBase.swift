//
//  tmDataBase.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/19.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

let databaseName = "tmAL"

class tmDataBaseManager: NSObject {
    
    static let shareInstance: tmDataBaseManager = tmDataBaseManager()
    
    lazy var db : FMDatabase = {
        let path = kBundleDocumentPath()!+"/Database/"+databaseName+".db"
        let db = FMDatabase(path: path)
        return db
    }()
    
    override init() {
        super.init()
        openDB()
    }
    
    func openDB() {
        guard db.open() else {
            NSLog("\(#file) open database fail")
            return
        }
        
        NSLog("\(#file) open database successfully")
        
    }
    
    func selectFromTech(withNumber number:Int) -> String? {
        let sql = "SELECT * FROM Tech WHERE number=?"
        guard let result = db.executeQuery(sql, withArgumentsIn: [number]) else { return nil }
        while result.next() {
            let name = result.string(forColumn: "name")
            return name
        }
        return nil
    }
    
    // MARK: -TechDetailedInfo
    func selectFromTechDetailedInfo(withNumber number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM TechDetailedInfo WHERE tech_number=? ORDER by quality,scale,number"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func insertIntoTechDetailedInfo(withTechNumber:Int, name:String, number:String, quality:Int, scale:Int, addition:String?) {
        guard let addition = addition else {
            let sql = "INSERT INTO TechDetailedInfo(tech_number,name,number,quality,scale) VALUES (?,?,?,?,?)"
            db.executeUpdate(sql, withArgumentsIn: [withTechNumber, name, number, quality, scale])
            return
        }
        let sql = "INSERT INTO TechDetailedInfo(tech_number,name,number,quality,scale,addition) VALUES (?,?,?,?,?,?)"
        db.executeUpdate(sql, withArgumentsIn: [withTechNumber, name, number, quality, scale,addition])
    }
    
    // MARK: - ProfitMaterial
    func selectFromProfitMaterial(withTechNumber number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM ProfitMaterial WHERE category = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func selectFromProfitMaterial(withId number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM ProfitMaterial WHERE id = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func countForProfitMaterial(withTechNumber number:Int) -> Int? {
        return getCount(table: "ProfitMaterial", condition: "category = \(number)")
    }
    
    /// 获取ProfitMeterial信息 $0 图片id $1 图片介绍
    /// - Parameter withPictureName: 图片名称
    func getInfo(ofProfitMeterial withPictureName:String) -> (Int, String)? {
        let picture = withPictureName.prefix(withPictureName.count-4)
        let sql = "SELECT * FROM ProfitMaterial WHERE picture = ?"
        guard let result = db.executeQuery(sql, withArgumentsIn: [picture]) else {return nil}
        while result.next() {
            let number = result.long(forColumn: "id")
            let name = result.string(forColumn: "name")
            return (number, name == nil ? "" : name!)
        }
        return nil
    }
    
    // MARK: - historyAdd
    func countForHistoryAdd(withTechInfoId number:Int) -> Int? {
        return getCount(table: "historyAdd", condition: "techInfoId = \(number)")
    }
    
    func selectFromHistoryAdd(withTechInfoId number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM historyAdd WHERE techInfoId = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func insertIntoHistoryAdd(withTechInfoId:Int, historyId:Int, date:String) {
        let sql = "INSERT INTO historyAdd(techInfoId,historyId,date) VALUES (?,?,?)"
        db.executeUpdate(sql, withArgumentsIn: [withTechInfoId, historyId, date])
    }
    
    func getMaxHistoryId() -> Int {
        guard let result = db.executeQuery("SELECT * FROM historyAdd ORDER BY historyId DESC", withArgumentsIn: []) else {
            return 1
        }
        while result.next() {
            let historyId = result.long(forColumn: "historyId")
            return historyId+1
        }
        return 1
    }
    
    // MARK: - history
    func countForHistory(ofHistoryId number:Int) -> Int? {
        return getCount(table: "history", condition: "number = \(number)")
    }
    
    func selectFromHistory(withHistoryId number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM history WHERE number = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func getCount(table:String, condition:String) -> Int? {
        let sql = "SELECT count(*) FROM \(table) WHERE \(condition)"
        guard let result = db.executeQuery(sql, withArgumentsIn: []) else { return nil }
        while result.next() {
            let name = result.long(forColumn: "count(*)")
            return name
        }
        return nil
    }
    
    /// 从history中删除数据，不需要检测是否存在
    /// - Parameters:
    ///   - number: historyId
    ///   - profitMeterialId: <#profitMeterialId description#>
    func removeData(inHistoryWith number:Int, profitMeterialId:Int) {
        let sql = "DELETE FROM history WHERE number = ? and profitMeterialId = ?"
        db.executeUpdate(sql, withArgumentsIn: [number, profitMeterialId])
    }
    
    /// 向history中插入数据，如果存在则更新
    /// - Parameters:
    ///   - number: historyId
    ///   - profitMeterialId: <#profitMeterialId description#>
    ///   - profitNumber: 数量
    ///   - result: 插入结果，true成功，false失败
    func insertData(inHistoryWith number:Int, profitMeterialId:Int, profitNumber:Int, result:(Bool)->Void) {
        var sql = "SELECT * FROM history WHERE number = ? and profitMeterialId = ?"
        guard let sqlResult = db.executeQuery(sql, withArgumentsIn: [number, profitMeterialId]) else {
            result(false)
            return
        }
        if sqlResult.next() {
            sql = "UPDATE history SET profitNumber = ? WHERE number = ? and profitMeterialId = ?"
            if db.executeUpdate(sql, withArgumentsIn: [profitNumber, number, profitMeterialId]) {
                result(true)
            } else {
                result(false)
            }
        } else {
            sql = "INSERT INTO history(number, profitMeterialId, profitNumber) VALUES (?,?,?)"
            if db.executeUpdate(sql, withArgumentsIn: [number, profitMeterialId, profitNumber]) {
                result(true)
            } else {
                result(false)
            }
        }
    }
}


/**
 CREATE TABLE if not EXISTS  Tech (id INTEGER PRIMARY key AUTOINCREMENT,number INTEGER,name TEXT);
 INSERT INTO Tech(number, name) VALUES (1, "一期科研");
 INSERT INTO Tech(number, name) VALUES (2, "二期科研");
 */
