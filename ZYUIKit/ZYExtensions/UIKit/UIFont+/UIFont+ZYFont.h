//
//  UIFont+ZYFont.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

/// 设置系统的字体大小（YES：粗体 NO：常规）
#define zy_Font(__size__,__bold__) ((__bold__)?([UIFont boldSystemFontOfSize:__size__]):([UIFont systemFontOfSize:__size__]))

/// 中等
#define zy_MediumFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?zy_Font(__size__ , YES):[UIFont zy_pingFangSCMediumWithFontSize:__size__])

/// 粗体
#define zy_BoldFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?zy_Font(__size__ , NO):[UIFont zy_pingFangSCBoldWithFontSize:__size__])

/// 常规
#define zy_RegularFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?zy_Font(__size__ , NO):[UIFont zy_pingFangSCRegularWithFontSize:__size__])

/// Heavy
#define zy_HeavyFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?zy_Font(__size__ , NO):[UIFont zy_pingFangSCHeavyWithFontSize:__size__])

/// Semibold
#define zy_SemiboldFont(__size__) (([[[UIDevice currentDevice] systemVersion] floatValue]<9.0)?zy_Font(__size__ , NO):[UIFont zy_pingFangSCSemiboldWithFontSize:__size__])

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZYFont)

+ (UIFont *)zy_pingFangSCMediumWithFontSize:(CGFloat)size;

+ (UIFont *)zy_pingFangSCBoldWithFontSize:(CGFloat)size;

+ (UIFont *)zy_pingFangSCRegularWithFontSize:(CGFloat)size;

+ (UIFont *)zy_pingFangSCHeavyWithFontSize:(CGFloat)size;

+ (UIFont *)zy_pingFangSCSemiboldWithFontSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
