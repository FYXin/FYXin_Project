//
//  MineViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/3.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self request_A];
//    [self request_B];
//    [self request_C];
//    NSLog(@"全部完成");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request_A {
    NSLog(@"A");
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"任务A开始前");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        NSLog(@"任务A完成");
        dispatch_semaphore_signal(sem);
    });
    NSLog(@"A+");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"A-");
}

- (void)request_B {
    NSLog(@"B");
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"任务B开始前");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        NSLog(@"任务B完成");
        dispatch_semaphore_signal(sem);
    });
    NSLog(@"B+");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"B-");
}

- (void)request_C {
    NSLog(@"C");
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"任务C开始前");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(5);
        NSLog(@"任务C完成");
        dispatch_semaphore_signal(sem);
    });
    NSLog(@"C+");
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"C-");
}



@end
