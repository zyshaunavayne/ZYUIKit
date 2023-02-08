//
//  UILongPressGestureRecognizer+ZYExtersion.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UILongPressGestureRecognizer+ZYExtersion.h"
#import <objc/runtime.h>

@implementation UILongPressGestureRecognizer (ZYExtersion)

- (void)setzy_block:(void (^)(UILongPressGestureRecognizer * _Nonnull))zy_block
{
    objc_setAssociatedObject(self, @selector(zy_block),zy_block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(zy_click:)];
}

- (void (^)(UILongPressGestureRecognizer * _Nonnull))zy_block
{
    return objc_getAssociatedObject(self, @selector(zy_block));
}

- (void)zy_click:(UILongPressGestureRecognizer *)zy_tap
{
    if (self.zy_block) {
        self.zy_block(zy_tap);
    }
}

@end
