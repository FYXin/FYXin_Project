//
//  InfoView.m
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "InfoView.h"
#import "UIView+YYAdd.h"
#import <Masonry.h>

CGFloat const left_distance = 10;
CGFloat const right_distance = 10;
CGFloat const width = 120;

@interface InfoView ()<ICustomView>

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _view = [[UIView alloc] initWithFrame:frame];
        [self configViews];
    }
    return self;
}

- (UIView *)getView {
    return _view;
}


- (void)configViews {
    _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    _tagLabel.text = @"交办信息";
    _tagLabel.font = [UIFont systemFontOfSize:15];
    [_view addSubview:_tagLabel];
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(130, CGRectGetMidY(_tagLabel.frame)-20, _view.frame.size.width - 140, 40)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    [_view addSubview:_textField];
    
    _view.height = CGRectGetMaxY(_textField.frame);
    
}

@end
