//
//  UIFont+ZYFont.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIFont+ZYFont.h"

@implementation UIFont (ZYFont)

+ (UIFont *)zy_pingFangSCMediumWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightMedium];
}

+ (UIFont *)zy_pingFangSCBoldWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightBold];
}

+ (UIFont *)zy_pingFangSCRegularWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightRegular];
}

+ (UIFont *)zy_pingFangSCHeavyWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightHeavy];
}

+ (UIFont *)zy_pingFangSCSemiboldWithFontSize:(CGFloat)size
{
    return [UIFont systemFontOfSize:size weight:UIFontWeightSemibold];
}

@end
