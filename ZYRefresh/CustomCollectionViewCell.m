//
//  CustomCollectionViewCell.m
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/10.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UIView *view;
@end

@implementation CustomCollectionViewCell

- (void)setModel:(ColorModel *)model {
    _model = model;
    
    self.view.backgroundColor = model.color;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
