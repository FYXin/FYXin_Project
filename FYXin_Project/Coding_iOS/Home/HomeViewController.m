//
//  HomeViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/3.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "HomeViewController.h"
#import "KtBaseTableView.h"
#import "UIImage+YYAdd.h"
#import <Masonry.h>
#import "HomeTableViewDataSource.h"
#import "HomeTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "KtTableViewSectionObject.h"

@interface HomeViewController ()<KtTableViewDelegate>

@property (nonatomic, strong) KtBaseTableView *tableView;

@property (nonatomic, strong) KtTableViewDataSource *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSource];
    _tableView = [[KtBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.ktDataSource = self.dataSource;
    _tableView.ktDelegate = self;
    _tableView.isNeedPullDownToRefreshAction = YES;
    _tableView.isNeedPullUpToRefreshAction = YES;
    [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


- (void)creatDataSource {
    self.dataSource = [[HomeTableViewDataSource alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pullUpToRefreshAction {
    NSLog(@"上啦加载");
    
    __weak typeof(_tableView) weakTableView = _tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakTableView stopRefreshingAnimation];
    });
}

- (void)pullDownToRefreshAction {
    NSLog(@"下拉刷新");
    __weak typeof(_tableView) weakTableView = _tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakTableView stopRefreshingAnimation];
    });;
}

@end
