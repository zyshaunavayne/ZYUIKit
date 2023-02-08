//
//  ZYEasy.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSDate+ZYUI.h"

/// Convert pixel to point.
/// @param value value
CG_INLINE CGFloat ZYCGFloatFromPixel(CGFloat value)
{
    return value / [UIScreen mainScreen].scale;
}

/// 返回一个有效字符串
/// @param value obj
CG_INLINE OS_OVERLOADABLE NSString *ZYSafeString(id value)
{
    NSString *string = @"";
    if ([value isKindOfClass:[NSNumber class]]) { return [value description];}
    else if (value == nil || [value isKindOfClass:[NSNull class]]) { return string;}
    else if ([value isKindOfClass:[NSString class]]) {
        if ([(NSString *)value isEqualToString:@"<null>"] || [(NSString *)value isEqualToString:@"null"] || [(NSString *)value isEqualToString:@"(null)"] || ((NSString *)value).length == 0) { return string;
        } else { string = value;}
    }
    return string;
}

/// 返回一个有效字符串
/// @param value obj
/// @param replacing 当传入的value不是有效的字符串时需要替换成的字符串（replacing = nil 默认会替换成空字符串）
CG_INLINE OS_OVERLOADABLE NSString *ZYSafeString(id value, NSString *replacing)
{
    NSString *string = replacing ?: @"";
    if ([value isKindOfClass:[NSNumber class]]) { return [value description];}
    else if (value == nil || [value isKindOfClass:[NSNull class]]) { return string;}
    else if ([value isKindOfClass:[NSString class]]) {
        if ([(NSString *)value isEqualToString:@"<null>"] || [(NSString *)value isEqualToString:@"null"] || [(NSString *)value isEqualToString:@"(null)"] || ((NSString *)value).length == 0) { return string;
        } else { string = value;}
    }
    return string;
}

/// 判断对象是否为空（包含空数组、空字典）
/// @param value obj
CG_INLINE BOOL ZYIsEmpty(id value)
{
    if (value == nil || [value isKindOfClass:[NSNull class]]) { return YES;}
    else if ([value isKindOfClass:NSString.class]) {
        if ([(NSString *)value isEqualToString:@"<null>"] || [(NSString *)value isEqualToString:@"null"] || [(NSString *)value isEqualToString:@"(null)"] || ((NSString *)value).length == 0) { return YES;
        }
    } else if ([value isKindOfClass:NSArray.class]) {
        if (((NSArray *)value).count == 0) { return YES;}
    } else if ([value isKindOfClass:NSDictionary.class]) {
        if (((NSDictionary *)value).count == 0) { return YES;}
    } else if ([value isKindOfClass:NSData.class]) {
        if (((NSData *)value).length == 0) { return YES;}
    }
    return NO;
}

/// 返回一个有效的数组
/// @param value obj
CG_INLINE NSArray *ZYSafeArray(id value)
{
    if ([value isKindOfClass:NSArray.class]) { return value;}
    return @[];
}

/// 返回一个有效的字典
/// @param value obj
CG_INLINE NSDictionary *ZYSafeDictionary(id value)
{
    if ([value isKindOfClass:NSDictionary.class]) { return value;}
    return @{};
}

/// 根据时间戳返回日期字符串；默认格式 = yyyy-MM-dd HH:mm:ss
/// @param time 时间戳（一般服务端返回的都是13位的）
/// @param dateFormat 日期格式 (yyyy-MM-dd HH:mm:ss, yyyy.MM.dd, yyyy-MM-dd HH:mm, yyyy-MM-dd); 默认 = yyyy-MM-dd HH:mm:ss
CG_INLINE NSString *ZYDateString(NSTimeInterval time, NSString *dateFormat)
{
    if (time <= 0) { return @"-";}
    NSString *timeStr = [NSString stringWithFormat:@"%.0f", time];
    if (timeStr.length == 13) { time = time / 1000;}
    return [NSDate zy_stringWithTime:time dateFormat:dateFormat ?: @"yyyy-MM-dd HH:mm:ss"];
}
