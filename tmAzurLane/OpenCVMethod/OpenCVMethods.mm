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

+ (void)fff {
//    let path:String = Bundle.main.path(forResource: "2", ofType: "png")!
//    let exp:UIImage = UIImage(contentsOfFile: path)!
//    let path_temp:String = Bundle.main.path(forResource: "IMG_0008", ofType: "png")!
//    let temp:UIImage = UIImage(contentsOfFile: path_temp)!
    NSString *path = [NSBundle.mainBundle pathForResource:@"9" ofType:@"png"];
    UIImage *temp = [UIImage imageNamed:@"temp"];
    UIImage *exp = [UIImage imageNamed:@"exp"];
    
//    cv::Mat image_source = [OpenCVMethods cvMatFromUIImage:temp];
//    cv::Mat image_template = [OpenCVMethods cvMatFromUIImage:exp];
//    cv::Mat result = image_source.clone();
//    cv::matchTemplate(image_source, image_template, result, cv::TM_CCOEFF_NORMED);
    

    cv::Mat image = imread([path UTF8String], cv::IMREAD_COLOR );
    cv::Mat templateImage = imread([[NSBundle.mainBundle pathForResource:@"IMG_0014" ofType:@"png"] UTF8String], cv::IMREAD_COLOR);
    cv::Mat result = templateImage.clone();
    cv::matchTemplate(templateImage, image, result, cv::TM_CCOEFF_NORMED);
    
    double minVal, maxVal;
    cv::Point minLoc, maxLoc;
    cv::minMaxLoc( result, &minVal, &maxVal, &minLoc, &maxLoc );
}

@end
