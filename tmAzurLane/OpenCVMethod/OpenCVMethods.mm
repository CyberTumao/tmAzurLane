//
//  OpenCVMethods.m
//  tmAzurLane
//
//  Created by tumao on 2020/2/20.
//  Copyright © 2020 tumao. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/highgui/highgui.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import "OpenCVMethods.h"

#include "iostream"
using namespace std;
using namespace cv;

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
    cv::Mat result = image_source.clone();
    //CV_TM_CCOEFF_NORMED 值越大越匹配
    cv::matchTemplate(image_source, image_template, result, cv::TM_CCOEFF_NORMED);
    double minVal, maxVal;
    cv::Point minLoc, maxLoc;
    //寻找最佳匹配位置
    cv::minMaxLoc(result, &minVal, &maxVal, &minLoc, &maxLoc);
    cv::Mat image_color;
    cv::waitKey(0);
}

+ (BOOL)matchImgWith:(NSString *)path type:(NSString *)type tempPath:(NSString *)temp_path tempType:(NSString *)temp_type matchMode:(NSInteger)mode {
    NSString *tm_path = [NSBundle.mainBundle pathForResource:path ofType:type];
    NSString *tm_temp_path = [NSBundle.mainBundle pathForResource:temp_path ofType:temp_type];
    

    cv::Mat image = imread([tm_path UTF8String], cv::IMREAD_COLOR );
    cv::Mat templateImage = imread([tm_temp_path UTF8String], cv::IMREAD_COLOR);
    cv::Mat result = templateImage.clone();
    cv::matchTemplate(templateImage, image, result, cv::TM_CCOEFF_NORMED);
    
    double minVal, maxVal;
    cv::Point minLoc, maxLoc;
    cv::minMaxLoc( result, &minVal, &maxVal, &minLoc, &maxLoc );
    if (maxVal> 0.8) {
        return true;
    } else {
        return false;
    }
}

+ (BOOL)matchImgWith:(NSString *)path tempPath:(NSString *)temp_path matchMode:(NSInteger)mode {
    NSString *tm_path = path;
    NSString *tm_temp_path = temp_path;

    cv::Mat image = imread([tm_path UTF8String], cv::IMREAD_COLOR );
    cv::Mat templateImage = imread([tm_temp_path UTF8String], cv::IMREAD_COLOR);
    cv::Mat result = templateImage.clone();
    cv::matchTemplate(templateImage, image, result, cv::TM_CCOEFF_NORMED);
    
    double minVal, maxVal;
    cv::Point minLoc, maxLoc;
    cv::minMaxLoc( result, &minVal, &maxVal, &minLoc, &maxLoc );
//    NSLog(@"%@", temp_path);
//    cout<<maxVal<<endl;
    if (maxVal> 0.85) {
        return true;
    } else {
        return false;
    }
}

@end
