//
//  ZYRefreshFooter.h
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRefreshComponent.h"

@interface ZYRefreshFooter : ZYRefreshComponent

/**
 初始化footer
 @param refreshingBlock 刷新回调
 @return instancetype
 */
+ (instancetype)footerWithRefreshingBlock:(void (^) (void))refreshingBlock;

/**
 结束刷新
 */
- (void)endRefreshing;
@end
