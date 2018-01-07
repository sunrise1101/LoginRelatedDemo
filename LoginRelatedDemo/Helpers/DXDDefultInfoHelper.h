//
//  DXDDefultInfoHelper.h
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/7.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDDefultInfoHelper : NSObject

+ (DXDDefultInfoHelper *)sharedInstance;

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString* urlHeader;

@end
