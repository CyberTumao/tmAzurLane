//
//  tmCurring.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/18.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmCurrying: NSObject {
    func printMethod() -> Void {
        let temp = addCurrying(1)
        print(temp(2))
    }
    
    func addCurrying(_ a:Int) -> (Int) -> Int {
        { b in
            a+b
        }
    }

    func test() -> Void {
        
        let addTwo = addCurrying(2)
        let addEight = addCurrying(8)
        let _ = addTwo(4)
        let _ = addEight(4)
        
        var car = "Benz"
        let closure = { [car] in
          print("I drive \(car)")
        }
        car = "Tesla"
        closure()
//        var car = "Benz"
//        let closure = {
//          print("I drive \(car)")
//        }
//        car = "Tesla"
//        closure()
    }
    
}
