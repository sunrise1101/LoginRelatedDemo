//
//  DXDAlertHelper.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/7.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "DXDAlertHelper.h"

@implementation DXDAlertHelper

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [DXDAlertHelper addCancelActionTarget:alert title:@"确定" action:^(UIAlertAction *action) {}];
    PBMAINDelay(PBANIMATE_DURATION, ^{
        UIWindow *window =[UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:true completion:nil];
    });
}

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withTarget:(id)target {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [DXDAlertHelper addCancelActionTarget:alert title:@"确定" action:^(UIAlertAction *action) {}];
    __weak typeof(&*target) weakTarget = target;
    if (weakTarget)
        [weakTarget presentViewController:alert animated:YES completion:nil];
}

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withBtnTitle:(NSString *)btnTitle withTarget:(id)target {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [DXDAlertHelper addCancelActionTarget:alert title:btnTitle action:^(UIAlertAction *action) {}];
    __weak typeof(&*target) weakTarget = target;
    if (weakTarget)
        [weakTarget presentViewController:alert animated:YES completion:nil];
}

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withOKbtnTitle:(NSString *)OKbtnTitle withCancelbtnTitle:(NSString *)cancelbtnTitle withTarget:(id)target withOkHandler:(SEL)handleOk {
    [DXDAlertHelper alertInfo:title withMessage:message withOKbtnTitle:OKbtnTitle withCancelbtnTitle:cancelbtnTitle withTarget:target withOkHandler:handleOk withCancleHandler:nil];
}

+ (void)alertInfo:(NSString *)title withMessage:(NSString *)message withOKbtnTitle:(NSString *)OKbtnTitle withCancelbtnTitle:(NSString *)cancelbtnTitle withTarget:(id)target withOkHandler:(SEL)handleOk withCancleHandler:(SEL)handleCancle {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(&*target) weakTarget = target;
    [DXDAlertHelper addActionTarget:alert title:cancelbtnTitle action:^(UIAlertAction *action) {
        if (weakTarget && handleCancle)
            ((void (*)(id, SEL))[weakTarget methodForSelector:handleCancle])(weakTarget, handleCancle);
    }];
    [DXDAlertHelper addCancelActionTarget:alert title:OKbtnTitle action:^(UIAlertAction *action) {
        if (weakTarget && handleOk) {
            void (*func)(id, SEL) = (void *)[weakTarget methodForSelector:handleOk];
            func(weakTarget, handleOk);
        }
    }];
    if (weakTarget)
        [weakTarget presentViewController:alert animated:YES completion:nil];
}

+ (void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title action:(void(^)(UIAlertAction *action))actionTarget {
    [DXDAlertHelper addCancelActionTarget:alertController title:title color:c_grapefruit action:actionTarget];
}

+ (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title action:(void(^)(UIAlertAction *action))actionTarget {
    [DXDAlertHelper addActionTarget:alertController title:title color:c_black action:actionTarget];
}

+ (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget {
    [DXDAlertHelper addActionTarget:alertController style:UIAlertActionStyleDefault title:title color:color action:actionTarget];
}

+ (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget {
    [DXDAlertHelper addActionTarget:alertController style:UIAlertActionStyleCancel title:title color:color action:actionTarget];
}

+ (void)addActionTarget:(UIAlertController *)alertController style:(UIAlertActionStyle)style title:(NSString *)title color:(NSString *)color action:(void(^)(UIAlertAction *action))actionTarget {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style?style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.4) {
        [action setValue:[UIColor pb_colorWithHexString:color?color:c_black] forKey:@"_titleTextColor"];
    }
    [alertController addAction:action];
}

@end
