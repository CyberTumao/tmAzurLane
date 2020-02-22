//
//  OpenCVMethods.h
//  tmAzurLane
//
//  Created by tumao on 2020/2/20.
//  Copyright © 2020 tumao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVMethods : NSObject

+ (void)test;
+ (void)matchImag;
+ (BOOL)matchImgWith:(NSString*)path type:(NSString*)type tempPath:(NSString*)temp_path tempType:(NSString*)temp_type matchMode:(NSInteger)mode;

@end

NS_ASSUME_NONNULL_END
