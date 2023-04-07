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

@end
