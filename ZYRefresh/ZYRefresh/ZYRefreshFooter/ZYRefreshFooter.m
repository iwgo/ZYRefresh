//
//  ZYRefreshFooter.m
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "ZYRefreshFooter.h"
#import "Masonry.h"
#import "MRTransformLabel.h"

@interface ZYRefreshFooter ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *m_label;
@property (nonatomic, strong) MRTransformLabel *label;
@end

@implementation ZYRefreshFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label = [[MRTransformLabel alloc] initWithFrame:CGRectZero type:Vertical];
    [self.m_label addSubview:self.label];
    [self.label autoLayout];
}

+ (instancetype)footerWithRefreshingBlock:(void (^) (void))refreshingBlock {
    
    ZYRefreshFooter *footer = [[[NSBundle mainBundle] loadNibNamed:@"ZYRefreshFooter" owner:nil options:nil] objectAtIndex:0];
    footer.state = ZYRefreshStateIdle;
    footer.refreshingBlock = refreshingBlock;
    return footer;
}

- (void)endRefreshing {
    self.state = ZYRefreshStateIdle;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    if (self.state == ZYRefreshStateRefreshing) {
        return;
    }

    CGFloat critical_point = [self critical_point];
    
//    NSLog(@"临界点 : %lf offset: %lf contentSize: %lf", critical_point, self.scrollView.contentOffset.x, self.scrollView.contentSize.width);
    
    if (self.scrollView.isDragging) {
        if (self.state == ZYRefreshStateIdle && self.scrollView.contentOffset.x > critical_point) {
            self.state = ZYRefreshStatePulling;
        } else if (self.state == ZYRefreshStatePulling && self.scrollView.contentOffset.x <= critical_point) {
            self.state = ZYRefreshStateIdle;
        }
    } else {
        if (self.state == ZYRefreshStatePulling) {
            self.state = ZYRefreshStateRefreshing;
            self.refreshingBlock ? self.refreshingBlock() : nil;
        }
    }
}

//计算刷新临界值
- (CGFloat)critical_point {
    CGFloat w = self.scrollView.frame.size.width - 64 - self.spanInset;
    CGFloat deltaH = self.scrollView.contentSize.width - w;
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return 64 + self.spanInset;
    }
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    
    if (self.lessThanScrollViewWidth) {
        //如果contentSize宽度scrollview小  就把刷新控件放到scrollView右端
        self.frame = CGRectMake(self.scrollView.frame.size.width, 0, 64, self.scrollView.frame.size.height);
    } else {
        //如果contentSize宽度scrollview大  就把刷新控件放到contentSize右端
        self.frame = CGRectMake(self.scrollView.contentSize.width + self.spanInset, 0, 64, self.scrollView.frame.size.height);
    }
}

- (void)setState:(ZYRefreshState)state {
    
    [super setState:state];
    
    //根据状态改变控件样式和父视图contentInset
    switch (state) {
            
        case ZYRefreshStateIdle: {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentInset = self.scrollViewOriginalInset;
            }];
            self.label.text = @"左拉加载更多...";
            break;
        }
            
        case ZYRefreshStatePulling: {
            self.label.text = @"松开刷新...";
            break;
        }
            
        case ZYRefreshStateRefreshing: {
            if (self.islessThanScrollViewWidth) {
                CGFloat w = self.scrollView.frame.size.width - self.scrollView.contentSize.width + 64;
                [UIView animateWithDuration:0.25 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, w);
                }];
            }else {
                [UIView animateWithDuration:0.25 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 64 + self.spanInset);
                }];
            }
            self.label.text = @"正在刷新...";
            break;
        }
            
        default:
            break;
    }
    
    if (self.state == ZYRefreshStateRefreshing) {
        self.activityIndicatorView.hidden = NO;
    }else {
        self.activityIndicatorView.hidden = YES;
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
