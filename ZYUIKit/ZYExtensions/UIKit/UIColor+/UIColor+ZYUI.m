//
//  UIColor+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UIColor+ZYUI.h"

@implementation UIColor (ZYUI)

- (NSString *)zy_stringFromColor
{
    NSAssert(self.zy_canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    NSString *result;
    switch (self.zy_colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.zy_red, self.zy_green, self.zy_blue, self.zy_alpha];
            break;
        case kCGColorSpaceModelMonochrome:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.zy_white, self.zy_alpha];
            break;
        default:
            result = nil;
    }
    return result;
}

- (NSString *)zy_hexStringFromColor
{
    return [NSString stringWithFormat:@"%0.6X", (int)self.zy_rgbHex];
}

+ (UIColor *)zy_colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)zy_colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor zy_colorWithRGBHex:hexNum];
}

+ (UIColor *)zy_colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha
{
    UIColor *color = [UIColor zy_colorWithHexString:stringToConvert];
    return [UIColor colorWithRed:color.zy_red green:color.zy_green blue:color.zy_blue alpha:alpha];
}

+ (UIColor *)zy_randomColor
{
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

#pragma mark - other

- (CGColorSpaceModel)zy_colorSpaceModel
{
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)zy_canProvideRGBComponents
{
    switch (self.zy_colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);

    CGFloat r,g,b,a;
    
    switch (self.zy_colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:    // We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (CGFloat)zy_red
{
    NSAssert(self.zy_canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)zy_green
{
    NSAssert(self.zy_canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.zy_colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)zy_blue
{
    NSAssert(self.zy_canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.zy_colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)zy_white
{
    NSAssert(self.zy_colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)zy_alpha
{
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)zy_rgbHex
{
    NSAssert(self.zy_canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.zy_red, 0.0f), 1.0f);
    g = MIN(MAX(self.zy_green, 0.0f), 1.0f);
    b = MIN(MAX(self.zy_blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

+ (UIColor *)zy_RGBColor:(NSInteger)RGB
{
    return [UIColor colorWithWhite:RGB / 255. alpha:1.];
}

+ (UIColor *)zy_lineColor
{
    return [self zy_RGBColor:230];
}

@end
