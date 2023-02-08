//
//  NSAttributedString+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (ZYUI)

/// 创建一个包含图片的 attributedString
/// @param image 图片
+ (instancetype)zy_attributedStringWithImage:(UIImage *)image;

/// 创建一个包含图片的 attributedString
/// @param image 图片
/// @param offset 图片相对基线的垂直偏移（当 offset > 0 时，图片会向上偏移）
/// @param leftMargin 图片距离左侧内容的间距 （必须大于等于0）
/// @param rightMargin 图片距离右侧内容的间距（必须大于等于0）
+ (instancetype)zy_attributedStringWithImage:(UIImage *)image
                               baselineOffset:(CGFloat)offset
                                   leftMargin:(CGFloat)leftMargin
                                  rightMargin:(CGFloat)rightMargin;

/// 创建一个用来占位的空白 attributedString
/// @param width 空白占位符的宽度
+ (instancetype)zy_attributedStringWithFixedSpace:(CGFloat)width;

/// 创建一段高亮的富文本 attributedString
/// @param string 显示的文本
/// @param highlightString 需要高亮的文本
/// @param highlightColor 高亮的颜色
/// @param highlightfont 高亮的字体
+ (instancetype)zy_attributedStringColorWithString:(NSString *)string
                                    highlightString:(NSString *)highlightString
                                     highlightColor:(UIColor *)highlightColor
                                      highlightfont:(UIFont *)highlightfont;

/// 创建一段高亮的富文本 attributedString
/// @param string 显示的文本
/// @param font 字体
/// @param color 颜色
/// @param highlightString 高亮文本
/// @param highlightColor 高亮颜色
/// @param highlightfont 高亮字体
+ (instancetype)zy_attributedStringColorWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor *)color
                                    highlightString:(NSString *)highlightString
                                     highlightColor:(UIColor *)highlightColor
                                      highlightfont:(UIFont *)highlightfont;

/// 创建高亮富文本（多个）注意 highlightStrings、highlightColors、highlightFonts 是一一对应的顺序关系
/// @param string 显示的文本
/// @param font 文本字体
/// @param color 文本颜色
/// @param highlightStrings 高亮文本的数组
/// @param highlightColors 高亮颜色的数组
/// @param highlightFonts 高亮字体的数组
+ (instancetype)zy_attributedStringPackColorWithString:(NSString *)string
                                                   font:(UIFont *)font
                                                  color:(UIColor *)color
                                       highlightStrings:(NSArray *)highlightStrings
                                        highlightColors:(NSArray *)highlightColors
                                         highlightFonts:(NSArray *)highlightFonts;

/// 创建一个带有删除线的 attributedString
/// @param string 需要加删除线的文本
/// @param font 文本字体
/// @param color 文本颜色
/// @param strikethrougColor 删除线颜色
+ (instancetype)zy_attributedStringStrikethroughWithString:(NSString *)string
                                                       font:(UIFont *)font
                                                      color:(UIColor *)color
                                          strikethrougColor:(UIColor *)strikethrougColor;

/// 创建一个带有下划线的 attributedString
/// @param string 需要加下划线的文本
/// @param font 文本字体
/// @param color 文本颜色
/// @param strikethrougColor 删除线颜色
+ (instancetype)zy_attributedStringUnderlinehWithString:(NSString *)string
                                                    font:(UIFont *)font
                                                   color:(UIColor *)color
                                       strikethrougColor:(UIColor *)strikethrougColor;

@end
