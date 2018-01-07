//
//  UIColor+Expand.m
//  PublishingDemo
//
//  Created by 邓旭东 on 2017/12/20.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import "UIColor+Expand.h"

@implementation UIColor (Expand)

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)pb_colorWithHexString:(NSString *)hexString Alpha:(CGFloat)alpha
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            red = 0 ; green = 0 ; blue = 0;
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)pb_colorWithHexString:(NSString *)hexString {
    return [UIColor pb_colorWithHexString:hexString Alpha:1.0f];
}

+ (UIColor*)randomColor {
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
