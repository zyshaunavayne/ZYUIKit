//
//  UIImage+ZYColor.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 通过颜色转成图片

@interface UIImage (ZYColor)

/// 颜色转成图片
/// - Parameters:
///   - color: 颜色
///   - size: 图片大小
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END

