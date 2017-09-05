//
//  ViewController.m
//  ZYRefresh
//
//  Created by 张祎 on 2017/8/9.
//  Copyright © 2017年 张祎. All rights reserved.
//

#import "ViewController.h"
#import "ZYRefresh.h"
#import "CustomCollectionViewCell.h"

#define BARandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据
    [self buildData];

    //创建集合视图
    [self createCollectionView];
    
    //添加刷新和加载控件
    [self addHeaderAndFooter];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, 300, 300) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    
    layout.itemSize = CGSizeMake(100, self.collectionView.frame.size.height - 20);
}

- (void)addHeaderAndFooter {
    
    __weak typeof(self) weakSelf = self;
    
    self.collectionView.zy_header = [ZYRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    
    self.collectionView.zy_footer = [ZYRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

- (void)refreshData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self buildData];
        [self.collectionView.zy_header endRefreshing];
        [self.collectionView reloadData];
    });
}

- (void)buildData {
    self.arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        UIColor *color = BARandomColor;
        [self.arr addObject:[self colorModelWithColor:color]];
    }
}

- (ColorModel *)colorModelWithColor:(UIColor *)color {
    ColorModel *model = [[ColorModel alloc] init];
    model.color = color;
    return model;
}

- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 3; i++) {
            UIColor *color = BARandomColor;
            [self.arr addObject:[self colorModelWithColor:color]];
        }
        [self.collectionView.zy_footer endRefreshing];
        [self.collectionView reloadData];
    });
}

- (void)action {
    [self.scrollView.zy_header beginRefreshing];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.arr[indexPath.item];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
