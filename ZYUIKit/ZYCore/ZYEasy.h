//
//  ZYEasy.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//
//  扩展全局函数的 oc和swift都支持

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///------------
/// 系统相关
///------------

/// 获取屏幕的宽度
CGFloat ZYScreenWidth(void);

/// 获取屏幕的高度
CGFloat ZYScreenHeight(void);

///// 获取window
UIWindow *ZYMainWindow(void);

///是否为iPhone X 系列手机
BOOL ZYIsIphoneX(void);

/// 适配屏幕底部安全距离高度
CGFloat ZYSafeAreaBottomHeight(void);

/// 获取状态栏高度
CGFloat ZYStatusBarHeight(void);

/// 设置设备方向（前提是：info.plist配置有可支持的方向或者是通过代码实现UIApplication协议`- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window `配置可以支持的方向）- 适配了最新的 IOS16
void ZYSetDeviceOrientation(UIDeviceOrientation orientation);
