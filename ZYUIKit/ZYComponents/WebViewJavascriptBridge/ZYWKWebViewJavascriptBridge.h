//
//  ZYWKWebViewJavascriptBridge.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#if (__MAC_OS_X_VERSION_MAX_ALLOWED > __MAC_10_9 || __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1)
#define supportsWKWebView
#endif

#if defined supportsWKWebView

#import <Foundation/Foundation.h>
#import "ZYWebViewJavascriptBridgeBase.h"
#import <WebKit/WebKit.h>

@interface ZYWKWebViewJavascriptBridge : NSObject<WKNavigationDelegate, ZYWebViewJavascriptBridgeBaseDelegate>

+ (instancetype)bridgeForWebView:(WKWebView*)webView;
+ (void)enableLogging;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
- (void)reset;
- (void)setWebViewDelegate:(id)webViewDelegate;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end

#endif

