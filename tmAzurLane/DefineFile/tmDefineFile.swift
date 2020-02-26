//
//  tmDefineFile.swift
//  tmAzurLane
//
//  常用宏
//
//  Created by tumao on 2020/2/26.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation
import UIKit

// 屏幕的物理宽度
let kScreenWidth = UIScreen.main.bounds.size.width
// 屏幕的物理高度
let kScreenHeight = UIScreen.main.bounds.size.height

// 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }

// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// App沙盒路径
func kAppPath() -> String! {
    return NSHomeDirectory()
}

// Documents路径
func kBundleDocumentPath() -> String? {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
}

// Caches路径
func KCachesPath() -> String? {
    NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
}
