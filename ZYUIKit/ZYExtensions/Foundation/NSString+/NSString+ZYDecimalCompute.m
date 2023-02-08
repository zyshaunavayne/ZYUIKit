//
//  NSString+ZYDecimalCompute.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "NSString+ZYDecimalCompute.h"
#import "ZYKitLnline.h"

@implementation NSString (ZYDecimalCompute)

///------------
/// 针对价格计算 float、double（有小数点）计算失真的问题
///------------

/// 加
- (NSString *(^) (NSString *))zy_adding
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString *(NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSDecimalNumber *result = [number_first decimalNumberByAdding:number_second];
        return[result stringValue];
    };
}

/// 减
- (NSString *(^) (NSString *))zy_subtracting
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString *(NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSDecimalNumber *result = [number_first decimalNumberBySubtracting:number_second];
        return[result stringValue];
    };
}

/// 乘
- (NSString *(^) (NSString *))zy_multiplying
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString *(NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSDecimalNumber *result = [number_first decimalNumberByMultiplyingBy:number_second];
        return[result stringValue];
    };
}

/// 除
- (NSString *(^) (NSString *))zy_dividing
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString *(NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSDecimalNumber *result = [number_first decimalNumberByDividingBy:number_second];
        return[result stringValue];
    };
}

- (NSString *(^) (NSInteger))zy_decimalCeilingPoint
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString * (NSInteger point) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = NSNumberFormatterRoundCeiling;
        formatter.maximumFractionDigits = point;
        return [formatter stringFromNumber:number];
    };
}

- (NSString *(^) (NSInteger))zy_decimalCeilingPointSaveZero
{
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:self];
    return^NSString * (NSInteger point) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###0.00"];//保留无效的0
        formatter.roundingMode = NSNumberFormatterRoundCeiling;
        formatter.maximumFractionDigits = point;
        return [formatter stringFromNumber:number];
    };
}

/// 是否相等
- (BOOL(^) (NSString *))zy_same
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^BOOL (NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSComparisonResult result = [number_first compare:number_second];
        if (result == NSOrderedSame) {
            return YES;
        }
        return NO;
    };
}

/// 是否大于
- (BOOL(^) (NSString *))zy_descending
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^BOOL (NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSComparisonResult result = [number_first compare:number_second];
        if (result == NSOrderedDescending) {
            return YES;
        }
        return NO;
    };
}

/// 是否大于等于
- (BOOL(^) (NSString *))zy_descendingAndSame
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^BOOL (NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSComparisonResult result = [number_first compare:number_second];
        if (result == NSOrderedDescending || result == NSOrderedSame) {
            return YES;
        }
        return NO;
    };
}

/// 是否小于
- (BOOL(^) (NSString *))zy_ascending
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^BOOL (NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSComparisonResult result = [number_first compare:number_second];
        if (result == NSOrderedAscending) {
            return YES;
        }
        return NO;
    };
}

/// 是否小于等于
- (BOOL(^) (NSString *))zy_ascendingAndSame
{
    NSDecimalNumber *number_first = [NSDecimalNumber decimalNumberWithString:self];
    return^BOOL (NSString *value) {
        NSDecimalNumber *number_second = [NSDecimalNumber decimalNumberWithString:value];
        NSComparisonResult result = [number_first compare:number_second];
        if (result == NSOrderedAscending || result == NSOrderedSame) {
            return YES;
        }
        return NO;
    };
}

- (NSString *)zy_decimalNumber
{
    NSString *doubleString  = [NSString stringWithFormat:@"%lf", self.doubleValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

#pragma mark - 物流要用分类
/// 删掉数字后面多余的0
- (NSString *)zy_deleteInvalidZeros {
     
    if ([self isEqualToString:@""]) {
        return @"";
    }
    NSDecimalNumber *a = [[NSDecimalNumber alloc] initWithString:self];
    return ZYSafeString(a.stringValue);
}

/// 保留一位小数取约等于，并删掉数字后面多余的0
- (NSString *)zy_roundSaveOnePoint {
    
    return [self roundSavePointIndex:1];
}

/// 保留2位小数取约等于，并删掉数字后面多余的0
- (NSString *)zy_roundSaveTwoPoint {
    
    return [self roundSavePointIndex:2];
}

/// 保留几位小数，并删除后面多余的0
/// @param index 几位小数
- (NSString *)roundSavePointIndex:(NSInteger)index {
    
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                   scale:index
                        raiseOnExactness:NO
                         raiseOnOverflow:NO
                        raiseOnUnderflow:NO
                     raiseOnDivideByZero:NO];

    NSDecimalNumber *aDN = [[NSDecimalNumber alloc] initWithString:self];
    NSDecimalNumber *resultDN = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return resultDN.stringValue;
}

@end

