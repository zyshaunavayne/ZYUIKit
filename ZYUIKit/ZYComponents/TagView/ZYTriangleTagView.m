//
//  ZYTriangleTagView.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYTriangleTagView.h"

@implementation ZYTriangleTagView {
    UIFont          *__textFont;///字体
    CATextLayer     *__textLayer;///文本图层
    CAShapeLayer    *__shapeLayer;///三角形图层
    CGRect          __lastRect;///记录上一次的布局尺寸信息
}

+ (instancetype)triangleTagText:(NSString *)text textColor:(UIColor *)textColor triangleColor:(UIColor *)triangleColor {
    ZYTriangleTagView *view = [[ZYTriangleTagView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.text = text;
    view.textColor = textColor;
    view.triangleColor = triangleColor;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    } return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    } return self;
}

///初始化
- (void)initialization {
    ///字体
    __textFont = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    ///文本图层
    __textLayer = [CATextLayer layer];
    __textLayer.contentsScale = [UIScreen mainScreen].scale;
    __textLayer.alignmentMode = kCAAlignmentCenter;
    __textLayer.wrapped = YES;
    ///三角形图层
    __shapeLayer = [CAShapeLayer layer];
    ///添加图层
    [self.layer addSublayer:__shapeLayer];
    [self.layer addSublayer:__textLayer];
    ///设置默认属性
    [self setTextColor:UIColor.whiteColor];
    [self setTriangleColor:UIColor.blackColor];
    [self setTriangleColor:[UIColor blackColor]];
    ///去背景
    [self setBackgroundColor:[UIColor clearColor]];
}

///调整布局
- (void)layoutSubviews {
    if (CGRectEqualToRect(self.frame, __lastRect)) {///布局不发生变化，不重新绘制
        return;
    }
    ///绘制三角形
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [path closePath];
    ///三角形图层
    __shapeLayer.path = path.CGPath;
    __shapeLayer.frame = self.bounds;
    ///无文本时不进行任何图层布局操作
    if (!_text || [self filterText].length == 0) {
        return;
    }
    ///需要显示的文字尺寸
    CGSize size = [[self filterText] sizeWithAttributes:[self textAttributes]];
    ///文字宽度为对角线长度
    double w = sqrt(pow(CGRectGetWidth(self.frame), 2.0) * 2.0);
    ///文字高度根据字体计算
    double h = size.height;
    ///文字x轴起点
    double x = (CGRectGetWidth(self.frame) - w ) / 2.0;
    ///文字y轴起点
    double y = ((CGRectGetHeight(self.frame)) -  size.height) / 2.0;
    ///文本图层设置frame
    __textLayer.frame = CGRectMake(x, y, w, h);
    ///已经旋转平移后不再需要操作
    if(__textLayer.transform.m41 == 0 && __textLayer.transform.m41 == 0) {
        ///计算平移量：以文字矩形短边为正方形的对角线的一半，由此偏移后文字底部刚好与对三角形长边对齐
        double t = sqrt(pow(size.height / 2.0, 2.0) * 2.0) / 2.0;
        ///旋转平移文字：正时针旋转45°，然后向三角形直角方向平移至距离三角形直角边1或者2个像素的位置（单行2像素，双行1像素）
        CATransform3D transform = CATransform3DMakeRotation(0.25 * M_PI, 0.0, 0.0, 1.0);
        ///偏移量：距离三角形斜边的距离
        double offset = [self offset];
        ///x轴平移量
        transform.m41 = t + offset;
        ///y轴平移量
        transform.m42 = -t - offset;
        ///文本变形
        __textLayer.transform = transform;
    }
    __lastRect = self.frame;
}

- (void)setText:(NSString *)text {
    _text = text;
    __textLayer.string = [[NSAttributedString alloc] initWithString:[self filterText] attributes:[self textAttributes]];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    __textLayer.string = [[NSAttributedString alloc] initWithString:[self filterText] attributes:[self textAttributes]];
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    if (textFont) {
        __textFont = textFont;
    } else {
        __textFont = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];;
    }
    __textLayer.string = [[NSAttributedString alloc] initWithString:[self filterText] attributes:[self textAttributes]];
}

- (void)setTriangleColor:(UIColor *)triangleColor {
    _triangleColor = triangleColor;
    __shapeLayer.fillColor = triangleColor.CGColor;
}

///显示的文本
- (NSString *)filterText {
    if (_text) {
        NSString *string = [_text stringByReplacingOccurrencesOfString:@" " withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        if (string.length > 7) {
            string = [string substringToIndex:7];
        }
        if (string.length == 7) {
            if (!self.textFont) {///如果外部设置字体，此处字体不做更改
                __textFont = [UIFont systemFontOfSize:9 weight:UIFontWeightRegular];
            }
            return [NSString stringWithFormat:@"%@\n%@",[string substringToIndex:3],[string substringFromIndex:3]];
        } else if (string.length == 6) {
            return [NSString stringWithFormat:@"%@\n%@",[string substringToIndex:2],[string substringFromIndex:2]];
        } else if (string.length == 5) {
            return [NSString stringWithFormat:@"%@\n%@",[string substringToIndex:2],[string substringFromIndex:2]];
        } else if (string.length < 5) {
            return string;
        }
    }
    return @"";
}

- (double)offset {
    NSString *string = [self filterText];
    if (string.length < 4) {
        ///可以根据字体动态变化__textFont.pointSize
        return 4.0;
    } else if (string.length == 4) {
        return 2.5;
    } else {
        return 1.0;
    }
}

///文本属性
- (NSDictionary *)textAttributes {
    return @{NSFontAttributeName : __textFont,
             NSParagraphStyleAttributeName : [self getParagraphStyle],
             NSForegroundColorAttributeName : self.textColor,};
}

///段落信息
- (NSParagraphStyle *)getParagraphStyle {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;  //设置行间距
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    return paragraphStyle;
}

@end
