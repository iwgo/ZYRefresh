//
//  MRTransformLabel.h
//  MongolianReadProject
//
//  Created by 张祎 on 2017/5/24.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MRTransformLabelFontType) {
    Vertical,
    Mirror,
};

/**
 此label用于蒙古文显示
 有两种状态 一种是顺时针旋转90度 用于显示单行
 一种是顺时针旋转90度水平翻转用于显示多行
 */
@interface MRTransformLabel : UILabel

@property (nonatomic, assign) NSInteger fontSize;

/**
 初始化旋转TransformLabel
 @param frame 尺寸
 @param type 类型 竖直/镜像
 @return label对象
 */
- (instancetype)initWithFrame:(CGRect)frame type:(MRTransformLabelFontType)type;

/**
 设置文字大小(专用方法)
 @param size 文字的大小
 */
- (void)setFontWithSize:(CGFloat)size;

/**
 取出蒙古文
 @return 一段设定好的蒙古文 用于测试蒙文排版
 */
+ (NSString *)autoMonString;

/**
 自动与父视图保持同等大小
 */
- (void)autoLayout;

@end
