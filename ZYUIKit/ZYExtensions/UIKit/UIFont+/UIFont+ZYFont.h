//
//  UIFont+ZYFont.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

/// 设置系统的字体大小（YES：粗体 NO：常规）
#define ZY_Font(__size__,__bold__) ((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))

/// 中等
#define ZY_MediumFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?ZY_Font(__size__ , YES):[UIFont ZY_pingFangSCMediumWithFontSize:__size__])

/// 粗体
#define ZY_BoldFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?ZY_Font(__size__ , NO):[UIFont ZY_pingFangSCBoldWithFontSize:__size__])

/// 常规
#define ZY_RegularFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?ZY_Font(__size__ , NO):[UIFont ZY_pingFangSCRegularWithFontSize:__size__])

/// Heavy
#define ZY_HeavyFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?ZY_Font(__size__ , NO):[UIFont ZY_pingFangSCHeavyWithFontSize:__size__])

/// Semibold
#define ZY_SemiboldFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?ZY_Font(__size__ , NO):[UIFont ZY_pingFangSCSemiboldWithFontSize:__size__])

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZYFont)

+ (UIFont *)ZY_pingFangSCMediumWithFontSize:(CGFloat)size;

+ (UIFont *)ZY_pingFangSCBoldWithFontSize:(CGFloat)size;

+ (UIFont *)ZY_pingFangSCRegularWithFontSize:(CGFloat)size;

+ (UIFont *)ZY_pingFangSCHeavyWithFontSize:(CGFloat)size;

+ (UIFont *)ZY_pingFangSCSemiboldWithFontSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
