//
//  DXDReParser.h
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DXDReGroup;

@interface DXDReParser : NSObject {
    NSString *_pattern;
    BOOL _ignoreCase;
    DXDReGroup *_node;
    BOOL _finished;
    NSRegularExpression *_exactQuantifierRegex;
    NSRegularExpression *_rangeQuantifierRegex;
}

- (id)initWithPattern:(NSString*)pattern;
- (id)initWithPattern:(NSString*)pattern ignoreCase:(BOOL)ignoreCase;
- (NSString*)reformatString:(NSString*)input;

@property (nonatomic, readonly) NSString *pattern;

@end
