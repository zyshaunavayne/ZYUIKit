//
//  UIButton+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIButton+ZYUI.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@interface UIButton (ZYPrivate)

- (void)zy_setupButtonLayout;

@end

@implementation UIButton (ZYPrivate)

- (void)zy_setupButtonLayout
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    if (width == 0 || height == 0) { return;}
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    
    CGFloat image_w = self.imageView.frame.size.width;
    CGFloat image_h = self.imageView.frame.size.height;
    
    CGFloat title_w = self.titleLabel.frame.size.width;
    CGFloat title_h = self.titleLabel.frame.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
        image_w = self.imageView.intrinsicContentSize.width;
        image_h = self.imageView.intrinsicContentSize.height;
    }
    
    BOOL updateTitleFrame = NO;
    BOOL updateImageFrame = NO;
    CGFloat title_x = self.titleLabel.frame.origin.x;
    CGFloat title_y = self.titleLabel.frame.origin.y;
    CGFloat title_max_w = title_w;
    CGFloat title_max_h = title_h;
    
    CGFloat image_x = self.imageView.frame.origin.x;
    CGFloat image_y = self.imageView.frame.origin.y;
    CGFloat image_max_w = image_w;
    CGFloat image_max_h = image_h;
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    switch (self.zy_contentLayoutStyle) {
        case ZYUIButtonContentLayoutStyleNormal:{
            if (title_w + self.zy_padding + image_w > width) {
                image_x = 0;
                title_x = image_x + image_w + self.zy_padding;
                title_max_w = width - image_w - self.zy_padding - image_x * 2;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, self.zy_padding, 0, 0);
                imageEdge = UIEdgeInsetsMake(0, 0, 0, self.zy_padding);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ZYUIButtonContentLayoutStyleCenterImageRight:{
            if (title_w + self.zy_padding + image_w > width) {
                title_x = 0;
                title_max_w = width - image_w - self.zy_padding - title_x * 2;
                image_x = width - image_w - title_x;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, -image_w - self.zy_padding, 0, image_w);
                imageEdge = UIEdgeInsetsMake(0, title_w + self.zy_padding, 0, -title_w);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ZYUIButtonContentLayoutStyleCenterImageTop:{
            if (title_w > width) {
                title_x = 0;
                CGFloat topPadding = ((height - (image_h + self.zy_padding + title_h)) / 2);
                title_y = topPadding + image_h + self.zy_padding;
                title_max_w = width - title_x * 2;
                image_y = topPadding;
                image_x = (width / 2) - (image_w / 2);
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.zy_padding, 0);
                imageEdge = UIEdgeInsetsMake(-title_h - self.zy_padding, 0, 0, -title_w);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ZYUIButtonContentLayoutStyleCenterImageBottom:{
            if (title_w > width) {
                title_x = 6;
                CGFloat topPadding = ((height - (image_h + self.zy_padding + title_h)) / 2);
                title_y = topPadding;
                title_max_w = width - title_x * 2;
                image_y = topPadding + title_h + self.zy_padding;
                image_x = (width / 2) - (image_w / 2);
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(-image_h - self.zy_padding, -image_w, 0, 0);
                imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.zy_padding, -title_w);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case ZYUIButtonContentLayoutStyleLeftImageLeft:{
            if (title_w + self.zy_padding + image_w + self.zy_paddingInset > width) {
                image_x = self.zy_paddingInset;
                title_max_w = width - image_w - self.zy_padding - self.zy_paddingInset;
                title_x = image_x + image_w + self.zy_padding;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, self.zy_padding + self.zy_paddingInset, 0, 0);
                imageEdge = UIEdgeInsetsMake(0, self.zy_paddingInset, 0, 0);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case ZYUIButtonContentLayoutStyleLeftImageRight:{
            if (title_w + self.zy_padding + image_w + self.zy_paddingInset > width) {
                title_x = self.zy_paddingInset;
                title_max_w = width - image_w - self.zy_padding - self.zy_paddingInset;
                image_x = title_max_w + title_x + self.zy_padding;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, -image_w + self.zy_paddingInset, 0, 0);
                imageEdge = UIEdgeInsetsMake(0, title_w + self.zy_padding + self.zy_paddingInset, 0, 0);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case ZYUIButtonContentLayoutStyleRightImageLeft:{
            if (title_w + self.zy_padding + image_w + self.zy_paddingInset > width) {
                image_x = 0;
                title_max_w = width - image_w - self.zy_padding - image_x - self.zy_paddingInset;
                title_x = image_x + image_w + self.zy_padding;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                imageEdge = UIEdgeInsetsMake(0, 0, 0, self.zy_padding + self.zy_paddingInset);
                titleEdge = UIEdgeInsetsMake(0, 0, 0, self.zy_paddingInset);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case ZYUIButtonContentLayoutStyleRightImageRight:{
            if (title_w + self.zy_padding + image_w + self.zy_paddingInset > width) {
                title_x = 0;
                title_max_w = width - image_w - self.zy_padding - title_x - self.zy_paddingInset;
                image_x = title_x + title_max_w + self.zy_padding;
                updateTitleFrame = YES;
                updateImageFrame = YES;
            } else {
                titleEdge = UIEdgeInsetsMake(0, -self.frame.size.width / 2, 0, image_w + self.zy_padding + self.zy_paddingInset);
                imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + self.zy_paddingInset);
            }
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        default:break;
    }
    
    if (updateTitleFrame) {
        self.titleLabel.frame = CGRectMake(title_x, title_y, title_max_w, title_max_h);
    }
    if (updateImageFrame) {
        self.imageView.frame = CGRectMake(image_x, image_y, image_max_w, image_max_h);
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
}

@end


@interface ZYUIButtonWrapper : NSObject;
@property (nonatomic, weak) UIButton *button;
@property(nonatomic, assign) ZYUIButtonContentLayoutStyle contentLayoutStyle;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGFloat paddingInset;
@property (nonatomic, assign) UIEdgeInsets touchEdgeInsets;
@property (nonatomic, weak) id<AspectToken> aspect;
@end

@implementation ZYUIButtonWrapper

- (instancetype)initWithTarget:(UIButton *)target
{
    self = [super init];
    if (self) {
        self.button = target;
        
        [self.button aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            if (self == nil) { return;}
            UIButton *button = aspectInfo.instance;
            [button zy_setupButtonLayout];
        } error:nil];
    }
    return self;
}

- (void)setTouchEdgeInsets:(UIEdgeInsets)touchEdgeInsets
{
    _touchEdgeInsets = touchEdgeInsets;
    if (UIEdgeInsetsEqualToEdgeInsets(touchEdgeInsets, UIEdgeInsetsZero)) {
        return;
    }
    if (!self.aspect) {
        id<AspectToken> aspect = [self.button aspect_hookSelector:@selector(pointInside:withEvent:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, CGPoint point, UIEvent *event) {
            if (self == nil) { return;}
            UIButton *button = aspectInfo.instance;
            if (!button.enabled || !button.userInteractionEnabled) { return;}
            BOOL pointInside;

            NSInvocation *invocation = aspectInfo.originalInvocation;
            if (!UIEdgeInsetsEqualToEdgeInsets(self.touchEdgeInsets, UIEdgeInsetsZero)) {
                pointInside = [self pointInside:point withEvent:event];
                [invocation setReturnValue:&pointInside];
                return;
            }

            /// call super
            [invocation invoke];
        } error:nil];
        self.aspect = aspect;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect hitRect = UIEdgeInsetsInsetRect(self.button.bounds, self.touchEdgeInsets);
    return CGRectContainsPoint(hitRect, point);
}

@end

static const void *kZYUIButtonWrapperkey = &kZYUIButtonWrapperkey;

@implementation UIButton (ZYUI)

- (void)setzy_contentLayoutStyle:(ZYUIButtonContentLayoutStyle)zy_contentLayoutStyle
{
    [self zy_buttonWrapper].contentLayoutStyle = zy_contentLayoutStyle;
    [self zy_setupButtonLayout];
    [self setNeedsDisplay];
}

- (ZYUIButtonContentLayoutStyle)zy_contentLayoutStyle
{
    return [self zy_buttonWrapper].contentLayoutStyle;
}

- (void)setzy_padding:(CGFloat)zy_padding
{
    [self zy_buttonWrapper].padding = zy_padding;
    [self zy_setupButtonLayout];
    [self setNeedsDisplay];
}

- (CGFloat)zy_padding
{
    return [self zy_buttonWrapper].padding;
}

- (void)setzy_paddingInset:(CGFloat)zy_paddingInset
{
    [self zy_buttonWrapper].paddingInset = zy_paddingInset;
    [self zy_setupButtonLayout];
    [self setNeedsDisplay];
}

- (CGFloat)zy_paddingInset
{
    return [self zy_buttonWrapper].paddingInset;
}

- (UIEdgeInsets)zy_touchEdgeInsets
{
    return [self zy_buttonWrapper].touchEdgeInsets;
}

- (void)setzy_touchEdgeInsets:(UIEdgeInsets)zy_touchEdgeInsets
{
    [self zy_buttonWrapper].touchEdgeInsets = zy_touchEdgeInsets;
}

- (ZYUIButtonWrapper *)zy_buttonWrapper
{
    ZYUIButtonWrapper *wrapper = objc_getAssociatedObject(self, &kZYUIButtonWrapperkey);
    if (wrapper == nil) {
        wrapper = [[ZYUIButtonWrapper alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kZYUIButtonWrapperkey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrapper;
}

- (void)zy_contentLayoutStyle:(ZYUIButtonContentLayoutStyle)style
                       padding:(CGFloat)padding
{
    [self zy_buttonWrapper].contentLayoutStyle = style;
    [self zy_buttonWrapper].padding = padding;
    [self zy_setupButtonLayout];
    [self setNeedsDisplay];
}

- (void)setzy_btnClickblock:(void (^)(UIButton * _Nonnull))zy_btnClickblock {
    objc_setAssociatedObject(self, @selector(zy_btnClickblock),zy_btnClickblock,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(zy_click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void (^)(UIButton * _Nonnull))zy_btnClickblock {
    return objc_getAssociatedObject(self, @selector(zy_btnClickblock));
}

- (void)zy_click:(UIButton *)btn
{
    if (self.zy_btnClickblock) {
        self.zy_btnClickblock(btn);
    }
}

@end

