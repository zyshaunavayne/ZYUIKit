//
//  UIStackView+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

@interface UIStackView (ZYUI)
/// 分割线颜色
@property (nonatomic, strong) UIColor *zy_separatorColor;
/// 默认长度和厚度与 UIStackView.spacing 和 UIStackView.size 有关（UIEdgeInsetsMake(0, 0, 0, 0)； 可以定制化调整
@property (nonatomic) UIEdgeInsets zy_separatorInset;

/// 设置自定义间距（与系统方法 -setCustomSpacing:afterView: 功能一样，但是它兼容 iOS11.0 以下的版本）
/// @param spacing 间距
/// @param arrangedSubview 自定义间距的子视图（设置的是当前子视图与相邻的"下一个子视图"的间距；当前是最后一个子视图则不生效）
- (void)zy_setCustomSpacing:(CGFloat)spacing
                   afterView:(UIView *)arrangedSubview;

/// 设置自定义间距和分割线颜色
/// @param spacing 间距
/// @param arrangedSubview 自定义间距的子视图（设置的是当前子视图与相邻的"下一个子视图"的间距；当前是最后一个子视图则不生效）
/// @param separatorColor 分割线颜色
- (void)zy_setCustomSpacing:(CGFloat)spacing
                   afterView:(UIView *)arrangedSubview
              separatorColor:(UIColor *)separatorColor;

/// 返回子视图的自定义间距（与系统方法 -customSpacingAfterView: 功能一样，但是它兼容 iOS11.0 以下的版本
/// @param arrangedSubview 子视图
- (CGFloat)zy_customSpacingAfterView:(UIView *)arrangedSubview;

/// 返回子视图自定义分隔线颜色
/// @param arrangedSubview 子视图
- (UIColor *)zy_customSeparatorColorAfterView:(UIView *)arrangedSubview;

@end
