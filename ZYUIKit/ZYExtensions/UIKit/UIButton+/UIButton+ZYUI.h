//
//  UIButton+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

/// 布局样式
typedef NS_ENUM(NSUInteger, ZYUIButtonContentLayoutStyle) {
    /// 内容居中-图左文右
    ZYUIButtonContentLayoutStyleNormal = 0,
    /// 内容居中-图右文左
    ZYUIButtonContentLayoutStyleCenterImageRight,
    /// 内容居中-图上文下
    ZYUIButtonContentLayoutStyleCenterImageTop,
    /// 内容居中-图下文上
    ZYUIButtonContentLayoutStyleCenterImageBottom,
    /// 内容居左-图左文右
    ZYUIButtonContentLayoutStyleLeftImageLeft,
    /// 内容居左-图右文左
    ZYUIButtonContentLayoutStyleLeftImageRight,
    /// 内容居右-图左文右
    ZYUIButtonContentLayoutStyleRightImageLeft,
    /// 内容居右-图右文左
    ZYUIButtonContentLayoutStyleRightImageRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZYUI)
/// button 的布局样式，文字、字体大小、图片等参数一定要在其之前设置（如果设置的title过长，会造成视觉上看起来的左右间距不等，但其实打开debugView层级是均分了间距的，是因为IOS的根据字体截断的方式造成多余的空隙不能显示一个字只能留空白）
@property(nonatomic, assign) ZYUIButtonContentLayoutStyle zy_contentLayoutStyle;
/// 图片和文本间距 默认 = 0
@property (nonatomic, assign) CGFloat zy_padding;
/// 整体内容距边-边距 默认 = 0 （内容居中此属性无效）；跟`zy_contentLayoutStyle`设置的内容整体偏左或骗右单向方位值有关
@property (nonatomic, assign) CGFloat zy_paddingInset;
/// 响应区域需要改变的大小 默认为（0，0，0，0）, 负值表示往外扩大，正值表示往内缩小；（注意：扩大范围最大只能响应“父视图（superview）以内”的区域，要响应“父视图以外”的区域需要在对应视图里重写`hitTest:withEvent:`拦截）
@property (nonatomic, assign) UIEdgeInsets zy_touchEdgeInsets;

/// 设置button的布局样式
/// @param style 布局样式
/// @param padding 图片和文本间距
- (void)zy_contentLayoutStyle:(ZYUIButtonContentLayoutStyle)style
                       padding:(CGFloat)padding;

/**
 利用 runtime机制给 button新增属性和方法替换掉原有的点击事件 UIControlEventTouchUpInside
 */
@property (nonatomic, copy) void (^zy_btnClickblock) (UIButton *Btn);


@end

NS_ASSUME_NONNULL_END
