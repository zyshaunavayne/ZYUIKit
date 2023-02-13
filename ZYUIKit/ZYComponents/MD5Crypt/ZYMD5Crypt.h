//
//  ZYMD5Crypt.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYMD5Crypt : NSObject

/// MD5 加密
/// - Parameter input: 字符串
+ (NSString *)ZY_Md5EncryptionWithString:(NSString *)input;

@end

NS_ASSUME_NONNULL_END
