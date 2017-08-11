//
//  ZYRefreshHeader.h
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRefreshComponent.h"
#import <Foundation/Foundation.h>

@interface ZYRefreshHeader : ZYRefreshComponent

/**
 初始化header
 @param refreshingBlock 刷新回调
 @return instancetype
 */
+ (instancetype)headerWithRefreshingBlock:(void (^) (void))refreshingBlock;

/**
 开始刷新
 */
- (void)beginRefreshing;

/**
 结束刷新
 */
- (void)endRefreshing;
@end
