//
//  ZYSearchView.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYSearchView.h"
#import <Masonry/Masonry.h>
#import "ZYHelper.h"
#import "ZYKitLnline.h"
#import "UIView+ZYUI.h"
#import "UITextField+ZYUI.h"
#import "UIColor+ZYUI.h"
#import "UIFont+ZYFont.h"

@interface ZYSearchView()<UITextFieldDelegate>
///当按钮隐藏式自动布局
@property (strong, nonatomic, readwrite) UIStackView *stackView;
///放置放大镜图片和输入框的容器视图
@property (strong, nonatomic, readwrite) UIView *contentView;
///放大镜图片
@property (strong, nonatomic, readwrite) UIImageView *searchImageView;
///输入框
@property (strong, nonatomic, readwrite) UITextField *searchTextField;
///搜索按钮
@property (strong, nonatomic, readwrite) UIButton *searchButton;

@end

@implementation ZYSearchView

#pragma mark - 初始化
+ (instancetype)defaultSearchViewPlaceholder:(NSString *)placeholder {
    ZYSearchView *view = [[ZYSearchView alloc] init];
    view.placeholderText = placeholder;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    } return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initUI];
    } return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds), 30);
}

- (void)initUI {
    self.backgroundColor = UIColor.clearColor;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.isShowClearButton = YES;
    self.isAutoCloseKeyboard = YES;
    
    [self addSubview:self.stackView];
    [self.contentView addSubview:self.searchImageView];
    [self.contentView addSubview:self.searchTextField];
    [self.stackView addArrangedSubview:self.contentView];
    [self.stackView addArrangedSubview:self.searchButton];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(36);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.searchImageView.mas_right);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
    }];
}

#pragma mark - public method

- (void)setSearchMode:(ZYSearchViewMode)searchMode {
    _searchMode = searchMode;
    switch (searchMode) {
        case ZYSearchViewModeDefault:
            self.searchTextField.userInteractionEnabled = YES;
            self.contentView.userInteractionEnabled = NO;
            self.searchButton.hidden = NO;
            break;
        case ZYSearchViewModeClick:
            self.searchTextField.userInteractionEnabled = NO;
            self.contentView.userInteractionEnabled = YES;
            self.searchButton.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)setKeyword:(NSString *)keyword {
    self.searchTextField.text = keyword;
}

- (NSString *)keyword {
    return self.searchTextField.text;
}

- (void)setSearchViewBackgroundColor:(UIColor *)searchViewBackgroundColor {
    _searchViewBackgroundColor = searchViewBackgroundColor;
    self.contentView.backgroundColor = searchViewBackgroundColor;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    [self resetPlaceholder];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self resetPlaceholder];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self resetPlaceholder];
}

- (void)setIsShowClearButton:(BOOL)isShowClearButton {
    _isShowClearButton = isShowClearButton;
    if (isShowClearButton) {
        self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    } else {
        self.searchTextField.clearButtonMode = UITextFieldViewModeNever;
    }
}

///设置占位符的文字字体颜色
- (void)resetPlaceholder {
    NSString *stirng = ZYSafeString(self.placeholderText, @"请输入关键字");
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : self.placeholderColor ? self.placeholderColor : ZYColor_HEX(@"C0C4CC"),
        NSFontAttributeName : self.placeholderFont ? self.placeholderFont : zy_RegularFont(15),
    };
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:stirng attributes:attributes];
}


#pragma mark - 懒加载
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = 10;
    } return _stackView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
        _contentView.backgroundColor = ZYColor_HEX(@"F5F5F5");
        __weak typeof(self) weakSelf = self;
        [_contentView zy_addTapAction:^(UITapGestureRecognizer *zy_tap, UIView *zy_view) {
            __strong typeof(self) self = weakSelf;
            [self search];
        }];
    } return _contentView;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] init];
        _searchImageView.image = [ZYHelper imageNamed:@"search"];
        _searchImageView.contentMode = UIViewContentModeCenter;
    } return _searchImageView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.tintColor = ZYColor_HEX(@"C0C4CC");
        _searchTextField.textColor = ZYColor_HEX(@"333333");
        _searchTextField.font = zy_RegularFont(15);
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.delegate = self;///实现键盘点击搜索按钮
        _searchTextField.zy_limitMaxLength = 100;///最大限制100个字符长度
        [_searchTextField addTarget:self action:@selector(textFieldEditingDidBeginAction:) forControlEvents:(UIControlEventEditingDidBegin)];
        [_searchTextField addTarget:self action:@selector(textFieldEditingChangedAction:) forControlEvents:(UIControlEventEditingChanged)];
        [_searchTextField addTarget:self action:@selector(textFieldEditingDidEndAction:) forControlEvents:(UIControlEventEditingDidEnd)];
    } return _searchTextField;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.titleLabel.font = zy_RegularFont(18);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    } return _searchButton;
}

#pragma mark - action method
- (void)textFieldEditingDidBeginAction:(UITextField *)textField {
    if (self.searchEditingDidBeginBlock) {
        self.searchEditingDidBeginBlock();
    }
}

- (void)textFieldEditingChangedAction:(UITextField *)textField {
    if (textField.markedTextRange == nil) {
        ///在键盘选词区域选词后执行，因为类似汉字等需要拼写的文字是输入拉丁字符后拼写选择的
        if (self.searchEditingChangedBlock) {
            self.searchEditingChangedBlock(textField.text);
        }
    }
}

- (void)textFieldEditingDidEndAction:(UITextField *)textField {
    if (self.searchEditingDidEndBlock) {
        self.searchEditingDidEndBlock(textField.text);
    }
}

- (void)searchButtonAction:(id)sender {
    if (self.searchButtonActionBlock) {
        self.searchButtonActionBlock(self.searchTextField.text);
    }
    [self search];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.searchTextField.text = @"";
    if (self.searchClearKeywordBlock) {
        self.searchClearKeywordBlock();
    }
    [self search];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.searchKeyboardActionBlock) {
        self.searchKeyboardActionBlock(textField.text);
    }
    [self search];
    return YES;
}

///搜索行为
- (void)search {
    if (self.isAutoCloseKeyboard) {
        [self.searchTextField endEditing:YES];
    }
    if (self.searchActionBlock) {
        self.searchActionBlock(self.searchTextField.text);
    }
}

@end
