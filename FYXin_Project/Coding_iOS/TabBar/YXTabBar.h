//
//  YXTabBar.h
//  FYXin_Project
//
//  Created by FYXin on 2017/5/2.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXTabBar;

@protocol YXTabBarDelegate <NSObject>

@optional
- (void)tabbarPlusClick:(YXTabBar *)tabbar;

@end


@interface YXTabBar : UITabBar

@property (nonatomic, weak) id<YXTabBarDelegate> plusDelegate;

@end
