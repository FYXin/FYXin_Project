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
#import "AppDelegate.h"

@interface LoginViewController ()<LoginViewDelegate>

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
    loginView.delegate = self;
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
    
}



- (void)tap:(UITapGestureRecognizer *)tap {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}


#pragma mark - LoginViewDelegate 
- (void)loginClickWith:(NSString *)userName pwd:(NSString *)password {
    NSLog(@"UserName:%@  PassWord:%@",userName,password);
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app changeRootVC];
}
@end
