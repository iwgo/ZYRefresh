//
//  UIScrollView+ZYRefresh.m
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "UIScrollView+ZYRefresh.h"
#import <objc/runtime.h>


@implementation UIScrollView (ZYRefresh)

@dynamic zy_header;
@dynamic zy_footer;

static const NSString *ZYRefreshHeaderKey = @"ZYRefreshHeaderKey";
static const NSString *ZYRefreshFooterKey = @"ZYRefreshFooterKey";

#pragma mark - setter & getter

/*
 由于分类中不能添加属性  所以这里用runtime来做属性赋值
 这里用assign弱引用 不增加引用计数
 */

- (void)setZy_header:(ZYRefreshHeader *)zy_header {
    
    if (zy_header != self.zy_header) {
        [self.zy_header removeFromSuperview];
        zy_header.frame = CGRectMake(-64, 0, 64, self.frame.size.height);
        [self insertSubview:zy_header atIndex:0];
        objc_setAssociatedObject(self, &ZYRefreshHeaderKey, zy_header, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (ZYRefreshHeader *)zy_header {
    return objc_getAssociatedObject(self, &ZYRefreshHeaderKey);
}

- (void)setZy_footer:(ZYRefreshFooter *)zy_footer {
    
    if (zy_footer != self.zy_footer) {
        [self.zy_footer removeFromSuperview];
        [self insertSubview:zy_footer atIndex:0];
        objc_setAssociatedObject(self, &ZYRefreshFooterKey, zy_footer, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (ZYRefreshFooter *)zy_footer {
    return objc_getAssociatedObject(self, &ZYRefreshFooterKey);
}

@end
