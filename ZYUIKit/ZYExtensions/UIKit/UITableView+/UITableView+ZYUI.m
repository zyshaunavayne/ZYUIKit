//
//  UITableView+ZYUI.m
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import "UITableView+ZYUI.h"

@implementation UITableView (ZYUI)

- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// tableview 最后的元素 (分组分开计算)
    if (indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1) {
        return YES;
    }
    return NO;
}

- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath
                                lineView:(UIView *)lineView
{
    if ([self zy_lastElementForRowAtIndexPath:indexPath]) {
        if (lineView) { lineView.hidden = YES;}
        return YES;
    }
    if (lineView) { lineView.hidden = NO; }
    return NO;
}

- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath
                            elementCount:(NSInteger)elementCount
                                lineView:(UIView *)lineView
{
    /// tableview 最后的元素 (分组分开计算)
    if (indexPath.row == elementCount - 1) {
        if (lineView) { lineView.hidden = YES;}
        return YES;
    }
    if (lineView) { lineView.hidden = NO;}
    return NO;
}

@end
