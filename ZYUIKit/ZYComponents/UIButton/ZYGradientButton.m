//
//  ZYGradientButton.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYGradientButton.h"

@implementation ZYGradientButton

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

@end

