//
//  ZYMake.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZYHTMLRef, ZYHumpPriceRef, ZYFormatPriceRef, ZYStrikethroughRef, ZYDifferentPriceRef;

/// 创建一段高亮富文本 attributedString
/// @param string 显示的文字
/// @param highlightString 高亮文本
/// @param highlightColor 高亮颜色
/// @param highlightfont 高亮字体
NSAttributedString *ZYMakeAttributedColor(NSString *string, NSString *highlightString, UIColor *highlightColor, UIFont *highlightfont);

/// 创建一段高亮富文本 attributedString（多个）注意 highlightStrings、highlightColors、highlightFonts 是一一对应的顺序关系
/// @param string 显示的文字
/// @param highlightStrings 高亮文本的数组
/// @param highlightColors 高亮颜色的数组
/// @param highlightFonts 高亮字体的数组
NSAttributedString *ZYMakeAttributedPackColor(NSString *string, NSArray *highlightStrings, NSArray *highlightColors, NSArray *highlightFonts);

/// 根据返回的富文本标签创建一个可加载HTML
/// @param body 带html标签的内容
/// @param block 其他设置
NSString *ZYMakeHTMLString(NSString *body, void (NS_NOESCAPE ^block)(ZYHTMLRef *make));

/// 根据服务端返回的价格 格式化显示（向原点靠近的方向取整（如：11527146.979 格式 = 11527146.97））；默认保留2位小数
/// @param price 价格数字字符串（不带单位）
/// @param block 其他设置
NSString *ZYMakeFormatPriceString(NSString *price, void (NS_NOESCAPE ^block)(ZYFormatPriceRef *make));

/// 创建价格驼峰式显示的富文本 attributedString（￥999.00 整数部分凸显）；文本颜色、字体大小和UILabel的属性设置有关
/// @param price 价格文本
/// @param block 其他设置
NSAttributedString *ZYMakeHumpPriceAttributedString(NSString *price, void (NS_NOESCAPE ^block)(ZYHumpPriceRef *make));

/// 创建一个带有删除线的富文本 attributedString
/// @param string 文本
/// @param block 其他设置
NSAttributedString *ZYMakeStrikethroughAttributedString(NSString *string, void (NS_NOESCAPE ^block)(ZYStrikethroughRef *make));

/// 创建原价格和销售价格的差异化的富文本 attributedString
/// @param bPrice 原价（￥280.00）
/// @param sPrice 销售价格（￥300.00）
/// @param block 其他设置
NSAttributedString *ZYMakeDifferentPriceAttributedString(NSString *bPrice, NSString *sPrice, void (NS_NOESCAPE ^block)(ZYDifferentPriceRef *make));


///-------------------------------------------------- ZYFormatPriceRef --------------------------------------------------

@interface ZYFormatPriceRef : NSObject
/// 价格数字字符串（不带单位）
@property (nonatomic, strong, readonly) ZYFormatPriceRef *(^price)(NSString *price);
/// 保留最大小数点； 默认 = 2
@property (nonatomic, strong, readonly) ZYFormatPriceRef *(^digits)(NSInteger digits);
/// 数字格式；默认 = nil（,###.##，###0.00 ··· 11527146.97 格式 = 11,527,146.97）注意：会影响保留的小数点位数
@property (nonatomic, strong, readonly) ZYFormatPriceRef *(^numberFormat)(NSString *numberFormat);
/// 舍入模式；默认 = NSNumberFormatterRoundDown（靠原点取整 如：11527146.979 格式 = 11527146.97）
@property (nonatomic, strong, readonly) ZYFormatPriceRef *(^roundingMode)(NSNumberFormatterRoundingMode roundingMode);
@end

///-------------------------------------------------- ZYHTMLRef --------------------------------------------------

@interface ZYHTMLRef : NSObject
/// 带html标签的内容
@property (nonatomic, strong, readonly) ZYHTMLRef *(^body)(NSString *body);
/// 添加额外的图片显示（添加在最末端）
@property (nonatomic, strong, readonly) ZYHTMLRef *(^extraImages)(NSArray <NSString *>*extraImages);
@end

///-------------------------------------------------- ZYHumpPriceRef --------------------------------------------------

@interface ZYHumpPriceRef : NSObject
/// 价格字符串；带符号的（￥280.00）
@property (nonatomic, strong, readonly) ZYHumpPriceRef *(^price)(NSString *price);
/// 字体大小 （不设置 默认 = UILabel的设置）
@property (nonatomic, strong, readonly) ZYHumpPriceRef *(^font)(UIFont *font);
/// 字体颜色（不设置 默认 = UILabel的设置）
@property (nonatomic, strong, readonly) ZYHumpPriceRef *(^color)(UIColor *color);
/// 凸显部分的字体大小（大号；只会凸显整数部分）
@property (nonatomic, strong, readonly) ZYHumpPriceRef *(^boldFont)(UIFont *boldFont);
/// 凸显部分的颜色（不设置；默认= UILabel的设置）
@property (nonatomic, strong, readonly) ZYHumpPriceRef *(^boldColor)(UIColor *boldColor);
@end

///-------------------------------------------------- ZYStrikethroughRef --------------------------------------------------

@interface ZYStrikethroughRef : NSObject
/// 需要加删除线的文本
@property (nonatomic, strong, readonly) ZYStrikethroughRef *(^string)(NSString *string);
/// 文本字体 （不设置 默认 = UILabel的设置）
@property (nonatomic, strong, readonly) ZYStrikethroughRef *(^font)(UIFont *font);
/// 文本颜色 （不设置 默认 = UILabel的设置）
@property (nonatomic, strong, readonly) ZYStrikethroughRef *(^color)(UIColor *color);
/// 删除线颜色 （不设置 默认 = UILabel的设置）
@property (nonatomic, strong, readonly) ZYStrikethroughRef *(^strikethrougColor)(UIColor *strikethrougColor);
@end

///-------------------------------------------------- ZYDifferentPriceRef --------------------------------------------------

@interface ZYDifferentPriceRef : NSObject
/// 之前的价格（原价￥280.00）
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^bPrice)(NSString *bPrice);
/// 之前的价格（原价）显示颜色
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^bPriceColor)(UIColor *bPriceColor);
/// 之前的价格（原价）字体大小
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^bPriceFont)(UIFont *bPriceFont);
/// 销售价格（￥300.00）
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^sPrice)(NSString *sPrice);
/// 销售价格显示颜色
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^sPriceColor)(UIColor *sPriceColor);
/// 销售价格字体大小
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^sPriceFont)(UIFont *sPriceFont);
/// 销售价格凸显部分的字体大小
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^boldFont)(UIFont *boldFont);
/// 销售价格凸显部分的字体颜色
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^boldColor)(UIColor *boldColor);
/// 原价和销售价格显示的间距
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^space)(CGFloat space);
/// 排列顺序；默认 = 0 原价在左 销售价在右（ = 1 原价在右 销售价在左）
@property (nonatomic, strong, readonly) ZYDifferentPriceRef *(^order)(NSInteger order);
@end

