//
//  NSString+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYUI)

///------------
/// 针对数量/单位小数点限制
///------------

/// 单位小数点限制
/// @param frontLimit 小数点前面限制多少位
/// @param decimalLimit 小数点后面限制多少位
/// @param minimum 最小值
/// @param maximum 最大值
- (NSString *)zy_unitFrontLimit:(NSInteger)frontLimit
                    decimalLimit:(NSInteger)decimalLimit
                         minimum:(NSString *)minimum
                         maximum:(NSString *)maximum;

#pragma mark - 物流用的分类
/// 如果字符串为空就用"/"替换
- (NSString *)zy_spaceToSlash;

/// 在第几位后面加****
/// @param frontNum 前面几位是明码
/// @param behindNum 后面几位是***
- (NSString *)zy_sensitivityStringFrontNum:(NSUInteger)frontNum behindNum:(NSUInteger)behindNum;

/// 米转千米，且保留一位小数
- (NSString *)zy_meterToKilometerAndSaveOnePoint;

/// 只输出中文、移除非中文字段
- (NSString *)zy_onlyOutputChinese;

#pragma mark - 招采
/**
 * 文件大小转换成 KB、MB、GB
 */
- (NSString *)zy_convertFileSize;

/**
 * 阿拉伯数字转汉字
 *  @"123456789" -->  一亿二千三百四十五万六千七百八十九
 */
- (NSString *)zy_translationNumber;


@end
