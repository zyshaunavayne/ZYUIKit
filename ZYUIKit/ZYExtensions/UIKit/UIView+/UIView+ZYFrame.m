//
//  UIView+ZYFrame.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIView+ZYFrame.h"

@implementation UIView (ZYFrame)

- (CGFloat)zy_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setZy_top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)zy_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setZy_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)zy_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setZy_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)zy_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setZy_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)zy_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setZy_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)zy_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setZy_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)zy_centerX
{
    return CGRectGetMidX(self.frame);
}

- (void)setZy_centerX:(CGFloat)zy_centerX
{
    self.center = CGPointMake(zy_centerX, self.center.y);
}

- (CGFloat)zy_centerY
{
    return CGRectGetMidY(self.frame);
}

- (void)setZy_centerY:(CGFloat)zy_centerY
{
    self.center = CGPointMake(self.center.x, zy_centerY);
}

- (CGSize)zy_size
{
    return self.frame.size;
}

- (void)setZy_size:(CGSize)zy_size
{
    CGRect frame = self.frame;
    frame.size = zy_size;
    self.frame = frame;
}

- (CGFloat)zy_extendToTop
{
    return self.zy_top;
}

- (void)setZy_extendToTop:(CGFloat)zy_extendToTop
{
    self.zy_height = self.zy_bottom - zy_extendToTop;
    self.zy_top = zy_extendToTop;
}

- (CGFloat)zy_extendToLeft
{
    return self.zy_left;
}

- (void)setZy_extendToLeft:(CGFloat)zy_extendToLeft
{
    self.zy_width = self.zy_right - zy_extendToLeft;
    self.zy_left = zy_extendToLeft;
}

- (CGFloat)zy_extendToBottom
{
    return self.zy_bottom;
}

- (void)setZy_extendToBottom:(CGFloat)zy_extendToBottom
{
    self.zy_height = zy_extendToBottom - self.zy_top;
    self.zy_bottom = zy_extendToBottom;
}

- (CGFloat)zy_extendToRight
{
    return self.zy_right;
}

- (void)setZy_extendToRight:(CGFloat)zy_extendToRight
{
    self.zy_width = zy_extendToRight - self.zy_left;
    self.zy_right = zy_extendToRight;
}


#pragma mark - Xib要显示的圆角，边框颜色这些
- (void)setXCornerRadius:(double)xCornerRadius {
    self.layer.cornerRadius = xCornerRadius;
    self.layer.masksToBounds = YES;
}

- (double)xCornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor  {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(double)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (double)borderWidth {
    return self.layer.borderWidth;
}

+ (instancetype)zy_loadFromNib{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
@end
