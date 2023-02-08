//
//  NSString+ZYDecimalCompute.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYDecimalCompute)

///------------
/// 针对价格计算 float、double（有小数点）计算失真的问题
///------------

/// 加
- (NSString *(^) (NSString *))zy_adding;

/// 减
- (NSString *(^) (NSString *))zy_subtracting;

/// 乘
- (NSString *(^) (NSString *))zy_multiplying;

/// 除
- (NSString *(^) (NSString *))zy_dividing;

/// 四舍五入。  保留小数点后面的0
- (NSString *(^) (NSInteger))zy_decimalCeilingPointSaveZero;

/// 四舍五入。
- (NSString *(^) (NSInteger))zy_decimalCeilingPoint;

/// 是否相等
- (BOOL(^) (NSString *))zy_same;

/// 是否大于
- (BOOL(^) (NSString *))zy_descending;

/// 是否大于等于
- (BOOL(^) (NSString *))zy_descendingAndSame;

/// 是否小于
- (BOOL(^) (NSString *))zy_ascending;

/// 是否小于等于
- (BOOL(^) (NSString *))zy_ascendingAndSame;

/// 修复精度丢失但不做四舍五入处理
- (NSString *)zy_decimalNumber;

#pragma mark - 物流需要用的数字逻辑
/// 删掉数字后面多余的0
- (NSString *)zy_deleteInvalidZeros;

/// 保留一位小数取约等于，并删掉数字后面多余的0
- (NSString *)zy_roundSaveOnePoint;

/// 保留2位小数取约等于，并删掉数字后面多余的0
- (NSString *)zy_roundSaveTwoPoint;



@end

