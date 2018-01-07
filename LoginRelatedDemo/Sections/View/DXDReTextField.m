//
//  DXDReTextField.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "DXDReTextField.h"
#import "DXDReParser.h"

@implementation DXDReTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _lastAcceptedValue = nil;
        _parser = nil;
        [self addTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)dealloc {
    _lastAcceptedValue = nil;
    _parser = nil;
    [self removeTarget:self action:@selector(formatInput:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setPattern:(NSString *)pattern {
    if (pattern == nil || [pattern isEqualToString:@""])
        _parser = nil;
    else
        _parser = [[DXDReParser alloc] initWithPattern:pattern];
}

- (NSString*)pattern {
    return _parser.pattern;
}

- (void)formatInput:(UITextField *)textField {
    if (_parser == nil) return;
    
    __block DXDReParser *localParser = _parser;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *formatted = [localParser reformatString:textField.text];
        if (formatted == nil)
            formatted = self->_lastAcceptedValue;
        else
            self->_lastAcceptedValue = formatted;
        NSString *newText = formatted;
        if (![textField.text isEqualToString:newText]) {
            textField.text = formatted;
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    });
}

@end
