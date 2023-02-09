//
//  UILabel+ZYCommonUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UILabel+ZYCommonUI.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import <ZYUIKit/NSAttributedString+ZYUI.h>
#import "ZYHelper.h"
#import <CoreText/CoreText.h>
#import "UITapGestureRecognizer+ZYExtersion.h"
#import "UILongPressGestureRecognizer+ZYExtersion.h"

@interface UILabel (ZYPrivate)

- (void)zy_drawRect:(CGRect)rect
               image:(UIImage *)image;

@end

@implementation UILabel (ZYPrivate)

- (void)zy_drawRect:(CGRect)rect
               image:(UIImage *)image
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextRestoreGState(context);
}

@end

@interface ZYUILabelCommonUIWrapper : NSObject
@property (nonatomic, assign) ZYUILabelAccessoryType accessoryType;
@property (nonatomic, assign) ZYUILabelAccessoryPosition accessoryPosition;
@property (nonatomic, assign) CGFloat accessoryPadding;
@property (nonatomic, assign) CGFloat baselineOffset;
@property (nonatomic, assign) UIEdgeInsets textInset;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) id<AspectToken> aspect;
@property (nonatomic, assign) CGSize accessorySize;
@end

@implementation ZYUILabelCommonUIWrapper

- (instancetype)initWithTarget:(UILabel *)target
{
    self = [super init];
    if (self) {
        self.label = target;
        self.accessoryType = ZYUILabelAccessoryTypeNone;
        self.accessoryPosition = ZYUILabelAccessoryPositionTail;
        self.accessoryPadding = 5.0f;
        self.baselineOffset = 0.0f;
        self.textInset = UIEdgeInsetsZero;
        self.accessorySize = CGSizeMake(6, 6);
        
        [self.label aspect_hookSelector:@selector(drawTextInRect:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, CGRect rect) {
            if (self == nil) {return ;}
            NSInvocation *invocation = aspectInfo.originalInvocation;
            UIEdgeInsets textInset = self.label.zy_textInset;
            CGRect newRect = UIEdgeInsetsInsetRect(rect, textInset);
            [invocation setArgument:&newRect atIndex:2];
            /// call super
            [invocation invoke];
        } error:nil];

        [self.label aspect_hookSelector:@selector(textRectForBounds:limitedToNumberOfLines:) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo, CGRect bounds, NSInteger numberOfLines) {
            if (self == nil) {return ;}
            NSInvocation *invocation = aspectInfo.originalInvocation;
            UIEdgeInsets textInset = self.label.zy_textInset;
            CGRect rect = UIEdgeInsetsInsetRect(bounds, textInset);
            [invocation setArgument:&rect atIndex:2];
            [invocation setArgument:&numberOfLines atIndex:3];
            /// call super
            [invocation invoke];

            CGRect newRect;
            /// get returnValue
            [invocation getReturnValue:&newRect];

            newRect.origin.x -= textInset.left;
            newRect.origin.y -= textInset.top;
            newRect.size.width += textInset.left + textInset.right;
            newRect.size.height += textInset.top + textInset.bottom;

            /// set returnValue
            [invocation setReturnValue:&newRect];
        } error:nil];

        [self.label aspect_hookSelector:@selector(drawRect:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, CGRect rect) {
            if (self == nil) {return ;}
            if (self.accessoryPosition == ZYUILabelAccessoryPositionFirstLineTail) {
                CGSize imageSize = self.accessorySize;
                CGFloat lineHeight = self.label.font.lineHeight;
                
                [self.label zy_drawRect:CGRectMake(rect.size.width - imageSize.width, (lineHeight / 2) - (imageSize.height / 2) - self.baselineOffset, imageSize.width, imageSize.height) image:[ZYHelper imageNamed:@"xinghao"]];
            } else if (self.accessoryPosition == ZYUILabelAccessoryPositionCenterTail) {
                CGSize imageSize = self.accessorySize;
                
                [self.label zy_drawRect:CGRectMake(rect.size.width - imageSize.width, (rect.size.height / 2) - (imageSize.height / 2) - self.baselineOffset, imageSize.width, imageSize.height) image:[ZYHelper imageNamed:@"xinghao"]];
            }
        } error:nil];
    }
    return self;
}

- (void)makeAccessory
{
    if (self.accessoryType != ZYUILabelAccessoryTypeNone) {
        if (!self.aspect) {
            id<AspectToken> aspect = [self.label aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, NSString *text) {
                if (self == nil) {return ;}
                if (self.accessoryType == ZYUILabelAccessoryTypeNone) {return;}
                [self zy_setText:text];
            } error:nil];
            self.aspect = aspect;
        }
    }
    [self zy_setText:self.label.text];
}

- (void)zy_setText:(NSString *)text
{
    if (text) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        
        /// 1. 必填项 * 样式
        if (self.accessoryType == ZYUILabelAccessoryTypeRequired) {
            if (self.accessoryPosition == ZYUILabelAccessoryPositionTail) {

                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = [ZYHelper imageNamed:@"xinghao"];
                /// 获取顶边距离 使其居中
                CGFloat paddingTop = self.label.font.lineHeight - self.label.font.pointSize;
                attachment.bounds = CGRectMake(0, paddingTop, attachment.image.size.width, attachment.image.size.height);
                NSMutableAttributedString *attachmentString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
                if (self.accessoryPadding > 0) {
                    [attachmentString insertAttributedString:[NSAttributedString zy_attributedStringWithFixedSpace:self.accessoryPadding] atIndex:0];
                }

                [attributedString appendAttributedString:attachmentString];
            } else if (self.accessoryPosition == ZYUILabelAccessoryPositionFirstLineTail || self.accessoryPosition == ZYUILabelAccessoryPositionCenterTail) {
                self.label.zy_textInset = UIEdgeInsetsMake(0, 0, 0, self.accessoryPadding + self.accessorySize.width);
            }
        }
        self.label.attributedText = attributedString.copy;
    }
}

- (void)setAccessoryType:(ZYUILabelAccessoryType)accessoryType
{
    if (_accessoryType != accessoryType) {
        _accessoryType = accessoryType;
        [self makeAccessory];
    }
}

- (void)setAccessoryPosition:(ZYUILabelAccessoryPosition)accessoryPosition
{
    if (_accessoryPosition != accessoryPosition) {
        _accessoryPosition = accessoryPosition;
        [self makeAccessory];
    }
}

- (void)setAccessoryPadding:(CGFloat)accessoryPadding
{
    if (_accessoryPadding != accessoryPadding) {
        _accessoryPadding = accessoryPadding;
        [self makeAccessory];
    }
}

- (void)setBaselineOffset:(CGFloat)baselineOffset
{
    if (_baselineOffset != baselineOffset) {
        _baselineOffset = baselineOffset;
        [self makeAccessory];
    }
}

@end

static const void *kZYUILabelCommonUIWrapperkey = &kZYUILabelCommonUIWrapperkey;

@implementation UILabel (ZYCommonUI)

- (void)setZy_accessoryType:(ZYUILabelAccessoryType)zy_accessoryType
{
    [self zy_commonUIWrapper].accessoryType = zy_accessoryType;
}

- (ZYUILabelAccessoryType)zy_accessoryType
{
    return [self zy_commonUIWrapper].accessoryType;
}

- (void)setZy_accessoryPosition:(ZYUILabelAccessoryPosition)zy_accessoryPosition
{
    [self zy_commonUIWrapper].accessoryPosition = zy_accessoryPosition;
}

- (ZYUILabelAccessoryPosition)zy_accessoryPosition
{
    return [self zy_commonUIWrapper].accessoryPosition;
}

- (void)setZy_accessoryPadding:(CGFloat)zy_accessoryPadding
{
    [self zy_commonUIWrapper].accessoryPadding = zy_accessoryPadding;
}

- (CGFloat)zy_accessoryPadding
{
    return [self zy_commonUIWrapper].accessoryPadding;
}

- (void)setZy_baselineOffset:(CGFloat)zy_baselineOffset
{
    [self zy_commonUIWrapper].baselineOffset = zy_baselineOffset;
}

- (CGFloat)zy_baselineOffset
{
    return [self zy_commonUIWrapper].baselineOffset;
}

- (void)setZy_textInset:(UIEdgeInsets)zy_textInset
{
    [self zy_commonUIWrapper].textInset = zy_textInset;
}

- (UIEdgeInsets)zy_textInset
{
    return [self zy_commonUIWrapper].textInset;
}

- (ZYUILabelCommonUIWrapper *)zy_commonUIWrapper
{
    ZYUILabelCommonUIWrapper *wrapper = objc_getAssociatedObject(self, &kZYUILabelCommonUIWrapperkey);
    if (wrapper == nil) {
        wrapper = [[ZYUILabelCommonUIWrapper alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kZYUILabelCommonUIWrapperkey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrapper;
}

+ (CGFloat)zy_getTextHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font{
    CGSize newSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return newSize.height;
}
+ (CGFloat)zy_getTextHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize{
    return [UILabel zy_getTextHeightWithText:text width:width font:[UIFont systemFontOfSize:fontSize]];
}

- (void)zy_addTapAction:(void (^)(UITapGestureRecognizer *, UILabel *))zy_action
{
    [self zy_addMoreTaps:1 zy_action:^(UITapGestureRecognizer *zy_tap, UILabel *zy_label) {
        zy_action(zy_tap,zy_label);
    }];
}

- (void)zy_addMoreTaps:(NSInteger)moreCount zy_action:(void (^)(UITapGestureRecognizer *, UILabel *))zy_action
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = UITapGestureRecognizer.alloc.init;
    [tapGestureRecognizer setNumberOfTapsRequired:moreCount];
    tapGestureRecognizer.zy_block = ^(UITapGestureRecognizer * _Nonnull tap) {
        zy_action(tap, self);
    };
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)zy_addLongPressAction:(void (^)(UILongPressGestureRecognizer *, UILabel *))zy_action
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


+ (UILabel *)zy_labelWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text superView:(UIView *)superView {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.text = text != nil ? text : @"";
    [superView addSubview:label];
    return label;
}

@end

