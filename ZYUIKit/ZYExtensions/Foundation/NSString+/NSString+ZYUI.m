//
//  NSString+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "NSString+ZYUI.h"

@implementation NSString (ZYUI)

- (NSString *)zy_convertFileSize
{
    NSString *string = self;
    NSInteger byte = [self integerValue];
    if (byte == 0) {
        string = @"0KB";
    }else{
        if (byte < 1024 * 1024) {
            NSInteger index = byte / 1024;
            string = [NSString stringWithFormat:@"%ldKB",index];
        }else{
            if (byte < 1024 * 1024 * 1024) {
                CGFloat index = byte / 1024.0 / 1024.0;
                string = [NSString stringWithFormat:@"%0.2fMB",index];
            }else{
                CGFloat index = byte / 1024.0 / 1024.0 / 1024.0;
                string = [NSString stringWithFormat:@"%0.2fGB",index];
            }
        }
    }
    return string;
}

+ (NSString *)zy_dicToJson:(NSDictionary *)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
        return @"";
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
