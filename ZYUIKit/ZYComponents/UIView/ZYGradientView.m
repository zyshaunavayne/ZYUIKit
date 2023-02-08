//
//  ZYGradientView.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//


#import "ZYGradientView.h"

@implementation ZYGradientView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

@end
