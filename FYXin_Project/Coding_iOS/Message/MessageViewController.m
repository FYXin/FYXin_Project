//
//  MessageViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/3.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "MessageViewController.h"

#import <Masonry.h>
#import "InfoView.h"
#import "HandlerView.h"
#import "DoAllTypeView.h"
#import "TimeLimitedView.h"

@interface MessageViewController ()

{
    DoAllTypeView *doall;
    TimeLimitedView *_time;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    InfoView *info = [[InfoView alloc] initWithFrame:self.view.bounds];
    UIView *view = [info getView];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.height.equalTo(@(view.frame.size.height));
    }];
    
    DoAllTypeView *doAll = [[DoAllTypeView alloc] initWithFrame:self.view.bounds];
    UIView *doAllView = [doAll getView];
    [doAll configWithData:@[@(1),@(2),@(4)]];
    [self.view addSubview:doAllView];
    
    doall = doAll;
    
    [doAllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(view.mas_bottom).offset(5);
        make.height.equalTo(@([doAll getViewHeight]));
    }];
    
    TimeLimitedView *time = [[TimeLimitedView alloc] initWithFrame:self.view.bounds];
    UIView *timeView = [time getView];
    [self.view addSubview:timeView];
    
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(doAllView.mas_bottom);
        make.height.equalTo(@([time getViewHeight]));
    }];
    _time = time;

    return;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
