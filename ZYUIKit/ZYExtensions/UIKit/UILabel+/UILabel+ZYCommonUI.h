//
//  UILabel+ZYCommonUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

/// 附件类型
typedef NS_ENUM(NSUInteger, ZYUILabelAccessoryType) {
    /// 默认 - 没有
    ZYUILabelAccessoryTypeNone,
    /// 用于必填项 会在文本末加上 * 号显示
    ZYUILabelAccessoryTypeRequired
};

/// 附件显示位置
typedef NS_ENUM(NSUInteger, ZYUILabelAccessoryPosition) {
    /// 默认 - 显示在文本末端
    ZYUILabelAccessoryPositionTail,
    /// 显示在文本的第一行末端（基准线是文本的第一行中心点）
    ZYUILabelAccessoryPositionFirstLineTail,
    /// 显示在文本垂直方向的中心点末端（基准线是文本总内容垂直方向的中心点）
    ZYUILabelAccessoryPositionCenterTail,
};

@interface UILabel (ZYCommonUI)
/// 附件类型 默认 = JYBUILabelAccessoryTypeNone （只支持设置`text`的属性触发；`attributedText` 不支持）
@property (nonatomic, assign) ZYUILabelAccessoryType zy_accessoryType;
/// 附件显示位置 默认 = JYBUILabelAccessoryPositionTail
@property (nonatomic, assign) ZYUILabelAccessoryPosition zy_accessoryPosition;
/// 附件距离左右侧内容的间距 默认 = 5；
@property (nonatomic, assign) CGFloat zy_accessoryPadding;
/// 附件相对基线的垂直偏移 默认 = 0；（当 offset > 0 时，附件会向上偏移）
@property (nonatomic, assign) CGFloat zy_baselineOffset;
/// 控制文本边界间距；默认 = UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets zy_textInset;

+ (CGFloat)zy_getTextHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;
+ (CGFloat)zy_getTextHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;

/// 单击事件
/// @param zy_action 回调
- (void)zy_addTapAction:(void (^) (UITapGestureRecognizer *zy_tap, UILabel *zy_label))zy_action;

/// 多击事件
/// @param moreCount 点击次数
/// @param zy_action 回调
- (void)zy_addMoreTaps:(NSInteger)moreCount
             zy_action:(void (^) (UITapGestureRecognizer *zy_tap, UILabel *zy_label))zy_action;

/// 长按事件
/// @param zy_action 回调
- (void)zy_addLongPressAction:(void (^) (UILongPressGestureRecognizer *zy_longPress, UILabel *zy_label))zy_action;

// 快速创建
+ (UILabel *)zy_labelWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text superView:(UIView *)superView;
@end

