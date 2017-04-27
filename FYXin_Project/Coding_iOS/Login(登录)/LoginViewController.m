//
//  LoginViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/4/10.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景图层
    CAGradientLayer *grandiendLayer = [CAGradientLayer layer];
    grandiendLayer.frame = self.view.bounds;
    grandiendLayer.colors = @[(__bridge id)[UIColor purpleColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
//    grandiendLayer.startPoint = CGPointMake(0.5, 0);
//    grandiendLayer.endPoint = CGPointMake(0.5, 1);
    grandiendLayer.locations = @[@0.5,@1];
    
    [self.view.layer addSublayer:grandiendLayer];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [self.view addSubview:loginView];
    loginView.center = self.view.center;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.center = CGPointMake(self.view.bounds.size.width/2, 150);
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"FYXin";
    label.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:label];
    

    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    registerLabel.center = CGPointMake(label.center.x, self.view.bounds.size.height - 60);
    registerLabel.textColor = [UIColor whiteColor];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    registerLabel.text = @"还没有账号？ 注册一个吧！";
    registerLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:registerLabel];
    registerLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [registerLabel addGestureRecognizer:tap];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        NSLog(@"runloop启动前");
        CFRunLoopRun();
        NSLog(@"runLoop启动后");
    });
}

- (void)updateTimer {
    
    static int num = 0;
    
    NSLog(@"%d %@", num++, [NSThread currentThread]);
    
    // 满足条件后，停止当前的运行循环
    if (num == 8) {
        
        // 一旦停止了运行循环，后续代码能够执行，执行完毕后，线程被自动销毁
        CFRunLoopStop(CFRunLoopGetCurrent());
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}



@end
