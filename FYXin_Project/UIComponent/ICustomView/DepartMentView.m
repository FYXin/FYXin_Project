//
//  DepartMentView.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/25.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "DepartMentView.h"
#import "DLRadioButton.h"

@interface DepartMentView ()

@property (nonatomic, strong) UIView *view;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation DepartMentView

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

- (CGFloat)getViewHeight {
    return _height;
}

- (void)configViews {
    _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    _tagLabel.text = @"区域单位";
    _tagLabel.font = [UIFont systemFontOfSize:15];
    [_view addSubview:_tagLabel];
}

@end
