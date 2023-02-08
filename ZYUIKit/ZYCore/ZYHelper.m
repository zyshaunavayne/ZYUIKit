//
//  ZYHelper.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYHelper.h"

@implementation ZYHelper

+ (UIImage *)imageNamed:(NSString *)name
{
    static NSBundle *resourceBundle = nil;
    if (!resourceBundle) {
        NSBundle *mainBundle = [ZYHelper mainBundle];
        NSString *resourcePath = [mainBundle pathForResource:@"ZYResources" ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:resourcePath] ?: mainBundle;
    }
    UIImage *image = [UIImage imageNamed:name inBundle:resourceBundle compatibleWithTraitCollection:nil];
    return image;
}

@end

@implementation ZYHelper (Bundle)

+ (NSBundle *)mainBundle
{
    return [NSBundle bundleForClass:self];
}

@end
