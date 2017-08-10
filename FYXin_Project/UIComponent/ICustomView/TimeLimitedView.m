//
//  TimeLimitedView.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/25.
//  Copyright © 2017年 FYXin. All rights reserved.
//


#import "TimeLimitedView.h"
#import "CCDatePickerView.h"

@interface TimeLimitedView ()

@property (nonatomic, strong) UIView *view;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIButton *button;

@end

@implementation TimeLimitedView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        _view = [[UIView alloc] initWithFrame:frame];
        [self configViews];
    }
    return self;
}

- (UIView *)getView {
    return _view;
}

- (CGFloat)getViewHeight {
    return _height;
}

- (void)configViews {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.text = @"办理时限";
    label.font = [UIFont systemFontOfSize:15];
    [_view addSubview:label];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), CGRectGetMidY(label.frame)- 15, _view.frame.size.width - CGRectGetMaxX(label.frame) - 10, 30)];
    [button addTarget:self action:@selector(timePick:) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:button];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1;
    
    _button = button;
    _height = CGRectGetMaxY(button.frame);
    
    CGRect frame = _view.frame;
    frame.size.height = _height;
    _view.frame = frame;
}

- (void)timePick:(UIButton *)btn {
    NSLog(@"1234");
    
    CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];

    [keywindow addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSLog(@"%@",dateString);
        NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        NSString *datestr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute];
        [_button setTitle:datestr forState:UIControlStateNormal];
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
    
}

@end
