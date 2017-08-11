//
//  ZYRefreshComponent.h
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, ZYRefreshState) {
    /** 普通闲置状态 */
    ZYRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    ZYRefreshStatePulling,
    /** 正在刷新中的状态 */
    ZYRefreshStateRefreshing,
    /** 即将刷新的状态 */
    ZYRefreshStateWillRefresh,
    /** 所有数据加载完毕，没有更多的数据了 */
    ZYRefreshStateNoMoreData
};

@interface ZYRefreshComponent : UIView

/** 刷新状态 */
@property (nonatomic, assign) ZYRefreshState state;

/** 刷新回调block */
@property (nonatomic, copy) void (^refreshingBlock) (void);

/** 父视图 */
@property (nonatomic, weak) UIScrollView *scrollView;

/** contentSise是否小于Scroll */
@property (nonatomic, assign, getter=islessThanScrollViewWidth) BOOL lessThanScrollViewWidth;

/** 记录scrollView刚开始的inset */
@property (nonatomic, assign)  UIEdgeInsets scrollViewOriginalInset;

/** */
@property (nonatomic, assign) CGFloat spanInset;

/**
 父视图contentOffset改变
 @param change 值
 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;

/**
 父视图contentOffset改变
 @param change 值
 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;




@end
