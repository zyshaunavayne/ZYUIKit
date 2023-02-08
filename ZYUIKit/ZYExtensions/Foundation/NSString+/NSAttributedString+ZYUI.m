//
//  NSAttributedString+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "NSAttributedString+ZYUI.h"

@implementation NSAttributedString (ZYUI)

+ (instancetype)zy_attributedStringWithImage:(UIImage *)image
{
    return [self zy_attributedStringWithImage:image baselineOffset:0 leftMargin:0 rightMargin:0];
}

+ (instancetype)zy_attributedStringWithImage:(UIImage *)image
                               baselineOffset:(CGFloat)offset
                                   leftMargin:(CGFloat)leftMargin
                                  rightMargin:(CGFloat)rightMargin
{
    if (!image) {
        return nil;
    }
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    NSMutableAttributedString *attachmentString = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
    [attachmentString addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:NSMakeRange(0, attachmentString.length)];
    if (leftMargin > 0) {
        [attachmentString insertAttributedString:[self zy_attributedStringWithFixedSpace:leftMargin] atIndex:0];
    }
    if (rightMargin > 0) {
        [attachmentString appendAttributedString:[self zy_attributedStringWithFixedSpace:rightMargin]];
    }
    return attachmentString.copy;
}

+ (instancetype)zy_attributedStringWithFixedSpace:(CGFloat)width
{
    UIGraphicsBeginImageContext(CGSizeMake(width, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self zy_attributedStringWithImage:image];
}

+ (instancetype)zy_attributedStringColorWithString:(NSString *)string
                                    highlightString:(NSString *)highlightString
                                     highlightColor:(UIColor *)highlightColor
                                      highlightfont:(UIFont *)highlightfont
{
    return [self zy_attributedStringColorWithString:string font:nil color:nil highlightString:highlightString highlightColor:highlightColor highlightfont:highlightfont];
}

+ (instancetype)zy_attributedStringColorWithString:(NSString *)string
                                               font:(UIFont *)font
                                              color:(UIColor *)color
                                    highlightString:(NSString *)highlightString
                                     highlightColor:(UIColor *)highlightColor
                                      highlightfont:(UIFont *)highlightfont
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:color forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes.copy];
    if (string.length == 0 || highlightString.length == 0) {
        return attributedString;
    }
    
    NSRange highlightRange = [string rangeOfString:highlightString];
    if (highlightRange.location == NSNotFound) {
        return attributedString;
    }
    
    NSMutableDictionary *hltAttributes = @{}.mutableCopy;
    [hltAttributes setValue:highlightColor forKey:NSForegroundColorAttributeName];
    [hltAttributes setValue:highlightfont forKey:NSFontAttributeName];
    [attributedString addAttributes:hltAttributes.copy range:highlightRange];
    return attributedString.copy;
}

+ (instancetype)zy_attributedStringPackColorWithString:(NSString *)string
                                                   font:(UIFont *)font
                                                  color:(UIColor *)color
                                       highlightStrings:(NSArray *)highlightStrings
                                        highlightColors:(NSArray *)highlightColors
                                         highlightFonts:(NSArray *)highlightFonts
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:color forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes.copy];
    for (int i = 0; i < highlightStrings.count; i ++) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:highlightStrings[i] options:0 error:nil];
        NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        NSMutableDictionary *attributes = @{}.mutableCopy;
        if (i < highlightFonts.count) {
            [attributes setValue:highlightFonts[i] forKey:NSFontAttributeName];
        }
        if (i < highlightColors.count) {
            [attributes setValue:highlightColors[i] forKey:NSForegroundColorAttributeName];
        }

        for(NSTextCheckingResult *result in [matches objectEnumerator]) {
            [attributedString addAttributes:attributes.copy range:result.range];
        }
    }
    return attributedString.copy;
}

+ (instancetype)zy_attributedStringStrikethroughWithString:(NSString *)string
                                                       font:(UIFont *)font
                                                      color:(UIColor *)color
                                          strikethrougColor:(UIColor *)strikethrougColor
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:color forKey:NSForegroundColorAttributeName];
    [attributes setValue:strikethrougColor forKey:NSStrikethroughColorAttributeName];
    NSDictionary *styleAttribute = @{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternSolid), NSBaselineOffsetAttributeName: @(0)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttributes:attributes.copy range:NSMakeRange(0, string.length)];
    [attributedString addAttributes:styleAttribute range:NSMakeRange(0, string.length)];
    return attributedString.copy;
}

+ (instancetype)zy_attributedStringUnderlinehWithString:(NSString *)string
                                                    font:(UIFont *)font
                                                   color:(UIColor *)color
                                       strikethrougColor:(UIColor *)strikethrougColor
{
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setValue:font forKey:NSFontAttributeName];
    [attributes setValue:color forKey:NSForegroundColorAttributeName];
    [attributes setValue:strikethrougColor forKey:NSStrikethroughColorAttributeName];
    NSDictionary *styleAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternSolid), NSBaselineOffsetAttributeName: @(0)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttributes:attributes.copy range:NSMakeRange(0, string.length)];
    [attributedString addAttributes:styleAttribute range:NSMakeRange(0, string.length)];
    return attributedString.copy;
}

@end

