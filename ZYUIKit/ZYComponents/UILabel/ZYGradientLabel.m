//
//  ZYGradientLabel.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYGradientLabel.h"

@interface ZYGradientLabel ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSLayoutConstraint *leadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *trailingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;
@end

@implementation ZYGradientLabel

//View初始化
#pragma mark - view init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:self.label];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.leadingConstraint = [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0];
        self.leadingConstraint.active = YES;

        self.trailingConstraint = [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0];
        self.trailingConstraint.active = YES;
        
        self.topConstraint = [self.label.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
        self.topConstraint.active = YES;
        
        self.bottomConstraint = [self.label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0];
        self.bottomConstraint.active = YES;
        
    }
    return self;
}

//View的配置、布局设置
#pragma mark - view config


//私有方法
#pragma mark - private method

//View的生命周期
#pragma mark - view life

//更新View的接口
#pragma mark - update view

//处理View的事件
#pragma mark - handle view event

//发送View的事件
#pragma mark - send view event

//公有方法
#pragma mark - public method

//Setters方法
#pragma mark - setters

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    _textContainerInset = textContainerInset;
    self.leadingConstraint.constant = textContainerInset.left;
    self.trailingConstraint.constant = -textContainerInset.right;
    self.topConstraint.constant = textContainerInset.top;
    self.bottomConstraint.constant = -textContainerInset.bottom;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.label.text = text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    self.label.attributedText = attributedText;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.label.font = font;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.label.textColor = textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.label.textAlignment = textAlignment;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    self.label.numberOfLines = numberOfLines;
}

//Getters方法
#pragma mark - getters

- (UILabel *)label
{
    if (_label == nil) {
        _label = ({
            UILabel *label = [UILabel new];
            label.textColor = [UIColor blackColor];
            label;
        });
    }
    return _label;
}

@end

