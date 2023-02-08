//
//  ZYEasy.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYEasy.h"
#import "ZYRouterNP.h"

CGFloat ZYScreenWidth(void)
{
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat ZYScreenHeight(void)
{
    return [UIScreen mainScreen].bounds.size.height;
}

UIWindow *ZYMainWindow(void)
{
    UIWindow *window = nil;
    if (@available(iOS 15.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
        if (window == nil && [UIApplication sharedApplication].connectedScenes.allObjects.count) {
            window = [[UIApplication sharedApplication].connectedScenes.allObjects.firstObject valueForKeyPath:@"delegate.window"];
        }
    } else { window = [UIApplication sharedApplication].keyWindow;}
    if (window == nil) {
        id appDelegate = [[UIApplication sharedApplication] delegate];
        if (appDelegate && [appDelegate valueForKey:@"window"]) {
            window = [[UIApplication sharedApplication] delegate].window;
        }
    }
    return window;
}

BOOL ZYIsIphoneX(void)
{
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = ZYMainWindow().safeAreaInsets.bottom > 0.0;
    }
    return isPhoneX;
}

CGFloat ZYSafeAreaBottomHeight(void)
{
    CGFloat safeHeight = CGFLOAT_MIN;
    if (@available(iOS 11.0, *)) {
        safeHeight = ZYMainWindow().safeAreaInsets.bottom;
    }
    return safeHeight;
}

CGFloat ZYStatusBarHeight(void)
{
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else { statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height; }
    return statusBarHeight;
}

void ZYSetDeviceOrientation(UIDeviceOrientation orientation)
{
    @try {
        // ios16使用新的api
        if (@available(iOS 16.0, *)) {
            UIInterfaceOrientationMask oriMask = UIInterfaceOrientationMaskPortrait;
            if (orientation != UIDeviceOrientationPortrait && orientation != UIDeviceOrientationUnknown) {
                oriMask = UIInterfaceOrientationMaskLandscapeRight;
            }
            // 防止appDelegate supportedInterfaceOrientationsForWindow方法不调用
            UINavigationController *nav = ZYRouterNP.currentViewController.navigationController;
            SEL selUpdateSupportedMethod = NSSelectorFromString(@"setNeedsUpdateOfSupportedInterfaceOrientations");
            if ([nav respondsToSelector:selUpdateSupportedMethod]) {
                (((void (*)(id, SEL))[nav methodForSelector:selUpdateSupportedMethod])(nav, selUpdateSupportedMethod));
            }
            
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *ws = (UIWindowScene *)array.firstObject;
            Class GeometryPreferences = NSClassFromString(@"UIWindowSceneGeometryPreferencesIOS");
            id geometryPreferences = [[GeometryPreferences alloc] init];
            [geometryPreferences setValue:@(oriMask) forKey:@"interfaceOrientations"];
            SEL selGeometryUpdateMethod = NSSelectorFromString(@"requestGeometryUpdateWithPreferences:errorHandler:");
            void (^ErrorBlock)(NSError *error) = ^(NSError *error){
                  NSLog(@"iOS 16 转屏Error: %@",error);
            };
            if ([ws respondsToSelector:selGeometryUpdateMethod]) {
                (((void (*)(id, SEL,id,id))[ws methodForSelector:selGeometryUpdateMethod])(ws, selGeometryUpdateMethod,geometryPreferences,ErrorBlock));
            }

        } else {
            
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                SEL selector = NSSelectorFromString(@"setOrientation:");

                if ([UIDevice currentDevice].orientation == orientation) {
                    NSInvocation *invocationUnknow = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                    [invocationUnknow setSelector:selector];
                    [invocationUnknow setTarget:[UIDevice currentDevice]];
                    UIDeviceOrientation unKnowVal = UIDeviceOrientationUnknown;
                    [invocationUnknow setArgument:&unKnowVal atIndex:2];
                    [invocationUnknow invoke];
                }
                
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:[UIDevice currentDevice]];
                UIDeviceOrientation val = orientation;
                [invocation setArgument:&val atIndex:2];
                [invocation invoke];
            }
        }

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

