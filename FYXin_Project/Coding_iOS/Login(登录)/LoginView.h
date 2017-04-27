//
//  LoginView.h
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)loginClickWith:(NSString *)userName pwd:(NSString *)password;

@end

@interface LoginView : UIView

@property (nonatomic,weak) id<LoginViewDelegate>delegate;

@end
