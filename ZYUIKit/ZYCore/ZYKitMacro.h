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

#endif /* ZYKitMacro_h */
