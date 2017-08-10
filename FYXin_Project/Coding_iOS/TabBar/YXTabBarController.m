//
//  YXTabBarController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/2.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "YXTabBarController.h"
#import "YXTabBar.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

#import "ScrollViewComplexController.h"
#import "FPagesViewController.h"

@interface YXTabBarController ()<YXTabBarDelegate>

@end

@implementation YXTabBarController


+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildVC];
    
    YXTabBar *tabBar = [[YXTabBar alloc] init];
    tabBar.plusDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupChildVC {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setupChildVC:homeVC image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self setupChildVC:secondVC image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];
    
   // ScrollViewComplexController *messageVC = [[ScrollViewComplexController alloc] init];
    FPagesViewController *messageVC = [[FPagesViewController alloc] init];
    [self setupChildVC:messageVC image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setupChildVC:mineVC image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
}

- (void)setupChildVC:(UIViewController *)viewController image:(NSString *)imageString selectedImage:(NSString *)selectedImageString title:(NSString *)title {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    UIImage *normalImage = [UIImage imageNamed:imageString];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    
    UIImage *selectImage = [UIImage imageNamed:selectedImageString];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectImage;
    
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}

#pragma mark - TabBarDelegate
- (void)tabbarPlusClick:(YXTabBar *)tabbar {
    NSLog(@"点击");
}


@end
