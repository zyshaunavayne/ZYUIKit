//
//  ZYEasy.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//
//  OC版 --- 暂不维护，慢慢替代宏定义，多用函数的方式。要兼容swift

#ifndef ZYKitMacro_h
#define ZYKitMacro_h

///------------
/// 系统相关
///------------

/// 获取屏幕的宽度
#define ZY_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

/// 获取屏幕的高度
#define ZY_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/// 获取window
#define ZY_MAIN_WINDOW \
({UIWindow *window = nil; \
if (@available(iOS 15.0, *)) { \
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) { \
        if (windowScene.activationState == UISceneActivationStateForegroundActive) { \
            window = windowScene.windows.firstObject; \
            break; \
        } \
    } \
    if (window == nil && [UIApplication sharedApplication].connectedScenes.allObjects.count) { \
        window = [[UIApplication sharedApplication].connectedScenes.allObjects.firstObject valueForKeyPath:@"delegate.window"]; \
    } \
} \
else { window = [UIApplication sharedApplication].keyWindow; } \
if (window == nil) { \
    id appDelegate = [[UIApplication sharedApplication] delegate]; \
    if (appDelegate && [appDelegate valueForKey:@"window"]) { \
        window = [[UIApplication sharedApplication] delegate].window; \
    } \
} \
(window);})

///是否为iPhone X 系列手机
#define ZY_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = ZY_MAIN_WINDOW.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/// 适配屏幕底部安全间距离高度
#define ZY_SAFE_AREA_BOTTOM_HEIGHT \
({CGFloat safeHeight = CGFLOAT_MIN; \
if (@available(iOS 11.0, *)) { \
safeHeight = ZY_MAIN_WINDOW.safeAreaInsets.bottom; \
} \
else { safeHeight = [UIApplication sharedApplication].statusBarFrame.size.height; } \
(safeHeight);})

/// 获取状态栏高度
#define ZY_STATUS_BAR_HEIGHT \
({CGFloat statusBarHeight = 0; \
if (@available(iOS 13.0, *)) { \
UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager; \
statusBarHeight = statusBarManager.statusBarFrame.size.height; \
} \
else { statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height; } \
(statusBarHeight);})


///------------
/// RAC
///------------

#if __has_include(<ReactiveObjC/ReactiveObjC.h>) || __has_include(<ReactiveCocoa/ReactiveCocoa.h>)

/// 基于RAC的任意数据的双向数据绑定
#define ZY_RAC_A(Target1, Key1, Target2, Key2) \
Target1.Key1 = Target2.Key2; \
RACChannelTo(Target1, Key1) = RACChannelTo(Target2, Key2); \

/// 基于RAC输入控件的双向数据绑定
#define ZY_RAC_INPUT(UIInputControl, Key1, EventHandler, Key2) \
UIInputControl.Key1 = EventHandler.Key2; \
RACChannelTo(UIInputControl, Key1) = RACChannelTo(EventHandler, Key2); \
if ([UIInputControl isKindOfClass:UITextField.class]) { \
    [UIInputControl.rac_textSignal subscribe:RACChannelTo(EventHandler, Key2)]; \
} else if ([UIInputControl isKindOfClass:UITextView.class]) { \
    __weak __typeof(UIInputControl) weakUIInputControl = UIInputControl; \
    __weak __typeof(EventHandler) weakEventHandler = EventHandler; \
    [UIInputControl.rac_textSignal subscribeNext:^(NSString * _Nullable x) { \
        UITextRange *selectedRange = [weakUIInputControl markedTextRange]; \
        UITextPosition *position = [weakUIInputControl positionFromPosition:selectedRange.start offset:0]; \
        if (!position) { weakEventHandler.Key2 = x; } \
    }]; \
} \

#else
#endif

/// UIButton点击事件绑定
#define ZY_RAC_BUTTON(UIControl, Target, Action) \
[UIControl addTarget:Target action:Action forControlEvents:UIControlEventTouchUpInside];

#endif /* ZYKitMacro_h */
