//
//  ZYRefreshHeader.m
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "ZYRefreshHeader.h"
#import "Masonry.h"
#import "MRTransformLabel.h"

@interface ZYRefreshHeader ()
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *m_label;
@property (nonatomic, strong) MRTransformLabel *label;

@end


@implementation ZYRefreshHeader

+ (instancetype)headerWithRefreshingBlock:(void (^) (void))refreshingBlock {
    
    ZYRefreshHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"ZYRefreshHeader" owner:nil options:nil] objectAtIndex:0];
    header.state = ZYRefreshStateIdle;
    header.refreshingBlock = refreshingBlock;
    return header;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label = [[MRTransformLabel alloc] initWithFrame:CGRectZero type:Vertical];
    [self.m_label addSubview:self.label];
    [self.label autoLayout];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    //刷新临界点
    CGFloat critical_point = -64;
    
    if (self.state == ZYRefreshStateRefreshing) {
        return;
    }
    
    //区分拖拽和非拖拽状态
    if (self.scrollView.isDragging) {
        if (self.state == ZYRefreshStateIdle && self.scrollView.contentOffset.x < critical_point) {
            self.state = ZYRefreshStatePulling;
        } else if (self.state == ZYRefreshStatePulling && self.scrollView.contentOffset.x >= critical_point) {
            self.state = ZYRefreshStateIdle;
        }
    } else if (self.state == ZYRefreshStatePulling) {
        self.state = ZYRefreshStateRefreshing;
        //刷新回调
        self.refreshingBlock ? self.refreshingBlock() : nil;
    }
}

- (void)setState:(ZYRefreshState)state {
    
    [super setState:state];
    
    //根据状态改变控件样式和父视图contentInset
    switch (state) {
            
        case ZYRefreshStateIdle: {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsZero;
            }];
            self.label.text = @"右拉刷新...";
            break;
        }
            
        case ZYRefreshStatePulling: {
            self.label.text = @"松开刷新...";
            break;
        }
            
        case ZYRefreshStateRefreshing: {
            [UIView animateWithDuration:0.25 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 64, 0, 0);
                [self.scrollView setContentOffset:CGPointMake(-64, 0)];
            }];
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

- (void)endRefreshing {
    self.state = ZYRefreshStateIdle;
}

- (void)beginRefreshing {
    
    if (self.state == ZYRefreshStateRefreshing) {
        return;
    }
    
    self.state = ZYRefreshStateRefreshing;
    self.refreshingBlock ? self.refreshingBlock() : nil;
    [self.scrollView setContentOffset:CGPointMake(-64, 0) animated:YES];
}

@end
