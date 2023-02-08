//
//  UITapGestureRecognizer+ZYExtersion.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITapGestureRecognizer (ZYExtersion)

///  tap手势回调
@property (nonatomic, copy) void (^zy_block) (UITapGestureRecognizer *);

@end

NS_ASSUME_NONNULL_END

