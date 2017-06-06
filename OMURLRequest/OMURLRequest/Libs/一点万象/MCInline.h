//
//  MCInline.h
//  mixc
//
//  Created by augsun on 7/6/16.
//  Copyright © 2016 crland. All rights reserved.
//

#ifndef MCInline_h
#define MCInline_h
#import <UIKit/UIKit.h>
#import "JXRegular.h"

static inline BOOL isNullOrNil(id obj) {
    return !obj || [obj isKindOfClass:[NSNull class]] ? YES : NO;
}

// 是否 NSString 或 NSNumber
static inline BOOL isStringOrNumber(id obj) {
    return [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]];
}

// 是否 NSString
static inline BOOL isStrObj(id obj) {
    return [obj isKindOfClass:[NSString class]] ? YES : NO;
}
// 是否 NSDictionary
static inline BOOL isDicObj(id obj) {
    return [obj isKindOfClass:[NSDictionary class]] ? YES : NO;
}

// 是否 NSArray
static inline BOOL isArrObj(id obj) {
    return [obj isKindOfClass:[NSArray class]] ? YES : NO;
}

// 2个字符串拼接 (可传入 NSString NSNumber)
static inline NSString *strCat2(id value0, id value1) {
    return [NSString stringWithFormat:@"%@%@", isStringOrNumber(value0) ? value0 : @"", isStringOrNumber(value1) ? value1 : @""];
}

// 3个字符串拼接 (可传入 NSString NSNumber)
static inline NSString *strCat3(id value0, id value1, id value2) {
    return strCat2(strCat2(value0, value1), isStringOrNumber(value2) ? value2 : @"");
}

// 转 NSInteger
static inline NSInteger intValue(id value) {
    return isStringOrNumber(value) ? [value integerValue] : 0;
}

// 转 long long
static inline long long longlongValue(id value) {
    return isStringOrNumber(value) ? [value longLongValue] : 0;
}

// 转 CGFloat
static inline CGFloat floValue(id value) {
    return isStringOrNumber(value) ? [value floatValue] : 0;
}

// 转 BOOL
static inline BOOL booValue(id value) {
    return isStringOrNumber(value) ? [value boolValue] : 0;
}

// 转 NSString
static inline NSString *strValue(id value) {
    return isStringOrNumber(value) ? [NSString stringWithFormat:@"%@", value] : @"";
}

static inline BOOL isHaveChinese(NSString *string) {
    for(int i = 0; i < string.length; i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

// 转 NSUrl
static inline NSURL *urlValue(id value) {
    if ([value isKindOfClass:[NSString class]]) {
        if (isHaveChinese(strValue(value))) {
            return [NSURL URLWithString:[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        else {
            return [NSURL URLWithString:strValue(value)];
        }
    }
    else {
        return nil;
    }
}

// 转 NSDictionary
static inline NSDictionary *dicValue(id value) {
    return [value isKindOfClass:[NSDictionary class]] ? value : nil;
}

// 转 NSArray
static inline NSArray *arrValue(id value) {
    return [value isKindOfClass:[NSArray class]] ? value : nil;
}


#endif /* MCInline_h */

















