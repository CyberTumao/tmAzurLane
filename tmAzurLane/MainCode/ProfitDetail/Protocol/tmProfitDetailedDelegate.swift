//
//  tmProfitDetailedDelegate.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/4.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

protocol tmProfitDetailedDelegate:NSObjectProtocol {
    func setProgress(_ value:Float)
    func setProgressText(_ text:String)
    func showProgress()
    func hideProgress()
}
