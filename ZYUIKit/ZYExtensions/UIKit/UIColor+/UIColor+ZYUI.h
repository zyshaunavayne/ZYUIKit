//
//  UIColor+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

/// RGB
#define ZYColor_RGB(R, G, B) [UIColor colorWithRed:(CGFloat)(R)/255.0f green:(CGFloat)(G)/255.0f blue:(CGFloat)(B)/255.0f alpha:1.0f]
/// 十六进制颜色转换
#define ZYColor_HEX(hex) [UIColor zy_colorWithHexString:hex]
/// 十六进制颜色转换
#define ZYColor_HEXA(hex, alpha) [UIColor zy_colorWithHexString:hex andAlpha:alpha]

@interface UIColor (ZYUI)
@property (nonatomic, readonly) CGColorSpaceModel zy_colorSpaceModel;
@property (nonatomic, readonly) BOOL zy_canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat zy_red;
@property (nonatomic, readonly) CGFloat zy_green;
@property (nonatomic, readonly) CGFloat zy_blue;
@property (nonatomic, readonly) CGFloat zy_white;
@property (nonatomic, readonly) CGFloat zy_alpha;
@property (nonatomic, readonly) UInt32 zy_rgbHex;

/// 返回RGB颜色值字符串
- (NSString *)zy_stringFromColor;

/// 返回十六进制颜色字符串
- (NSString *)zy_hexStringFromColor;

/// 颜色
/// @param stringToConvert 十六进制颜色
+ (UIColor *)zy_colorWithHexString:(NSString *)stringToConvert;

/// 颜色
/// @param stringToConvert 十六进制颜色
/// @param alpha 透明度
+ (UIColor *)zy_colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

/// 随机一个颜色值
+ (UIColor *)zy_randomColor;

/// 设置单色
/// @param RGB 单色值
+ (UIColor *)zy_RGBColor:(NSInteger)RGB;

/// 线条颜色
+ (UIColor *)zy_lineColor;

@end

