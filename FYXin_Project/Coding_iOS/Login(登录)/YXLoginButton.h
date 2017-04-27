//
//  YXLoginButton.h
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXLoginButton : UIView

@property (nonatomic,copy) void(^ClickBlcok)();

- (void)resetAnimation;

@end
