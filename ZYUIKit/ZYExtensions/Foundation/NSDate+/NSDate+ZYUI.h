//
//  NSDate+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZYDateUnitFlags) {
    /// 周
    ZYDateUnitFlagsWeek,
    /// 月
    ZYDateUnitFlagsMonth,
    /// 年
    ZYDateUnitFlagsYear
};

@interface NSDate (ZYUI)

/// 获取当前时间
/// @param format 日期格式 (yyyy-MM-dd HH:mm:ss, yyyy.MM.dd, yyyy-MM-dd HH:mm, yyyy-MM-dd); 默认 = yyyy-MM-dd HH:mm:ss
+ (NSString *)zy_getNowTimeWtihDateFormat:(NSString *)format;

/// 根据时间戳创建一个日期
/// @param time 时间戳（默认是精确到毫秒13位）
/// @param format 日期格式 (yyyy-MM-dd HH:mm:ss, yyyy.MM.dd, yyyy-MM-dd HH:mm, yyyy-MM-dd); 默认 = yyyy-MM-dd HH:mm:ss
+ (NSString *)zy_stringWithTime:(NSTimeInterval)time
                      dateFormat:(NSString *)format;

/// 返回当天的日期
/// @param format 日期格式（yyyy-MM-dd）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format;

/// 返回（本周、本月、本年）第一天的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param unitFlags 日期单位
+ (NSString *)zy_stringFirstDayWithFormat:(NSString *)format
                                 unitFlags:(ZYDateUnitFlags)unitFlags;

/// 返回（本周、本月、本年）第一天的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param unitFlags 日期单位
/// @param offset 默认 offset = 0；根据单位代表本周、本月、本年；offset < -1 则依次代表上一周、上一月、上一年；offset < 1 则依次代表下一周、下一月、下一年
+ (NSString *)zy_stringFirstDayWithFormat:(NSString *)format
                                 unitFlags:(ZYDateUnitFlags)unitFlags
                                    offset:(NSInteger)offset;

/// 根据单位 '年' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param years 要添加的 ’年‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                          byAddingYears:(NSInteger)years;

/// 根据单位 '月' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param months 要添加的 ’月‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                         byAddingMonths:(NSInteger)months;

/// 根据单位 '天' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param days 要添加的 ’天‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                           byAddingDays:(NSInteger)days;

/// 根据单位 '小时' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param hours 要添加的 ’小时‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                          byAddingHours:(NSInteger)hours;

/// 根据单位 '分钟' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param minutes 要添加的 ’分钟‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                        byAddingMinutes:(NSInteger)minutes;

/// 根据单位 '秒' 返回当前之后或者之前的日期
/// @param format 返回的日期格式（yyyy-MM-dd）
/// @param seconds 要添加的 ’秒‘ 数（正数表示之后；负数表示之前）
+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                        byAddingSeconds:(NSInteger)seconds;

/// 返回一个自定义日期格式的字符串
/// @param format 返回的日期格式
- (NSString *)zy_stringWithFormat:(NSString *)format;

/// 时间字符串转换为时间
/// @param dateString 时间字符串
/// @param format 使用日期格式
+ (NSDate *)zy_dateWithString:(NSString *)dateString format:(NSString *)format;

/// 将时间转换为时间戳
/// @param date 时间
+ (NSString *)zy_stringTimesTampWithDate:(NSDate *)date;

/// 时间字符串转换为时间戳（跳过转换时间）
/// @param dateString 时间字符串
/// @param format 使用日期格式
+ (NSString *)zy_stringTimesTampWithString:(NSString *)dateString format:(NSString *)format;

/**
 * 获取当前时间的时间戳(毫秒)
 */
+ (NSString *)zy_getNowMSTimeStamp;

/**
 * 传毫秒时间戳转换成日期
 */
+ (NSString *)zy_stringWithMSTimeInterval:(NSString *)time format:(NSString *)format;

/**
 * 日期转毫秒时间戳
 * 解决8小时时差
 */
+ (NSString *)zy_MSTimeIntervalWithTime:(NSString *)time format:(NSString *)format;

@end


