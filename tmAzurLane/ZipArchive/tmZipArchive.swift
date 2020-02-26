//
//  tmZipArchive.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/25.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation

class tmZipArchive {
    
    func tmArchvieAndSave() {
        guard let zipPath  = Bundle.main.path(forResource: "Pictures", ofType: "zip") else {
            return
        }
        guard let docDir = kBundleDocumentPath() else {
            return
        }
        try! SSZipArchive.unzipFile(atPath: zipPath, toDestination: docDir, overwrite: false, password: nil)
    }
}
