//
//  DXDDefultInfoHelper.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/7.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "DXDDefultInfoHelper.h"

@implementation DXDDefultInfoHelper

+(DXDDefultInfoHelper*)sharedInstance {
    
    static DXDDefultInfoHelper *defultInfoHelper;
    static dispatch_once_t defultInfoHelperonce;
    dispatch_once(&defultInfoHelperonce, ^{
        defultInfoHelper = [[DXDDefultInfoHelper alloc] init];
    });
    return defultInfoHelper;
}

- (void)setIsLogin:(BOOL)isLogin {
    [self writeSyncKey:@"isLogin" withValue:@(isLogin)];
}

- (BOOL)isLogin {
    NSNumber *isLogin =[self readKey:@"isLogin"];
    return isLogin.boolValue;
}

- (void)setUrlHeader:(NSString *)urlHeader {
    [self writeSyncKey:@"urlHeader" withValue:urlHeader];
}

- (NSString *)urlHeader {
    NSString *urlHeader = [self readKey:@"urlHeader"];
    return urlHeader;
}

- (void)writeSyncKey:(NSString *)key withValue:(id)value {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)readKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
