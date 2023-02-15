//
//  ZYRouterNP.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYRouterNP.h"

@implementation ZYRouterNP

+ (void)pushViewController:(UIViewController *)destination animated:(BOOL)animated
{
    NSParameterAssert([destination isKindOfClass:[UIViewController class]]);
    [[self currentNavigationViewController] pushViewController:destination animated:animated];
}

+ (void)popToViewControllerName:(NSString *)name animated:(BOOL)animated
{
    UIViewController *popViewController = nil;
    UINavigationController *navigationController = [self currentNavigationViewController];
    if (!name || name.length == 0) {
        [navigationController popViewControllerAnimated:animated];
        return;
    }
    for (UIViewController *viewController in navigationController.viewControllers.reverseObjectEnumerator) {
        if ([NSStringFromClass(viewController.class) isEqualToString:name]) {
            popViewController = viewController;
            break;
        }
    }
    if (popViewController) {
        [navigationController popToViewController:popViewController animated:animated];
    } else {
        [navigationController popViewControllerAnimated:animated];
    }
}

+ (void)popToViewControllerTag:(NSInteger)tag animated:(BOOL)animated
{
    UIViewController *popViewController = nil;
    UINavigationController *navigationController = [self currentNavigationViewController];
    if (tag == 0) {
        [navigationController popViewControllerAnimated:animated];
        return;
    }
    for (UIViewController *viewController in navigationController.viewControllers.reverseObjectEnumerator) {
        if (viewController.view.tag == tag) {
            popViewController = viewController;
            break;
        }
    }
    if (popViewController) {
        [navigationController popToViewController:popViewController animated:YES];
    } else {
        [navigationController popViewControllerAnimated:YES];
    }
}

+ (UINavigationController *)currentNavigationViewController
{
    UIViewController *currentViewController = [self currentViewController];
    return currentViewController.navigationController;
}

+ (UIViewController *)currentViewController
{
    UIViewController *rootViewController = [self zy_window].rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

+ (UIViewController *)currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tabBarController.selectedViewController];
    } else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

+ (UIWindow *)zy_window
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window) {
        return window;
    }
    
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }
    
    return window;
}

@end

