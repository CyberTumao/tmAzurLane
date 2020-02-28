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
        let path = Bundle.main.path(forResource: databaseName, ofType: "db")
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
    
    func selectFromTechDetailedInfo(withNumber number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM TechDetailedInfo WHERE tech_number=? ORDER by quality,scale,number"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    // MARK: - ProfitMaterial
    func selectFromProfitMaterial(withTechNumber number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM ProfitMaterial WHERE category = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
    
    func countForProfitMaterial(withTechNumber number:Int) -> Int? {
        let sql = "SELECT count(*) FROM ProfitMaterial WHERE category = ?"
        guard let result = db.executeQuery(sql, withArgumentsIn: [number]) else { return nil }
        while result.next() {
            let name = result.long(forColumn: "count(*)")
            return name
        }
        return nil
    }
    
    // MARK: - historyAdd
    func countForHistoryAdd(withTechInfoId number:Int) -> Int? {
        let sql = "SELECT count(*) FROM historyAdd WHERE techInfoId = ?"
        guard let result = db.executeQuery(sql, withArgumentsIn: [number]) else { return nil }
        while result.next() {
            let name = result.long(forColumn: "count(*)")
            return name
        }
        return nil
    }
    
    func selectFromHistoryAdd(withTechInfoId number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM historyAdd WHERE techInfoId = ?"
        return db.executeQuery(sql, withArgumentsIn: [number])
    }
}


/**
 
 
 
 CREATE TABLE if not EXISTS  Tech (id INTEGER PRIMARY key AUTOINCREMENT,number INTEGER,name TEXT);
 INSERT INTO Tech(number, name) VALUES (1, "一期科研");
 INSERT INTO Tech(number, name) VALUES (2, "二期科研");
 */
