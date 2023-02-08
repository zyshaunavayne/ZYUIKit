//
//  ZYTextView.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYTextView : UITextView <UITextViewDelegate>

/// 占位符
@property (nonatomic, copy) NSString *zy_placeholder;

/// 占位符颜色
@property (nonatomic, strong) UIColor *zy_placeholderColor;

/// 在textViewDidChange代理中调用此方法，可生效placeHolder效果
/// @param textView 需要使用的textView
- (void)zy_isPlaceholderShow:(ZYTextView *)textView;

@end

NS_ASSUME_NONNULL_END
