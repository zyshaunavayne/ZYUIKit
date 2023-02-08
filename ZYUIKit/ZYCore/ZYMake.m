//
//  ZYMake.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYMake.h"
#import "ZYKitLnline.h"
#import "NSAttributedString+ZYUI.h"
#import "NSDate+ZYUI.h"

#define ZYMakerProperty(CLASS, TYPE, NAME) - (CLASS *(^)(TYPE))NAME {\
return ^CLASS *(TYPE NAME) {\
    self.NAME##Value = NAME;\
    return self;\
};\
}\

///-------------------------------------------------- ZYFormatPriceRef --------------------------------------------------

@interface ZYFormatPriceRef ()
@property (nonatomic, copy) NSString *priceValue;
@property (nonatomic, assign) NSInteger digitsValue;
@property (nonatomic, copy) NSString *numberFormatValue;
@property (nonatomic, assign) NSNumberFormatterRoundingMode roundingModeValue;
@end

@implementation ZYFormatPriceRef

ZYMakerProperty(ZYFormatPriceRef, NSString *, price)
ZYMakerProperty(ZYFormatPriceRef, NSInteger, digits)
ZYMakerProperty(ZYFormatPriceRef, NSString *, numberFormat)
ZYMakerProperty(ZYFormatPriceRef, NSNumberFormatterRoundingMode, roundingMode)

@end

///-------------------------------------------------- ZYHTMLRef --------------------------------------------------

@interface ZYHTMLRef ()
@property (nonatomic, copy) NSString *bodyValue;
@property (nonatomic, copy) NSArray *extraImagesValue;
@end

@implementation ZYHTMLRef

ZYMakerProperty(ZYHTMLRef, NSString *, body)
ZYMakerProperty(ZYHTMLRef, NSArray <NSString *>*, extraImages)

@end

///-------------------------------------------------- ZYHumpPriceRef --------------------------------------------------

@interface ZYHumpPriceRef ()
@property (nonatomic, copy) NSString *priceValue;
@property (nonatomic, strong) UIFont *fontValue;
@property (nonatomic, strong) UIColor *colorValue;
@property (nonatomic, strong) UIFont *boldFontValue;
@property (nonatomic, strong) UIColor *boldColorValue;
@end

@implementation ZYHumpPriceRef

ZYMakerProperty(ZYHumpPriceRef, NSString *, price)
ZYMakerProperty(ZYHumpPriceRef, UIFont *, font)
ZYMakerProperty(ZYHumpPriceRef, UIColor *, color)
ZYMakerProperty(ZYHumpPriceRef, UIFont *, boldFont)
ZYMakerProperty(ZYHumpPriceRef, UIColor *, boldColor)

@end

///-------------------------------------------------- ZYStrikethroughRef --------------------------------------------------

@interface ZYStrikethroughRef ()
@property (nonatomic, copy) NSString *stringValue;
@property (nonatomic, strong) UIFont *fontValue;
@property (nonatomic, strong) UIColor *colorValue;
@property (nonatomic, strong) UIColor *strikethrougColorValue;
@end

@implementation ZYStrikethroughRef

ZYMakerProperty(ZYStrikethroughRef, NSString *, string)
ZYMakerProperty(ZYStrikethroughRef, UIFont *, font)
ZYMakerProperty(ZYStrikethroughRef, UIColor *, color)
ZYMakerProperty(ZYStrikethroughRef, UIColor *, strikethrougColor)

@end

///-------------------------------------------------- ZYDifferentPriceRef --------------------------------------------------

@interface ZYDifferentPriceRef ()
@property (nonatomic, copy) NSString *bPriceValue;
@property (nonatomic, strong) UIColor *bPriceColorValue;
@property (nonatomic, strong) UIFont *bPriceFontValue;
@property (nonatomic, copy) NSString *sPriceValue;
@property (nonatomic, strong) UIColor *sPriceColorValue;
@property (nonatomic, strong) UIFont *sPriceFontValue;
@property (nonatomic, strong) UIFont *boldFontValue;
@property (nonatomic, strong) UIColor *boldColorValue;
@property (nonatomic, assign) CGFloat spaceValue;
@property (nonatomic, assign) NSInteger orderValue;
@end

@implementation ZYDifferentPriceRef

ZYMakerProperty(ZYDifferentPriceRef, NSString *, bPrice)
ZYMakerProperty(ZYDifferentPriceRef, UIColor *, bPriceColor)
ZYMakerProperty(ZYDifferentPriceRef, UIFont *, bPriceFont)
ZYMakerProperty(ZYDifferentPriceRef, NSString *, sPrice)
ZYMakerProperty(ZYDifferentPriceRef, UIColor *, sPriceColor)
ZYMakerProperty(ZYDifferentPriceRef, UIFont *, sPriceFont)
ZYMakerProperty(ZYDifferentPriceRef, UIFont *, boldFont)
ZYMakerProperty(ZYDifferentPriceRef, UIColor *, boldColor)
ZYMakerProperty(ZYDifferentPriceRef, CGFloat, space)
ZYMakerProperty(ZYDifferentPriceRef, NSInteger, order)

@end

///-------------------------------------------------- ZYMake --------------------------------------------------

NSAttributedString *ZYMakeAttributedColor(NSString *string, NSString *highlightString, UIColor *highlightColor, UIFont *highlightfont)
{
    return [NSAttributedString zy_attributedStringColorWithString:string highlightString:highlightString highlightColor:highlightColor highlightfont:highlightfont];
}

NSAttributedString *ZYMakeAttributedPackColor(NSString *string, NSArray *highlightStrings, NSArray *highlightColors, NSArray *highlightFonts)
{
    return [NSAttributedString zy_attributedStringPackColorWithString:string font:nil color:nil highlightStrings:highlightStrings highlightColors:highlightColors highlightFonts:highlightFonts];
}

NSString *ZYMakeHTMLString(NSString *body, void (^block)(ZYHTMLRef *make))
{
    ZYHTMLRef *ref = ZYHTMLRef.new;
    ref.bodyValue = body;
    !block ?: block(ref);

    NSString *aBody = ref.bodyValue;
    if (!aBody) { return nil;}
    
    NSString *head = @"<html> \n"
    "<head> \n"
    "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\"> \n"
    "<style>img{max-width: 100%; width:auto; height:auto;}</style> \n"
    "</head> \n"
    "<body style=\"word-wrap:break-word; margin:0; padding:0\"> \n"
    "<div>";
    
    NSString *foot = @"</div> \n"
    "</body> \n"
    "</html>";

    NSString *extraBody = @"";
    for (NSString *url in ref.extraImagesValue) {
        extraBody = [extraBody stringByAppendingFormat:@"<img border=\"0\" src=\"%@\" title=\"image\" />", url];
    }
    
    if (extraBody.length > 0) {
        aBody = [aBody stringByAppendingFormat:@"<p>%@</p>", extraBody];
    }
    
    NSString *HTMLString = [NSString stringWithFormat:@"%@%@%@", head, aBody, foot];
    return HTMLString;
}

NSString *ZYMakeFormatPriceString(NSString *price, void (^block)(ZYFormatPriceRef *make))
{
    ZYFormatPriceRef *ref = ZYFormatPriceRef.new;
    ref.digitsValue = 2;
    ref.roundingModeValue = NSNumberFormatterRoundHalfUp;
    ref.priceValue = price;
    ref.numberFormatValue = @"###0.00";
    !block ?: block(ref);
    
    NSString *value = ZYSafeString(ref.priceValue, @"0.00");
    
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:value];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.maximumFractionDigits = ref.digitsValue;
    numberFormatter.roundingMode = ref.roundingModeValue;
    [numberFormatter setPositiveFormat:ref.numberFormatValue];
    return [numberFormatter stringFromNumber:decNumber];
}

NSAttributedString *ZYMakeHumpPriceAttributedString(NSString *price, void (^block)(ZYHumpPriceRef *make))
{
    ZYHumpPriceRef *ref = ZYHumpPriceRef.new;
    ref.priceValue = price;
    !block ?: block(ref);
    
    NSString *priceStr = ZYSafeString(ref.priceValue, @"");
    NSMutableDictionary *attributes = @{}.mutableCopy;
    [attributes setValue:ref.fontValue forKey:NSFontAttributeName];
    [attributes setValue:ref.colorValue forKey:NSForegroundColorAttributeName];
    
    /// 没有小数点不进行加粗显示
    if (![priceStr containsString:@"."]) {
        return [[NSAttributedString alloc] initWithString:priceStr attributes:attributes.copy];
    }
    
    NSCharacterSet *set =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSInteger integer = [[priceStr stringByTrimmingCharactersInSet:set] integerValue];
    NSString *highlightString = [NSString stringWithFormat:@"%ld.", integer];
    
    return [NSAttributedString zy_attributedStringColorWithString:priceStr font:ref.fontValue color:ref.colorValue highlightString:highlightString highlightColor:ref.boldColorValue highlightfont:ref.boldFontValue];
}

NSAttributedString *ZYMakeStrikethroughAttributedString(NSString *string, void (^block)(ZYStrikethroughRef *make))
{
    ZYStrikethroughRef *ref = ZYStrikethroughRef.new;
    ref.stringValue = string;
    !block ?: block(ref);
    
    return [NSAttributedString zy_attributedStringStrikethroughWithString:ref.stringValue font:ref.fontValue color:ref.colorValue strikethrougColor:ref.strikethrougColorValue];
}

NSAttributedString *ZYMakeDifferentPriceAttributedString(NSString *bPrice, NSString *sPrice, void (^block)(ZYDifferentPriceRef *make))
{
    ZYDifferentPriceRef *ref = ZYDifferentPriceRef.new;
    ref.spaceValue = 5;
    ref.bPriceFontValue = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    ref.bPriceColorValue = UIColor.blackColor;
    ref.sPriceFontValue = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    ref.sPriceColorValue = UIColor.redColor;
    ref.boldFontValue = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    ref.bPriceValue = bPrice;
    ref.sPriceValue = sPrice;
    !block ?: block(ref);
    
    NSMutableAttributedString *bAttributedString = [NSAttributedString zy_attributedStringStrikethroughWithString:ref.bPriceValue font:ref.bPriceFontValue color:ref.bPriceColorValue strikethrougColor:ref.bPriceColorValue].mutableCopy;
    
    NSMutableAttributedString *sAttributedString = ZYMakeHumpPriceAttributedString(sPrice, ^(ZYHumpPriceRef *make) {
        make.font(ref.sPriceFontValue).color(ref.sPriceColorValue).boldFont(ref.boldFontValue).boldColor(ref.boldColorValue);
    }).mutableCopy;
    
    if (ref.orderValue == 1) {
        /// 拼接分隔符
        [sAttributedString appendAttributedString:[NSAttributedString zy_attributedStringWithFixedSpace:ref.spaceValue]];
        [sAttributedString appendAttributedString:bAttributedString.copy];
        return sAttributedString.copy;
    }
    /// 拼接分隔符
    [bAttributedString appendAttributedString:[NSAttributedString zy_attributedStringWithFixedSpace:ref.spaceValue]];
    [bAttributedString appendAttributedString:sAttributedString.copy];
    
    return bAttributedString.copy;
}


