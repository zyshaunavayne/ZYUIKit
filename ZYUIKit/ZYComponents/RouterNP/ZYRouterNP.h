//
//  ZYRouterNP.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYRouterNP : NSObject

/// 入栈
/// @param destination 入栈的的控制器
/// @param animated 动画
+ (void)pushViewController:(UIViewController *)destination
                  animated:(BOOL)animated;

/// 返回指定的页面
/// @param name 需要返回的控制器页面名称
/// @param animated 动画
+ (void)popToViewControllerName:(NSString *)name
                       animated:(BOOL)animated;

/// 返回指定的页面
/// @param tag 返回的控制器 ViewController.view.tag（必须大于 0 ）
/// @param animated 动画
+ (void)popToViewControllerTag:(NSInteger)tag
                      animated:(BOOL)animated;

/// 获取当前栈上显示的ViewController
+ (UIViewController *)currentViewController;

@end
