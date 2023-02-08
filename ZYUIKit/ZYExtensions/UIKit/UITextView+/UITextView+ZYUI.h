//
//  UITextView+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZYUI)

/// 限制输入的最大长度限制
@property (nonatomic, assign) NSInteger zy_limitMaxLength;

/// 限制输入的最大长度限制
/// @param maxLength 最大长度
/// @param textViewDidChangeBlock 监听字符变化后回调
- (void)zy_limitMaxLength:(NSInteger)maxLength
         textViewDidChange:(void (^)(NSString *text))textViewDidChangeBlock;

@end
