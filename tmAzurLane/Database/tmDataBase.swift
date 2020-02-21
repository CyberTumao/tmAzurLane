//
//  tmDataBase.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/19.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

let databaseName = "AzurLaneTech"

class tmDataBaseManager: NSObject {
    
    static let shareInstance: tmDataBaseManager = tmDataBaseManager()
    
    lazy var db : FMDatabase = {
        let path = Bundle.main.path(forResource: "tmAL", ofType: "db")
        let db = FMDatabase(path: path)
        return db
    }()
    
    override init() {
        super.init()
        openDB(name: databaseName)
    }
    
    func openDB(name: String) {
        guard db.open() else {
            NSLog("\(#file) open database fail")
            return
        }
        
//        guard createTable() else {
//            NSLog("\(#file) create table fail")
//            return
//        }
        
        NSLog("\(#file) create table successfully")
        
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
}


/**
 
 
 
 CREATE TABLE if not EXISTS  Tech (id INTEGER PRIMARY key AUTOINCREMENT,number INTEGER,name TEXT);
 INSERT INTO Tech(number, name) VALUES (1, "一期科研");
 INSERT INTO Tech(number, name) VALUES (2, "二期科研");
 */
