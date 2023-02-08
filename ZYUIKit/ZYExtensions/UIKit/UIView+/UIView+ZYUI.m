//
//  UIView+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIView+ZYUI.h"
#import "UITapGestureRecognizer+ZYExtersion.h"
#import "UILongPressGestureRecognizer+ZYExtersion.h"

@implementation UIView (ZYUI)

- (void)zy_horizontalLayoutRequired
{
    /// 1. 抗拉伸
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    /// 2. 抗压缩
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)zy_verticalLayoutRequired
{
    /// 1. 抗拉伸
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    /// 2. 抗压缩
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)zy_addShadowWithShadowColor:(UIColor *)color radius:(CGFloat)radius andAlpha:(CGFloat)alpha {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = path.CGPath;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = alpha;//阴影透明度，默认0
    self.layer.shadowRadius = radius;//阴影半径，默认3
    self.layer.masksToBounds = NO;
}

- (void)zy_cornerRadius:(CGFloat)radius
             borderColor:(UIColor *)color
             borderWidth:(CGFloat)width
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    if (color) {
        self.layer.borderColor = color.CGColor;
        self.layer.borderWidth = width;
    }
}

- (void)zy_addTapAction:(void (^)(UITapGestureRecognizer *, UIView *))zy_action
{
    [self zy_addMoreTaps:1 zy_action:^(UITapGestureRecognizer *zy_tap, UIView *zy_view) {
        zy_action(zy_tap,zy_view);
    }];
}

- (void)zy_addMoreTaps:(NSInteger)moreCount zy_action:(void (^)(UITapGestureRecognizer *, UIView *))zy_action
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = UITapGestureRecognizer.alloc.init;
    [tapGestureRecognizer setNumberOfTapsRequired:moreCount];
    tapGestureRecognizer.zy_block = ^(UITapGestureRecognizer * _Nonnull tap) {
        zy_action(tap, self);
    };
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)zy_addLongPressAction:(void (^)(UILongPressGestureRecognizer *, UIView *))zy_action
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = UILongPressGestureRecognizer.alloc.init;
    longPress.zy_block = ^(UILongPressGestureRecognizer * _Nonnull longPress) {
        if (longPress.state == UIGestureRecognizerStateBegan) {
            zy_action(longPress, self);
        }
    };
    [self addGestureRecognizer:longPress];
}

@end


@implementation UIView (zy_Snapshot)

- (UIImage *)zy_snapshotImage
{
    UIImage *image = nil;
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    } else{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

- (NSData *)zy_snapshotPDF
{
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}


- (UIViewController *)zy_parentVC
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

@end

