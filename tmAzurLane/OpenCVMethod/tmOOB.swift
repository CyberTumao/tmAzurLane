//
//  tmOOB.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/20.
//  Copyright © 2020 tumao. All rights reserved.
//

import Foundation
//import OOB
//
//
//class tmOOB {
//
//    static func imageMatch() -> Void {
//        // 传入背景预览图层，视频图像若100%不缩放展示(sizeToFit)，则不需要传入
////        let img = UIImageView.init(image: UIImage.init(named: "temp"))
//        let path:String = Bundle.main.path(forResource: "2", ofType: "png")!
//        let exp:UIImage = UIImage(contentsOfFile: path)!
//        let path_temp:String = Bundle.main.path(forResource: "IMG_0008", ofType: "png")!
//        let temp:UIImage = UIImage(contentsOfFile: path_temp)!
//        let img = UIImageView.init(image: temp)
//        OOBTemplate.bgPreview = img
////        OOBTemplate.preview = self.bgView;
//        // 值设置的越小误报率高，值设置的越大计算量越大
//        OOBTemplate.similarValue = 1;
//        /**
//         * 开始识别图像中的目标
//         * target 目标在背景图片中的位置，注意不是 UImageView 中的实际位置，需要缩放转换
//         * similar 要求的相似度，最大值为1，要求越大，精度越高，计算量越大
//         */
//        OOBTemplate.match(exp, bgImg: temp, similar: 1) { (rect, similar) in
//            _ = String.init(format: "相似度:%.0f%%", similar*100)
//        }
//    }
//}
