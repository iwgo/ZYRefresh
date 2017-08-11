//
//  UIScrollView+ZYRefresh.h
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRefreshHeader.h"
#import "ZYRefreshFooter.h"

@interface UIScrollView (ZYRefresh)
@property (nonatomic, weak) ZYRefreshHeader *zy_header;
@property (nonatomic, weak) ZYRefreshFooter *zy_footer;
@end
