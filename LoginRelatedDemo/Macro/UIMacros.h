//
//  UIMacros.h
//  MoodDiaryDemo
//
//  Created by 邓旭东 on 2017/12/25.
//  Copyright © 2017年 邓旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef UIMacros_h
#define UIMacros_h

#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef PBSCREEN_WIDTH
#define PBSCREEN_WIDTH   ([[UIScreen mainScreen]bounds].size.width)
#endif

#ifndef PBSysFont
#define PBSysFont(a)        [UIFont systemFontOfSize:a]
#endif

#ifndef PBSysBoldFont
#define PBSysBoldFont(a)    [UIFont boldSystemFontOfSize:a]
#endif

#define PBCall(block,...) !block?:block(__VA_ARGS__);
#define PBCallRerurn(block,failReturnValue,...) \
block?(block(__VA_ARGS__)):(failReturnValue)

#define PBMAIN(block)  if ([NSThread isMainThread]) {\
block();\
}else{\
dispatch_async(dispatch_get_main_queue(),block);\
}
#define PBMAINDelay(x, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(x * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define PBBACK(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#ifndef NS_ASSUME_NONNULL_BEGIN
#define NS_ASSUME_NONNULL_BEGIN _Pragma("clang assume_nonnull begin")
#endif
#ifndef NS_ASSUME_NONNULL_END
#define NS_ASSUME_NONNULL_END   _Pragma("clang assume_nonnull end")
#endif

#define PBClassName [NSString stringWithUTF8String:object_getClassName([self class])]

#endif /* UIMacros_h */

NS_ASSUME_NONNULL_BEGIN

static const CGFloat PBANIMATE_DURATION = 0.25f;
static NSString *const testUrlHeaderString = @"https://testXXXX/";
static NSString *const urlHeaderString = @"https://XXXX/";

static inline NSInteger dxd_autoResize(CGFloat size) {
    return (size*PBSCREEN_WIDTH)/375.f;
}

NS_ASSUME_NONNULL_END
