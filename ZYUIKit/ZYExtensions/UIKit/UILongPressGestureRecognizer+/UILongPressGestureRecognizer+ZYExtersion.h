//
//  UILongPressGestureRecognizer+ZYExtersion.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILongPressGestureRecognizer (ZYExtersion)

/// 长按手势回调
@property (nonatomic, copy) void (^zy_block) (UILongPressGestureRecognizer *);

@end

NS_ASSUME_NONNULL_END
