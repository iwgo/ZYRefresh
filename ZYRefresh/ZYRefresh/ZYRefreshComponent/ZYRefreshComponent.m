//
//  ZYRefreshComponent.m
//  ZYRefresh
//
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "ZYRefreshComponent.h"

@interface ZYRefreshComponent ()

@end

@implementation ZYRefreshComponent

NSString *const ZYRefreshKeyPathContentOffset = @"contentOffset";
NSString *const ZYRefreshKeyPathContentSize = @"contentSize";

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    //移除对父视图KVO
    [self removeObserves];
    
    _scrollView = (UIScrollView *)newSuperview;
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, self.spanInset);

    
    _scrollViewOriginalInset = _scrollView.contentInset;
    
    //设置对新父控件的监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:ZYRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:ZYRefreshKeyPathContentSize options:options context:nil];
}

- (CGFloat)spanInset {
    return 32;
}

- (void)removeObserves {
    [self.scrollView removeObserver:self forKeyPath:ZYRefreshKeyPathContentOffset];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:ZYRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:ZYRefreshKeyPathContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

- (void)setState:(ZYRefreshState)state {
    _state = state;
}

- (BOOL)islessThanScrollViewWidth {
    return self.scrollView.contentSize.width < self.scrollView.frame.size.width;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
