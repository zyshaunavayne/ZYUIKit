//
//  UITableView+ZYUI.h
//  ZYUIKit
//
//  Created by 张宇 on 2023/2/8.
//

#import <UIKit/UIKit.h>

@interface UITableView (ZYUI)

/// 检测是否是最后一个元素
/// @param indexPath indexPath
- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath;

/// 检测是否是最后一个元素
/// @param indexPath indexPath
/// @param lineView 自定义分割线view
- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath
                                lineView:(UIView *)lineView;
/// 检测是否是最后一个元素
/// @param indexPath indexPath
/// @param elementCount 自定义count
/// @param lineView 自定义分割线view
- (BOOL)zy_lastElementForRowAtIndexPath:(NSIndexPath *)indexPath
                            elementCount:(NSInteger)elementCount
                                lineView:(UIView *)lineView;
@end

