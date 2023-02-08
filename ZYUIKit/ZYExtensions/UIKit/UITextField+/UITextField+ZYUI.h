//
//  UITextField+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

/// 输入的内容限制
typedef NS_OPTIONS(NSUInteger, ZYTextFieldInputType) {
    /// 没有限制
    ZYTextFieldInputTypeNone             = 0,
    /// 允许输入阿拉伯数字
    ZYTextFieldInputTypeArabicNumerals   = 1 << 0,
    /// 允许输入英文字母
    ZYTextFieldInputTypeEnglishLetters   = 1 << 1,
    /// 允许输入中文
    ZYTextFieldInputTypeChinese          = 1 << 2,
    /// 允许输入空格
    ZYTextFieldInputTypeBlank            = 1 << 3,
    /// 允许输入特殊字符（支持大部分特殊符号，尽量少用这个）
    ZYTextFieldInputTypeSpecial          = 1 << 4,
};

///输入框类型
typedef NS_ENUM(NSUInteger, ZYTextFieldType) {
    ///默认输入框，不做限制
    ZYTextFieldTypeDefault,
    ///纯数字输入框,没有小数点
    ZYTextFieldTypeNumber,
    ///金额输入框，允许输入小数点后两位
    ZYTextFieldTypeMoney,
    ///允许输入小数点后一位(例如：运程)
    ZYTextFieldTypeOneDecimal
};

@interface UITextField (ZYUI)

/// 快速创建一个UITextField
/// @param placeholder 占位符
/// @param placeholderColor 占位符颜色
/// @param placeholderFont 占位符字体
/// @param textColor 内容颜色
/// @param textFont 内容字体
+ (UITextField *)zy_createTextFieldWithPlaceholder:(NSString *)placeholder
                                   placeholderColor:(UIColor *)placeholderColor
                                    placeholderFont:(UIFont *)placeholderFont
                                          textColor:(UIColor *)textColor
                                           textFont:(UIFont *)textFont;
/// 限制输入的最大长度限制
@property (nonatomic, assign) IBInspectable NSInteger zy_limitMaxLength;
/// 输入框的类型,限制小数点后输入位数
@property (nonatomic, assign) ZYTextFieldType zy_textFieldType;
/// 输入的内容限制
@property (nonatomic, assign) ZYTextFieldInputType zy_inputType;

/// 限制输入的最大长度限制
/// @param maxLength 最大长度
/// @param textViewDidChangeBlock 监听字符变化后回调
- (void)zy_limitMaxLength:(NSInteger)maxLength
         textViewDidChange:(void (^)(NSString *text))textViewDidChangeBlock;


@end

