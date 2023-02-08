//
//  ZYTextView.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYTextView.h"

@interface ZYTextView ()
@property (nonatomic, strong) UILabel *placeHolderLabel;
@end

@implementation ZYTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews
{
    self.text  = @"";
    [self setZy_placeholder:@""];
    [self setZy_placeholderColor:[UIColor lightGrayColor]];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self zy_isPlaceholderShow:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.zy_placeholder.length > 0 ) {
        if (!_placeHolderLabel) {
            _placeHolderLabel = [UILabel.alloc initWithFrame:CGRectMake(3, 8,self.bounds.size.width - 0, 0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = UIColor.clearColor;
            _placeHolderLabel.textColor = self.zy_placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.zy_placeholder;
        
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.alloc.init;
        paragraphStyle.lineSpacing = 5;
        NSDictionary *attributes = @{ NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle};
        _placeHolderLabel.attributedText = [NSAttributedString.alloc initWithString:self.zy_placeholder attributes:attributes];
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if (self.text.length == 0 && self.zy_placeholder.length > 0) {
        [self viewWithTag:999].alpha = 1;
    }

}

- (void)zy_isPlaceholderShow:(ZYTextView *)textView
{
    if (!textView.text || textView.text.length == 0 || [textView.text isEqualToString:@""]) {
        [textView.placeHolderLabel setAlpha:1];
    } else {
        [textView.placeHolderLabel setAlpha:0];
    }
}

@end
