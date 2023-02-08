//
//  ZYAESCrypt.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYAESCrypt : NSObject

/// 解密（AES + ECB + PKCS7 + Base64）
/// @param string 密文
/// @param key key
+ (NSString *)decryptString:(NSString *)string key:(NSString *)key;

/// 加密（AES + ECB + PKCS7 + Base64）
/// @param string 密文
/// @param key key
+ (NSString *)encryptString:(NSString *)string key:(NSString *)key;

/// 加密（AES + CBC + PKCS7 + Base64）
/// @param string 密文
/// @param key key
/// @param iv iv
+ (NSString *)encryptString:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

/// 解密（AES + CBC + PKCS7 + Base64）
/// @param string 密文
/// @param key key
/// @param iv iv
+ (NSString *)decryptString:(NSString *)string key:(NSString *)key iv:(NSString *)iv;

@end

NS_ASSUME_NONNULL_END
