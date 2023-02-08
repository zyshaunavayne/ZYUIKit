//
//  ZYSearchView.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZYSearchViewMode) {
    ZYSearchViewModeDefault,///默认模式，在输入框输入文字，然后点击搜索按钮进行检索
    ZYSearchViewModeClick,///点击跳转模式，触碰搜索框任意位置，然后触发点击事件【某些需求是触摸搜索框跳转到新的页面进行搜索】
};

///搜索框，外部不设置高度时，默认高度为30
@interface ZYSearchView : UIView
///快速初始化：生成一个默认样式的搜索框【搜索图标、输入框、搜索按钮】
+ (instancetype)defaultSearchViewPlaceholder:(NSString *)placeholder;

///搜索行为模式【默认ZYSearchViewModeDefault】
@property (assign, nonatomic) ZYSearchViewMode searchMode;

///放大镜图片【可以自定义样式或者更换图片】
@property (strong, nonatomic, readonly) UIImageView *searchImageView;
///文本输入框【可以自定义样式或者实现代理事件方法】【备注：如果外部改变代理对象，会导致点击搜索按钮和清除按钮逻辑失效，需要自己再次实现】
@property (strong, nonatomic, readonly) UITextField *searchTextField;
///搜索按钮【可以自定义样式或者隐藏显示】
@property (strong, nonatomic, readonly) UIButton *searchButton;

///搜索的关键字
@property (strong, nonatomic) IBInspectable NSString *keyword;
///输入框以及放大镜区域的背景色【默认为F5F5F5】
@property (strong, nonatomic) IBInspectable UIColor *searchViewBackgroundColor;
///提示文字
@property (strong, nonatomic) IBInspectable NSString *placeholderText;
///提示文字字体【默认15】
@property (strong, nonatomic) IBInspectable UIFont *placeholderFont;
///提示文字颜色【默认C0C4CC】
@property (strong, nonatomic) IBInspectable UIColor *placeholderColor;
///是否显示编辑时可以清除文字按钮【内部修改UITextField的clearButtonMode属性，默认为YES】
@property (assign, nonatomic) IBInspectable BOOL isShowClearButton;
///是否在点击搜索按钮、点击键盘上的搜索按钮、点击清空输入框按钮时自动关闭键盘【默认为YES】
@property (assign, nonatomic) IBInspectable BOOL isAutoCloseKeyboard;

#pragma mark - 搜索回调
///搜索回调【点击搜索按钮、点击键盘上的搜索按钮、点击清空输入框按钮都会响应，并且会关闭键盘】
@property (copy, nonatomic) void(^searchActionBlock)(NSString *keyword);
///点击搜索按钮回调
@property (copy, nonatomic) void(^searchButtonActionBlock)(NSString *keyword);
///点击键盘搜索按钮回调
@property (copy, nonatomic) void(^searchKeyboardActionBlock)(NSString *keyword);
///开始输入文字回调
@property (copy, nonatomic) void(^searchEditingDidBeginBlock)(void);
///输入框文字改变回调【某些搜索也许需要再输入字符后立即检索，可以使用此回调】
@property (copy, nonatomic) void(^searchEditingChangedBlock)(NSString *keyword);
///结束输入文字回调
@property (copy, nonatomic) void(^searchEditingDidEndBlock)(NSString *keyword);
///清除输入框所有文字回调
@property (copy, nonatomic) void(^searchClearKeywordBlock)(void);

@end

NS_ASSUME_NONNULL_END
