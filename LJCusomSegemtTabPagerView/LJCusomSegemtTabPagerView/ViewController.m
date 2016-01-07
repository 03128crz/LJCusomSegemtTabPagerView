//
//  ViewController.m
//  LJCusomSegemtTabPagerView
//
//  Created by james on 16/1/6.
//  Copyright © 2016年 kfvnx. All rights reserved.
//

#import "ViewController.h"
#import "LJCusomSegemtTabPagerView.h"
#import "DetailViewController.h"

@interface ViewController ()<LJCusomSegemtTabPagerViewDelegate>
@property (nonatomic, strong) LJCusomSegemtTabPagerView *segmentTabPagerView;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataList = @[@"推荐", @"大数据", @"跨境电商", @"移动电商", @"双二十测试", @"互联网", @"O2O", @"行家面对面", @"同学会"];
    
    CGRect frame = self.view.frame;
    frame.origin.y = 30;
    
    _segmentTabPagerView = [[LJCusomSegemtTabPagerView alloc] initWithFrame:frame];
    _segmentTabPagerView.titles = _dataList;
    //_segmentTabPagerView.titleUnitedWith = 375/3;
    _segmentTabPagerView.indicaterSameWidthWithTitle = YES;
    _segmentTabPagerView.delegate = self;
    //_segmentTabPagerView.titleColor = [UIColor grayColor];
    //_segmentTabPagerView.titleHighlightColor = [UIColor redColor];
    [self.view addSubview:_segmentTabPagerView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [_segmentTabPagerView addDefaultVCWithBlock:^(UIView *contentView, NSString *title) {
        DetailViewController *vc = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        vc.view.frame = contentView.bounds;
        vc.channelTitle = title;
        [contentView addSubview:vc.view];
        [weakSelf addChildViewController:vc];
    }];
    [_segmentTabPagerView defaultTitleClick];
}

-(void)pagerContentView:(UIView *)view didSelectTitle:(NSString *)title {
    DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.view.frame = view.bounds;
    vc.channelTitle = title;
    [view addSubview:vc.view];
    [self addChildViewController:vc];
}

@end
