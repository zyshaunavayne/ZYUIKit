//
//  UIStackView+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIStackView+ZYUI.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>

@interface ZYUIStackViewWrapper : NSObject;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic) UIEdgeInsets separatorInset;
@property (nonatomic, weak) UIStackView *stackView;
@property (nonatomic, copy) NSArray *separatorViews;
@property (nonatomic, strong) NSMapTable<UIView *, NSNumber *> *customSpacings;
@property (nonatomic, strong) NSMapTable<UIView *, UIColor *> *customSeparatorColors;
@end

@implementation ZYUIStackViewWrapper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)makeSeparators
{
    if (!self.stackView || !self.separatorColor || ![self.stackView isKindOfClass:UIStackView.class]) {
        return;
    }
    
    [self.separatorViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    self.separatorViews = nil;
    
    NSMutableArray *separatorViews = @[].mutableCopy;
    
    __block UIView *previousView = nil;
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (previousView == nil && !obj.hidden) {
            previousView = obj;
            return;
        }
        
        if (obj.hidden) {
            return;
        }
        
        UIView *separatorView = [UIView new];
        separatorView.backgroundColor = [self.stackView zy_customSeparatorColorAfterView:previousView] ?: self.separatorColor;
        
        CGFloat spacing = [self.stackView zy_customSpacingAfterView:previousView];
        if (spacing == FLT_MAX) {
            spacing = self.stackView.spacing;
        }
        
        if (self.stackView.axis == UILayoutConstraintAxisHorizontal) {
            separatorView.frame = CGRectMake(CGRectGetMaxX(previousView.frame) + self.separatorInset.left, CGRectGetMinY(previousView.frame) + self.separatorInset.top, spacing - self.separatorInset.left - self.separatorInset.right, CGRectGetHeight(self.stackView.frame) - self.separatorInset.top - self.separatorInset.bottom);
        } else {
            separatorView.frame = CGRectMake(CGRectGetMinX(previousView.frame) + self.separatorInset.left, CGRectGetMaxY(previousView.frame) + self.separatorInset.top, CGRectGetWidth(self.stackView.frame) - self.separatorInset.left - self.separatorInset.right, spacing - self.separatorInset.top - self.separatorInset.bottom);
        }
        
        [self.stackView addSubview:separatorView];
        [separatorViews addObject:separatorView];
        previousView = obj;
    } ];
    
    self.separatorViews = separatorViews.copy;
}

- (void)updateConstraints
{
    __block NSMutableArray<NSLayoutConstraint *> *firstContstraints = nil;

    [_customSpacings.keyEnumerator.allObjects enumerateObjectsUsingBlock:^(UIView *view, NSUInteger _, BOOL *stop) {
        if (![view.superview isEqual:self.stackView]) {
            // view is removed from self
            [self.customSpacings removeObjectForKey:view];
            return; // continue
        }
        if (firstContstraints == nil) {
            NSLayoutAttribute firstAttribute = self.stackView.axis == UILayoutConstraintAxisVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeading;
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstAttribute == %ld", firstAttribute];
            firstContstraints = [[self.stackView.constraints filteredArrayUsingPredicate:predicate] mutableCopy];
        }
        if (firstContstraints.count == 0) {
            *stop = YES; return; // break
        }
        
        NSLayoutAttribute secondAttribute = self.stackView.axis == UILayoutConstraintAxisVertical ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing;
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF.secondItem == %@ AND SELF.secondAttribute == %ld", view, secondAttribute];
        NSArray<NSLayoutConstraint *> *matchedConstraints = [firstContstraints filteredArrayUsingPredicate:predicate2];
        if (matchedConstraints.count > 0) {
            matchedConstraints.firstObject.constant = [self.stackView zy_customSpacingAfterView:view];
            [firstContstraints removeObjectsInArray:matchedConstraints];
        }
    }];
}

- (void)setStackView:(UIStackView *)stackView
{
    _stackView = stackView;
    if (stackView) {
    
        [stackView aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            if (self == nil) {return ;}
            [self makeSeparators];
        }  error:nil];
        
        [stackView aspect_hookSelector:@selector(updateConstraints) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            if (self == nil) {return ;}
            [self updateConstraints];
        }  error:nil];
    }
}

- (NSNumber *)customSpacingAfterView:(UIView *)arrangedSubview
{
    return [_customSpacings objectForKey:arrangedSubview];
}

- (UIColor *)customSeparatorColorAfterView:(UIView *)arrangedSubview
{
    return [_customSeparatorColors objectForKey:arrangedSubview];
}

- (NSMapTable<UIView *,NSNumber *> *)customSpacings
{
    if (_customSpacings == nil) {
        _customSpacings = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    }
    return _customSpacings;
}

- (NSMapTable<UIView *,UIColor *> *)customSeparatorColors
{
    if (_customSeparatorColors == nil) {
        _customSeparatorColors = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
    }
    return _customSeparatorColors;
}

@end

static const void *kZYUIStackViewWrapperkey = &kZYUIStackViewWrapperkey;

@implementation UIStackView (ZYUI)

- (void)setzy_separatorColor:(UIColor *)zy_separatorColor
{
    [self zy_stackViewWrapper].separatorColor = zy_separatorColor;
    [[self zy_stackViewWrapper] makeSeparators];
}

- (void)setzy_separatorInset:(UIEdgeInsets)zy_separatorInset
{
    [self zy_stackViewWrapper].separatorInset = zy_separatorInset;
    [[self zy_stackViewWrapper] makeSeparators];
}

- (UIColor *)zy_separatorColor
{
    return [self zy_stackViewWrapper].separatorColor;
}

- (UIEdgeInsets)zy_separatorInset
{
    return [self zy_stackViewWrapper].separatorInset;
}

- (void)zy_setCustomSpacing:(CGFloat)spacing afterView:(UIView *)arrangedSubview
{
    [self zy_setCustomSpacing:spacing afterView:arrangedSubview separatorColor:nil];
}

- (void)zy_setCustomSpacing:(CGFloat)spacing
                   afterView:(UIView *)arrangedSubview
              separatorColor:(UIColor *)separatorColor
{
    if (separatorColor && [self.arrangedSubviews containsObject:arrangedSubview]) {
        [[self zy_stackViewWrapper].customSeparatorColors setObject:separatorColor forKey:arrangedSubview];
    }
    if (@available(iOS 11.0, *)) {
        [self setCustomSpacing:spacing afterView:arrangedSubview];
        return;
    }
    if (![self.arrangedSubviews containsObject:arrangedSubview]) { return;}
    [[self zy_stackViewWrapper].customSpacings setObject:@(spacing) forKey:arrangedSubview];
    [self setNeedsUpdateConstraints];
}

- (CGFloat)zy_customSpacingAfterView:(UIView *)arrangedSubview
{
    if (@available(iOS 11.0, *)) {
        return [self customSpacingAfterView:arrangedSubview];
    } else {
        NSNumber *value = [[self zy_stackViewWrapper] customSpacingAfterView:arrangedSubview];
        if (value) {
            return [value floatValue];
        }
    }
    return FLT_MAX;
}

- (UIColor *)zy_customSeparatorColorAfterView:(UIView *)arrangedSubview
{
    return [[self zy_stackViewWrapper] customSeparatorColorAfterView:arrangedSubview];
}

- (ZYUIStackViewWrapper *)zy_stackViewWrapper
{
    ZYUIStackViewWrapper *wrapper = objc_getAssociatedObject(self, &kZYUIStackViewWrapperkey);
    if (wrapper == nil) {
        wrapper = ZYUIStackViewWrapper.new;
        wrapper.stackView = self;
        objc_setAssociatedObject(self, &kZYUIStackViewWrapperkey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrapper;
}

@end


