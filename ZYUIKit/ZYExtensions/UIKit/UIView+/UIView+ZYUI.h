//
//  UIView+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYUI)

///------------
/// 约束布局拉伸解决方案
///------------

/// 设置水平方向布局抗拉伸、压缩等级为最高
- (void)zy_horizontalLayoutRequired;

/// 设置垂直方向布局抗拉伸、压缩等级为最高
- (void)zy_verticalLayoutRequired;

///------------
/// 设置圆角相关
///------------

/// 圆角阴影
- (void)zy_addShadowWithShadowColor:(UIColor *)color radius:(CGFloat)radius andAlpha:(CGFloat)alpha;

/// 设置圆角
/// @param radius 圆角半径
/// @param color 外边框颜色
/// @param width 外边框宽度
- (void)zy_cornerRadius:(CGFloat)radius
             borderColor:(UIColor *)color
             borderWidth:(CGFloat)width;

///------------
/// 手势相关
///------------

/// 单击事件
/// @param zy_action 回调
- (void)zy_addTapAction:(void (^) (UITapGestureRecognizer *zy_tap, UIView *zy_view))zy_action;

/// 多击事件
/// @param moreCount 点击次数
/// @param zy_action 回调
- (void)zy_addMoreTaps:(NSInteger)moreCount
             zy_action:(void (^) (UITapGestureRecognizer *zy_tap, UIView *zy_view))zy_action;

/// 长按事件
/// @param zy_action 回调
- (void)zy_addLongPressAction:(void (^) (UILongPressGestureRecognizer *zy_longPress, UIView *zy_view))zy_action;

@end

///------------
/// 方便地将某个 UIView 截图并转成一个 UIImage，注意如果这个 UIView 本身做了 transform，也不会在截图上反映出来，截图始终都是原始 UIView 的截图。
///------------
@interface UIView (zy_Snapshot)

/// 创建一个快照UIImage
- (UIImage *)zy_snapshotImage;

/// 创建一个快照PDF
- (NSData *)zy_snapshotPDF;
/// 获取到当前View的ViewController
- (UIViewController *)zy_parentVC;
@end
