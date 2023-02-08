//
//  ZYGradientLabel.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#if __has_include(<ZYUIKit/ZYUIKit.h>)
#import <ZYUIKit/ZYGradientView.h>
#else
#import "ZYGradientView.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ZYGradientLabel : ZYGradientView
/// label
@property (nonatomic, strong, readonly) UILabel *label;
/// 设置label.text
@property (nonatomic, copy) NSString *text;
/// 设置label.attributedText
@property(nonatomic, copy)   NSAttributedString *attributedText;
/// 设置label.font
@property (nonatomic, strong) UIFont *font;
/// 设置label.textColor
@property (nonatomic, strong) UIColor *textColor;
/// 设置label.textAlignment
@property(nonatomic, assign) NSTextAlignment textAlignment;
/// 设置label.numberOfLines
@property(nonatomic) NSInteger numberOfLines;
/// 调整文本内边距
@property (nonatomic, assign) UIEdgeInsets textContainerInset;
@end

NS_ASSUME_NONNULL_END

