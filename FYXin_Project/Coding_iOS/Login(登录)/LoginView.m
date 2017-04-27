//
//  LoginView.m
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "LoginView.h"
#import "YXTextField.h"
#import "YXLoginButton.h"

@interface LoginView ()

@property (nonatomic,strong) YXTextField *user;
@property (nonatomic,strong) YXTextField *password;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    [self configUI];
    
    return self;
}

- (void)configUI {
    _user = [[YXTextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.8, 30)];
    _user.center = CGPointMake(self.frame.size.width / 2, CGRectGetHeight(_user.frame)/2);
    _user.yx_placeholder = @"用户名";
    [self addSubview:_user];
    
    _password = [[YXTextField alloc] initWithFrame:_user.bounds];
    _password.center = CGPointMake(self.frame.size.width / 2, _user.center.y + 60);
    _password.yx_placeholder = @"密码";
    [self addSubview:_password];
    
    YXLoginButton *button = [[YXLoginButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 40)];
    button.center = CGPointMake(self.frame.size.width/2, _password.center.y + 60);
    [self addSubview:button];
    
    __weak typeof(self) weakSelf = self;
    button.ClickBlcok = ^(){
        if (!(_user.text.length > 0 && _password.text.length > 0)) {
            return ;
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(loginClickWith:pwd:)]) {
            [weakSelf.delegate loginClickWith:_user.text pwd:_password.text];
            
        }
    };
}

@end
