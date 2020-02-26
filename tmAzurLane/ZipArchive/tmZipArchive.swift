//
//  tmZipArchive.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/25.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmZipArchive {
    
    
//    SSZipArchive.unzipFileAtPath(zipPath, toDestination: tempDestPath())
    func tmArchvieAndSave() {
        guard let zipPath  = Bundle.main.path(forResource: "Pictures", ofType: "zip") else {
            return
        }
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDir = paths[0]
        
        try! SSZipArchive.unzipFile(atPath: zipPath, toDestination: docDir, overwrite: false, password: nil)
    }
}
