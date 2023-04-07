//
//  NSString+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYUI)

/// 字符串转 KB、MB、GB
- (NSString *)zy_convertFileSize;

@end
