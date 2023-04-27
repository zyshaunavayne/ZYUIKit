//
//  UITextField+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UITextField+ZYUI.h"
#import <objc/runtime.h>
#import "NSString+ZYRegularEvaluate.h"
#import "NSString+ZYUI.h"
#import <Aspects/Aspects.h>

NSString *const ZYUITextFieldKeyPathText = @"text";
NSString *const ZYTextFieldTypeKey = @"ZYTextFieldTypeKey";
NSString *const ZYPhoneNumber_set = @"0123456789";

@interface ZYUITextFieldWrapper : NSObject;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, assign) ZYTextFieldType textFieldType;
@property (nonatomic, assign) ZYTextFieldInputType inputType;
@property (nonatomic, weak) UITextField *target;
@property (nonatomic, copy) void (^textViewDidChangeBlock)(NSString *text);
@end

@implementation ZYUITextFieldWrapper

- (void)dealloc
{
    /// iOS9之后，kvo不需要再移除观察者；下面的代码虽然永远不会走；但还是防止对象未销毁的情况
    if (self.target) {
        [self.target removeObserver:self forKeyPath:ZYUITextFieldKeyPathText];
    }
}

- (instancetype)initWithTarget:(UITextField *)target
{
    self = [super init];
    if (self) {
        self.target = target;
        
        /// Observer
        [target addObserver:self forKeyPath:ZYUITextFieldKeyPathText options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldNotificationObserver:) name:UITextFieldTextDidChangeNotification object:nil];
                
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:ZYUITextFieldKeyPathText] && self.target == object) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *newValue = change[NSKeyValueChangeNewKey];
        if (oldValue == newValue || [oldValue isEqual:newValue]) { return;}
        
        /// next
        [self textViewDidChange:object];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)textFieldNotificationObserver:(NSNotification *)notification {
    if (notification.object == self.target) {
        [self textViewDidChange:notification.object];
    }
}

- (void)textViewDidChange:(UITextField *)textField
{
    
    if (textField.zy_textFieldType ==  ZYTextFieldTypeNumber) {
        if (![self isPhoneNumWithString:textField.text]) {
            textField.text = [textField.text stringByReplacingCharactersInRange:NSMakeRange(textField.text.length - 1, 1) withString:@""];
        }
    } else if (textField.zy_textFieldType == ZYTextFieldTypeMoney){
        if (![self isMoneyNum:YES textField:textField]) {
            textField.text = [textField.text stringByReplacingCharactersInRange:NSMakeRange(textField.text.length - 1, 1) withString:@""];
        }
    } else if (textField.zy_textFieldType == ZYTextFieldTypeOneDecimal){
        if (![self isMoneyNum:NO textField:textField]) {
            textField.text = [textField.text stringByReplacingCharactersInRange:NSMakeRange(textField.text.length - 1, 1) withString:@""];
        }
    } else if (textField.zy_textFieldType == ZYTextFieldTypeFiveDecimal){
        if (![self isMoneyNum:YES FiveTextField:textField]) {
            textField.text = [textField.text stringByReplacingCharactersInRange:NSMakeRange(textField.text.length - 1, 1) withString:@""];
        }
    }
    

    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    NSString *regex = @"";
    if (position == nil && self.inputType & ZYTextFieldInputTypeArabicNumerals) {
        regex = @"0-9";
    }
    if (position == nil && self.inputType & ZYTextFieldInputTypeEnglishLetters) {
        regex = [regex stringByAppendingString:@"A-Za-z"];
    }
    if (position == nil && self.inputType & ZYTextFieldInputTypeChinese) {
        regex = [regex stringByAppendingString:@"\u4e00-\u9fa5"];
    }
    if (position == nil && self.inputType & ZYTextFieldInputTypeBlank) {
        regex = [regex stringByAppendingString:@"\\s"];
    }
    if (position == nil && self.inputType & ZYTextFieldInputTypeSpecial) {
        regex = [regex stringByAppendingString:@"-()（）—”“$&@%^*?+?=|{}?【】？??￥!！.<>/:;：；、,，。‘'_#~·\\\\\\]\\\["];
    }
    
    if (regex.length > 0) {
        textField.text = [self filterCharactor:textField.text withRegex:[NSString stringWithFormat:@"[^%@]+$", regex]];
    }

    if (self.maxLength <= 0) {
        if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textField.text);}
        return;
    }
    
    /// 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
    if (position) {
        if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textField.text);}
        return;
    };
    
    if (textField.text.length <= self.maxLength) {
        if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textField.text);}
        return;
    };
    
    /// 中文和emoj表情存在问题，需要对此进行处理
    NSRange range;
    NSUInteger inputLength = 0;
    for (int i = 0 ; i < textField.text.length && inputLength <= self.maxLength; i += range.length) {
        range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
        inputLength += [textField.text substringWithRange:range].length;
        if (inputLength > self.maxLength) {textField.text = [textField.text substringWithRange:NSMakeRange(0, range.location)];}
    }
    if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textField.text);};
}
    

- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexString
{
    if (!regexString) { return string;}
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}

- (BOOL)isPhoneNumWithString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ZYPhoneNumber_set] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL sholud = [string isEqualToString:filtered];
  
    return sholud;
}

- (BOOL)isMoneyNum:(BOOL) isMoney textField:(UITextField *)textField
{
    if (textField.text.length > 0) {
        NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d*(([.]\\d{0,2})?)))?";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:textField.text];
        if (!flag) {
            return NO;
        }
    }
    //根据zy_limitMaxLength控制输入金额最多位数
    //zy_limitMaxLength = 最大金额位数+3（金额要保留两位小数.xx）
    NSInteger subCount = isMoney ? 3 : 2;
    NSInteger maxCount = textField.zy_limitMaxLength - subCount;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        if ((textField.text.length > maxCount)) {
            return NO;
        }
    } else{
        
        NSInteger retainCount = isMoney ? 3 : 2;
        NSString *s1 = [textField.text substringFromIndex:[textField.text rangeOfString:@"."].location];
        NSString *s2 = [textField.text substringToIndex:[textField.text rangeOfString:@"."].location];
        if ((s1.length > retainCount || s2.length > maxCount))
            return NO;
    }
    
    return YES;
}

- (BOOL)isMoneyNum:(BOOL) isMoney FiveTextField:(UITextField *)textField
{
    if (textField.text.length > 0) {
        NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,5}))|([1-9]\\d*(([.]\\d{0,5})?)))?";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
        BOOL flag = [phoneTest evaluateWithObject:textField.text];
        if (!flag) {
            return NO;
        }
    }
    //根据zy_limitMaxLength控制输入金额最多位数
    //zy_limitMaxLength = 最大金额位数+3（金额要保留两位小数.xx）
    NSInteger subCount = isMoney ? 6 : 5;
    NSInteger maxCount = textField.zy_limitMaxLength - subCount;
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        if ((textField.text.length > maxCount)) {
            return NO;
        }
    } else{
        
        NSInteger retainCount = isMoney ? 6 : 5;
        NSString *s1 = [textField.text substringFromIndex:[textField.text rangeOfString:@"."].location];
        NSString *s2 = [textField.text substringToIndex:[textField.text rangeOfString:@"."].location];
        if ((s1.length > retainCount || s2.length > maxCount))
            return NO;
    }
    
    return YES;
}

@end

static const void *kZYUITextFieldWrapperkey = &kZYUITextFieldWrapperkey;

@implementation UITextField (ZYUI)

+ (UITextField *)zy_createTextFieldWithPlaceholder:(NSString *)placeholder
                                   placeholderColor:(UIColor *)placeholderColor
                                    placeholderFont:(UIFont *)placeholderFont
                                          textColor:(UIColor *)textColor
                                           textFont:(UIFont *)textFont
{
    UITextField *textField = [UITextField new];
    NSDictionary *attributes = @{NSFontAttributeName: placeholderFont, NSForegroundColorAttributeName: placeholderColor};
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    textField.textColor = textColor;
    textField.font = textFont;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return textField;
}

- (void)setZy_limitMaxLength:(NSInteger)zy_limitMaxLength
{
    [self zy_limitMaxLength:zy_limitMaxLength textViewDidChange:nil];
}

- (NSInteger)zy_limitMaxLength
{
    return [self zy_textFieldWrapper].maxLength;
}

- (void)setZy_textFieldType:(ZYTextFieldType)zy_textFieldType
{
    [self zy_textFieldWrapper].textFieldType = zy_textFieldType;
}

- (ZYTextFieldType)zy_textFieldType
{
    return [self zy_textFieldWrapper].textFieldType;
}

- (void)setZy_inputType:(ZYTextFieldInputType)zy_inputType
{
    [self zy_textFieldWrapper].inputType = zy_inputType;
}

- (ZYTextFieldInputType)zy_inputType
{
    return [self zy_textFieldWrapper].inputType;
}

- (void)zy_limitMaxLength:(NSInteger)maxLength
         textViewDidChange:(void (^)(NSString *text))textViewDidChangeBlock
{
    [self zy_textFieldWrapper].maxLength = maxLength;
    [self zy_textFieldWrapper].textViewDidChangeBlock = textViewDidChangeBlock;
}

- (ZYUITextFieldWrapper *)zy_textFieldWrapper
{
    ZYUITextFieldWrapper *wrapper = objc_getAssociatedObject(self, &kZYUITextFieldWrapperkey);
    if (wrapper == nil) {
        wrapper = [[ZYUITextFieldWrapper alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kZYUITextFieldWrapperkey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrapper;
}

@end


