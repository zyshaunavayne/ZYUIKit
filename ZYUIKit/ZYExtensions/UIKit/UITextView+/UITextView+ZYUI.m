//
//  UITextView+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UITextView+ZYUI.h"
#import <objc/runtime.h>

NSString *const ZYUITextViewKeyPathText = @"text";

@interface ZYUITextViewWrapper : NSObject;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, weak) UITextView *target;
@property (nonatomic, copy) void (^textViewDidChangeBlock)(NSString *text);
@end

@implementation ZYUITextViewWrapper

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    
    /// iOS9之后，kvo不需要再移除观察者；下面的代码虽然永远不会走；但还是防止对象未销毁的情况
    if (self.target) {
        [self.target removeObserver:self forKeyPath:ZYUITextViewKeyPathText];
    }
}

- (instancetype)initWithTarget:(UITextView *)target
{
    self = [super init];
    if (self) {
        self.target = target;
        
        /// Observer
        [target addObserver:self forKeyPath:ZYUITextViewKeyPathText options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:ZYUITextViewKeyPathText] && self.target == object) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *newValue = change[NSKeyValueChangeNewKey];
        if (oldValue == newValue || [oldValue isEqual:newValue]) { return;}
        
        /// next
        [self textViewDidChange:object];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)textViewTextDidChange:(NSNotification *)notification
{
    UITextView *textView = notification.object;
    if (textView != self.target) {return;}
    [self textViewDidChange:textView];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.maxLength <= 0) { return;}
    
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    /// 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
    if (position) {
        if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textView.text);}
        return;
    };
    
    if (textView.text.length <= self.maxLength) {
        if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textView.text);}
        return;
    };
    
    /// 中文和emoj表情存在问题，需要对此进行处理
    NSRange range;
    NSUInteger inputLength = 0;
    for (int i = 0 ; i < textView.text.length && inputLength <= self.maxLength; i += range.length) {
        range = [textView.text rangeOfComposedCharacterSequenceAtIndex:i];
        inputLength += [textView.text substringWithRange:range].length;
        if (inputLength > self.maxLength) {textView.text = [textView.text substringWithRange:NSMakeRange(0, range.location)];}
    }
    if (self.textViewDidChangeBlock) {self.textViewDidChangeBlock(textView.text);};
}

@end

static const void *kZYUITextViewWrapperkey = &kZYUITextViewWrapperkey;

@implementation UITextView (ZYUI)

- (void)setZy_limitMaxLength:(NSInteger)zy_limitMaxLength
{
    [self zy_limitMaxLength:zy_limitMaxLength textViewDidChange:nil];
}

- (NSInteger)zy_limitMaxLength
{
    return [self zy_textViewWrapper].maxLength;
}

- (void)zy_limitMaxLength:(NSInteger)maxLength
         textViewDidChange:(void (^)(NSString *text))textViewDidChangeBlock
{
    [self zy_textViewWrapper].maxLength = maxLength;
    [self zy_textViewWrapper].textViewDidChangeBlock = textViewDidChangeBlock;
}

- (ZYUITextViewWrapper *)zy_textViewWrapper
{
    ZYUITextViewWrapper *wrapper = objc_getAssociatedObject(self, &kZYUITextViewWrapperkey);
    if (wrapper == nil) {
        wrapper = [[ZYUITextViewWrapper alloc] initWithTarget:self];
        objc_setAssociatedObject(self, &kZYUITextViewWrapperkey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return wrapper;
}

@end



