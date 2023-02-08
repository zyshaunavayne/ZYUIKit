//
//  NSDate+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "NSDate+ZYUI.h"

@implementation NSDate (ZYUI)

+ (NSString *)zy_stringWithTime:(NSTimeInterval)time
                      dateFormat:(NSString *)format
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    if (format) { formatter.dateFormat = format;}
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:date];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
{
    return [[NSDate date] zy_stringWithFormat:format];
}

+ (NSString *)zy_stringFirstDayWithFormat:(NSString *)format unitFlags:(ZYDateUnitFlags)unitFlags;
{
    return [NSDate zy_stringFirstDayWithFormat:format unitFlags:unitFlags offset:0];
}

+ (NSString *)zy_stringFirstDayWithFormat:(NSString *)format
                                 unitFlags:(ZYDateUnitFlags)unitFlags
                                    offset:(NSInteger)offset
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components;
    NSDate *newDate;
    if (unitFlags == ZYDateUnitFlagsWeek) {
        components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate date]];
        NSInteger weekday = [components weekday];
        NSInteger firstDiff;
        if (weekday == 1) {
            firstDiff = -6;
        } else {
            firstDiff = [calendar firstWeekday] - weekday + 1;
        }
        NSInteger day = [components day];
        NSDateComponents *firstComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        [firstComponents setDay:day + firstDiff];
        newDate = [calendar dateFromComponents:firstComponents];
        if (offset != 0) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setWeekOfYear:offset];
            newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
        }
        
    } else if (unitFlags == ZYDateUnitFlagsMonth) {
        [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&newDate interval:nil forDate:[NSDate date]];
        if (offset != 0) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setMonth:offset];
            newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
        }
    } else if (unitFlags == ZYDateUnitFlagsYear) {
        [calendar rangeOfUnit:NSCalendarUnitYear startDate:&newDate interval:nil forDate:[NSDate date]];
        if (offset != 0) {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setYear:offset];
            newDate = [calendar dateByAddingComponents:components toDate:newDate options:0];
        }
    }
    return [newDate zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                          byAddingYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [[calendar dateByAddingComponents:components toDate:[NSDate date] options:0] zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                         byAddingMonths:(NSInteger)months
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [[calendar dateByAddingComponents:components toDate:[NSDate date] options:0] zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                           byAddingDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                          byAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                        byAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate zy_stringWithFormat:format];
}

+ (NSString *)zy_stringTodayWithFormat:(NSString *)format
                        byAddingSeconds:(NSInteger)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate zy_stringWithFormat:format];
}

- (NSString *)zy_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSDate *)zy_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

+ (NSString *)zy_stringTimesTampWithDate:(NSDate *)date {
    NSTimeInterval stamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", stamp];
}

+ (NSString *)zy_stringTimesTampWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];
    NSTimeInterval stamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", stamp];
}


+ (NSString *)zy_getNowMSTimeStamp {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}



+ (NSString *)zy_stringWithMSTimeInterval:(NSString *)time format:(NSString *)format; {
  
    double timeDoub = [time doubleValue];
    timeDoub = timeDoub/1000.0;
    NSTimeInterval timeInterval = timeDoub;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = format;

    NSString *staartstr = [formatter stringFromDate:date];

    return staartstr;
}


+ (NSString *)zy_MSTimeIntervalWithTime:(NSString *)time format:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:time];
    
    //解决8小时时差问题
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    NSTimeInterval stamp = [localeDate timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f", stamp];
}


@end

