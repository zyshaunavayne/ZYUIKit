//
//  ZYMD5Crypt.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/13.
//

#import "ZYMD5Crypt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ZYMD5Crypt

+ (NSString *)ZYMd5EncryptionWithString:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
        
    }
    //    output = [output uppercaseString];
    return  output;
}

@end
