//
//  PersonCenterViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/4/10.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "PersonCenterViewController.h"


@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation PersonCenterViewController

- (NSMutableArray *)items {
    if (!_items) {
        NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"sprotRecord.plist"];
        _items = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动";
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    return cell;
}

@end
