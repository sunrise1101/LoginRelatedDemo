//
//  DXDReTextField.h
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXDReParser;

#define PB_PHONE_REGEXP     @"^(1[3-9][0-9](?: ))(\\d{4}(?: )){2}$"

@interface DXDReTextField : UITextField {
    NSString *_lastAcceptedValue;
    DXDReParser *_parser;
}

@property (nonatomic, strong) NSString *pattern;

@end
