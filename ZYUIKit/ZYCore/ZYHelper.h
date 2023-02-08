//
//  ZYHelper.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYHelper : NSObject

/// 获取 ZYKit.framework Images.xcassets 内的图片资源
/// @param name 图片名
+ (UIImage *)imageNamed:(NSString *)name;

@end

@interface ZYHelper (Bundle)

/// 获取 ZYKit.framework
+ (NSBundle *)mainBundle;

@end
