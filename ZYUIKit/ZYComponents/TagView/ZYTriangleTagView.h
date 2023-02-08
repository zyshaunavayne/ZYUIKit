//
//  ZYTriangleTagView.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
///经营帮列表右上角的状态角标[推荐尺寸50*50]
@interface ZYTriangleTagView : UIView
///快速初始化
+ (instancetype)triangleTagText:(NSString *)text textColor:(UIColor *)textColor triangleColor:(UIColor *)triangleColor;
///文本内容，文字最多7个字符（内部处理:4个字符显示一行，超过4个显示两行）
@property (strong, nonatomic) IBInspectable NSString *text;
///文本颜色，默认为白色
@property (strong, nonatomic) IBInspectable UIColor *textColor;
///文本字体【默认系统10号字体，字符为7个时候为9默认号字体，不建议自定义，当为nil时内部触发默认字体】
@property (strong, nonatomic, nullable) IBInspectable UIFont *textFont;
///三角形颜色，默认为黑色
@property (strong, nonatomic) IBInspectable UIColor *triangleColor;

@end

NS_ASSUME_NONNULL_END
