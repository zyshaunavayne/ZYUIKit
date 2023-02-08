//
//  ZYAESCrypt.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "ZYAESCrypt.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation ZYAESCrypt

+ (NSData *)encryptData:(NSData *)data key:(NSData *)key
{
    /// 加密的流数据是否存在
    if ((data == nil) || (data == NULL)) { return nil;}
    else if (![data isKindOfClass:[NSData class]]) { return nil;}
    else if ([data length] <= 0) { return nil;}
    
    /// 加密的Key是否存在
    if ((key == nil) || (key == NULL)) { return nil;}
    else if (![key isKindOfClass:[NSData class]]) { return nil;}
    else if ([key length] <= 0) { return nil;}
    
    NSData *result = nil;
    
    /// setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    /// do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
    }
    return result;
}

+ (NSData *)decryptData:(NSData *)data key:(NSData *)key
{
    /// 解密的流数据是否存在
    if ((data == nil) || (data == NULL)) { return nil;}
    else if (![data isKindOfClass:[NSData class]]) { return nil;}
    else if ([data length] <= 0) { return nil;}
    
    /// 解密的Key是否存在
    if ((key == nil) || (key == NULL)) { return nil;}
    else if (![key isKindOfClass:[NSData class]]) { return nil;}
    else if ([key length] <= 0) { return nil;}
    
    NSData *result = nil;
    
    /// setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    /// do decrypt
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
    }
    return result;
}

+ (NSString *)decryptString:(NSString *)string key:(NSString *)key
{
    if (!string || [string isKindOfClass:[NSNull class]]) return nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    data = [self decryptData:data key:keyData];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSString *)encryptString:(NSString *)string key:(NSString *)key
{
    if (!string || [string isKindOfClass:[NSNull class]]) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    data = [self encryptData:data key:keyData];
    NSString *ret = [data base64EncodedStringWithOptions:0];
    return ret;
}

+ (NSString *)encryptString:(NSString *)string key:(NSString *)key iv:(NSString *)iv
{
    if (!string || [string isKindOfClass:[NSNull class]]) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:key
                                         iv:iv];
    AESData = [AESData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *result = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSString *)decryptString:(NSString *)string key:(NSString *)key iv:(NSString *)iv
{
    if (!string || [string isKindOfClass:[NSNull class]]) return nil;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    NSData *AESData = [self AES128operation:kCCDecrypt
                                       data:data
                                        key:key
                                         iv:iv];
    NSString *result = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    return result;
}

+ (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    /// 流数据是否存在
    if ((data == nil) || (data == NULL)) { return nil;}
    else if (![data isKindOfClass:[NSData class]]) { return nil;}
    else if ([data length] <= 0) { return nil;}
    
    /// Key是否存在
    if ((key == nil) || (key == NULL)) { return nil;}
    else if (![key isKindOfClass:[NSString class]]) { return nil;}
    else if ([key length] <= 0) { return nil;}
    
    /// 偏移量是否存在
    if ((iv == nil) || (iv == NULL)) { return nil;}
    else if (![iv isKindOfClass:[NSString class]]) { return nil;}
    else if ([iv length] <= 0) { return nil;}
    
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
        这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
    */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

@end
