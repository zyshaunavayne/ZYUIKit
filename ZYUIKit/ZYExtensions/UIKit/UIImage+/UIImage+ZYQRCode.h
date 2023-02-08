//
//  UIImage+ZYQRCode.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZYQRCode)

/// 生成一个二维码
/// @param string 二维码内容
/// @param size 二维码大小
+ (UIImage *)zy_createQRCodeImageWithString:(NSString *)string
                                        size:(CGFloat)size;

/// 生成一个二维码
/// @param string 二维码内容
/// @param size 二维码大小
/// @param color 二维码颜色
+ (UIImage *)zy_createQRCodeImageWithString:(NSString *)string
                                        size:(CGFloat)size
                                       color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

