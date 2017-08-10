//
//  RegisterViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/4/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "RegisterViewController.h"
#import <Masonry.h>
#import "UIColor+YYAdd.h"
#import "NSString+Regex.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneNumTextField;

@property (nonatomic, strong) UITextField *identifyTextField;

@property (nonatomic, strong) UIButton *timerButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI {
    _phoneNumTextField = [[UITextField alloc] init];
    _phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumTextField.placeholder = @"请输入手机号码";
    _phoneNumTextField.delegate = self;
    [self.view addSubview:_phoneNumTextField];
    
    _timerButton = [[UIButton alloc] init];
    _timerButton.enabled = NO;
    [self.view addSubview:_timerButton];
    _timerButton.layer.masksToBounds = YES;
    _timerButton.layer.cornerRadius = 5;
    _timerButton.backgroundColor = [UIColor lightGrayColor];
    [_timerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [_timerButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_timerButton addTarget:self action:@selector(timer:) forControlEvents:UIControlEventTouchUpInside];
    
    _identifyTextField = [UITextField new];
    _identifyTextField.borderStyle = UITextBorderStyleRoundedRect;
    _identifyTextField.placeholder = @"请输入验证码";
    [self.view addSubview:_identifyTextField];
    
    UIButton *registerButton = [UIButton new];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.backgroundColor = [UIColor yy_buttonColor];
    [self.view addSubview:registerButton];
    [registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.view.frame.size.height/4);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.timerButton.mas_left).offset(-20);
        make.height.equalTo(@40);
        
    }];
    
    [_timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNumTextField);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(_phoneNumTextField.mas_height);
    }];
    
    
    [_identifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumTextField);
        make.size.equalTo(self.phoneNumTextField);
        make.top.equalTo(self.phoneNumTextField.mas_bottom).offset(10);
    }];
    
}



- (void)timer:(UIButton *)button {
    
    __block NSInteger count = 60;
    
    [_timerButton setTitle:@"剩余60s" forState:UIControlStateNormal];
    
    __weak typeof(_timerButton) weakButton = _timerButton;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        NSString *string = [NSString stringWithFormat:@"剩余%lds",--count];
        [weakButton setTitle:string forState:UIControlStateNormal];
        if (count == 0) {
            [timer invalidate];
        }
    }];
}



- (void)registerClick {


}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if (textField.text.length + string.length < 12) {
        return YES;
    }
    return NO;
}

@end
