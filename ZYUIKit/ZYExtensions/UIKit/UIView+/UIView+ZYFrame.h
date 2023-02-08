//
//  UIView+ZYFrame.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//
//  对 view.frame 操作的简便封装，注意 view 与 view 之间互相计算时，需要保证处于同一个坐标系内。

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZYFrame)

/// 等价于 CGRectGetMinY(frame)
@property(nonatomic, assign) CGFloat zy_top;

/// 等价于 CGRectGetMinX(frame)
@property(nonatomic, assign) CGFloat zy_left;

/// 等价于 CGRectGetMaxY(frame)
@property(nonatomic, assign) CGFloat zy_bottom;

/// 等价于 CGRectGetMaxX(frame)
@property(nonatomic, assign) CGFloat zy_right;

/// 等价于 CGRectGetWidth(frame)
@property(nonatomic, assign) CGFloat zy_width;

/// 等价于 CGRectGetHeight(frame)
@property(nonatomic, assign) CGFloat zy_height;

/// 等价于 CGRectGetMidX(self.frame)
@property(nonatomic, assign) CGFloat zy_centerX;

/// 等价于 CGRectGetMidY(frame)
@property(nonatomic, assign) CGFloat zy_centerY;

/// 等价于 self.frame.size
@property(nonatomic, assign) CGSize zy_size;

/// 保持其他三个边缘的位置不变的情况下，将顶边缘拓展到某个指定的位置，注意高度会跟随变化。
@property(nonatomic, assign) CGFloat zy_extendToTop;

/// 保持其他三个边缘的位置不变的情况下，将左边缘拓展到某个指定的位置，注意宽度会跟随变化。
@property(nonatomic, assign) CGFloat zy_extendToLeft;

/// 保持其他三个边缘的位置不变的情况下，将底边缘拓展到某个指定的位置，注意高度会跟随变化。
@property(nonatomic, assign) CGFloat zy_extendToBottom;

/// 保持其他三个边缘的位置不变的情况下，将右边缘拓展到某个指定的位置，注意宽度会跟随变化。
@property(nonatomic, assign) CGFloat zy_extendToRight;

///倒角
@property (nonatomic, assign) IBInspectable   double  xCornerRadius;
///边框颜色
@property (nonatomic, strong) IBInspectable   UIColor *borderColor;
///边框宽度
@property (nonatomic, assign) IBInspectable   double  borderWidth;

/// 通过xib加载view
+ (instancetype)zy_loadFromNib;

@end

NS_ASSUME_NONNULL_END

