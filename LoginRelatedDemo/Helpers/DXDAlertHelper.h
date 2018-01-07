//
//  DXDAlertHelper.h
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/7.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DXDAlertHelper : NSObject

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message;

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withTarget:(id)target;

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withBtnTitle:(NSString *)btnTitle withTarget:(id)target;

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withOKbtnTitle:(NSString *)OKbtnTitle withCancelbtnTitle:(NSString *)cancelbtnTitle withTarget:(id)target withOkHandler:(SEL)handleOk;

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withOKbtnTitle:(NSString *)OKbtnTitle withCancelbtnTitle:(NSString *)cancelbtnTitle withTarget:(id)target withOkHandler:(SEL)handleOk withCancleHandler:(SEL)handleCancle;

//red button titleColor
+ (void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title action:(void(^)(UIAlertAction *action))actionTarget;
//black button titleColor
+ (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title action:(void(^)(UIAlertAction *action))actionTarget;
//custom button titleColor default black
+ (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget;
//custom cancel button titleColor default black
+ (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget;
//custom button color & style  default black & 0
+ (void)addActionTarget:(UIAlertController *)alertController style:(UIAlertActionStyle)style title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget;

@end
