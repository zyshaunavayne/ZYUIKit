//
//  UIFont+ZYFont.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIFont+ZYFont.h"

@implementation UIFont (ZYFont)

+ (UIFont *)ZY_pingFangSCMediumWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)ZY_pingFangSCBoldWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)ZY_pingFangSCRegularWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (UIFont *)ZY_pingFangSCHeavyWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightHeavy];
}

+ (UIFont *)ZY_pingFangSCSemiboldWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
}

@end
