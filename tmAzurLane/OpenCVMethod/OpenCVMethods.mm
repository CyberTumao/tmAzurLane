//
//  OpenCVMethods.m
//  tmAzurLane
//
//  Created by tumao on 2020/2/20.
//  Copyright © 2020 tumao. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCVMethods.h"

#include "iostream"
using namespace std;

@implementation OpenCVMethods

+ (void)test {
    cout<<"hello"<<endl;
}

+ (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
  CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
  CGFloat cols = image.size.width;
  CGFloat rows = image.size.height;
  cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
  CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                 cols,                       // Width of bitmap
                                                 rows,                       // Height of bitmap
                                                 8,                          // Bits per component
                                                 cvMat.step[0],              // Bytes per row
                                                 colorSpace,                 // Colorspace
                                                 kCGImageAlphaNoneSkipLast |
                                                 kCGBitmapByteOrderDefault); // Bitmap info flags
  CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
  CGContextRelease(contextRef);
  return cvMat;
}

+ (void)matchImag {
    UIImage *temp = [UIImage imageNamed:@"temp"];
    UIImage *exp = [UIImage imageNamed:@"exp"];
    
    cv::Mat image_source = [OpenCVMethods cvMatFromUIImage:temp];
    cv::Mat image_template = [OpenCVMethods cvMatFromUIImage:exp];
    
//    cv::Mat originalImg = Imgcodecs.imread(originalImgPath, 0);
//        Mat templateImg = Imgcodecs.imread(templateImgPath, 0);
 
    cv::Mat result = image_source.clone();

        //CV_TM_CCOEFF_NORMED 值越大越匹配    
    cv::matchTemplate(image_source, image_template, result, cv::TM_CCOEFF_NORMED);
 double minVal, maxVal;
     cv::Point minLoc, maxLoc;
     //寻找最佳匹配位置
     cv::minMaxLoc(result, &minVal, &maxVal, &minLoc, &maxLoc);

     cv::Mat image_color;
//    cv::cvtColor(image_source, image_color, COLOR_GRAY2BGR);
//     cv::circle(image_color,
//                cv::Point(maxLoc.x + image_template.cols/2, maxLoc.y + image_template.rows/2),
//                20,
//                cv::Scalar(0, 0, 255),
//                2,
//                8,
//                0);
  
//     cv::imshow("source image", image_source);
//     cv::imshow("match result", result);
//     cv::imshow("target", image_color);
     cv::waitKey(0);
    
    
    
    
    
    
        //获得最匹配矩阵
//    cv::minMaxLoc(<#const SparseMat &a#>, <#double *minVal#>, <#double *maxVal#>)
//    cv::MinMaxLocResult mmlr = cv::minMaxLoc(result);
//        //最大为1
////        System.out.println(mmlr.maxVal);
//
//
//        //归一化匹配结果
//    cv::normalize(result, result, 0, 1, Core.NORM_MINMAX, -1, new Mat());
//
//        //获取矩阵左上角坐标
//        Point matchLocation = mmlr.maxLoc;
//        System.out.println(matchLocation.toString());
//
//        //画出匹配到的边界矩形
//        //矩形的右下角坐标 x+该矩阵的列，y+矩阵的行
//        Imgproc.rectangle(originalImg, matchLocation,
//                new Point(matchLocation.x + templateImg.cols(), matchLocation.y + templateImg.rows()),
//                new Scalar(0, 0, 0, 0), 2);
//
//        Imgcodecs.imwrite("/Users/wuxi/Pictures/originalImg.jpg", originalImg);
//
//        if (mmlr.maxVal >= 0.9) {
//            System.out.println("匹配成功");
//        } else {
//            System.out.println("匹配失败");
//        }
}

@end
