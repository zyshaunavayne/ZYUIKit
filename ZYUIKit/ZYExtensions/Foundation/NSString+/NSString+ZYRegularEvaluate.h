//
//  NSString+ZYRegularEvaluate.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

//  正则效验

#import <Foundation/Foundation.h>

@interface NSString (ZYRegularEvaluate)

/// 验证是否有效的手机号码
- (BOOL)zy_validateMobile;

/// 验证是否有效的6-18位字母数字组合密码
- (BOOL)zy_validatePassword;

/// 效验是否有效的身份证号
- (BOOL)zy_validateIdentityCard;

/// 效验是否有效的银行卡
- (BOOL)zy_validateBankCard;

/// 效验是否为阿拉伯数字
- (BOOL)zy_validateArabicNumerals;

/// 效验是否为英文字母
- (BOOL)zy_validateEnglishLetters;

/// 效验是否为中文
- (BOOL)zy_validateChinese;

/// 效验是否有非法字符
- (BOOL)zy_validateTheillegalCharacter;

/// 效验是否有表情字符
- (BOOL)zy_validateEmoji;

/// 效验是否有效邮箱
- (BOOL)zy_validateEmail;

@end

