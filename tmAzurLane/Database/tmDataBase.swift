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
    
    func createTable() ->Bool {
        // 1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER \n" +
        ");"
        return db.executeUpdate(sql, withArgumentsIn: [])
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
    
    func selectFromProfitMaterial(withTechNumber number:Int) -> FMResultSet? {
        let sql = "SELECT * FROM ProfitMaterial WHERE category = ?"
        guard let result = db.executeQuery(sql, withArgumentsIn: [number]) else { return nil }
        return result
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
}


/**
 
 
 
 CREATE TABLE if not EXISTS  Tech (id INTEGER PRIMARY key AUTOINCREMENT,number INTEGER,name TEXT);
 INSERT INTO Tech(number, name) VALUES (1, "一期科研");
 INSERT INTO Tech(number, name) VALUES (2, "二期科研");
 */
