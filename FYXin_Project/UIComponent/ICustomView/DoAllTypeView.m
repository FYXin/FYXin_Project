//
//  ActionSelectView.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "DoAllTypeView.h"
#import "DLRadioButton.h"
#import "UIView+YYAdd.h"
#import <Masonry.h>

@interface DoAllTypeView ()

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation DoAllTypeView

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
    _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    _tagLabel.font = [UIFont systemFontOfSize:15];
    _tagLabel.text = @"办理方式";
    [_view addSubview:_tagLabel];
    _height = CGRectGetMaxY(_tagLabel.frame);
}

- (id)configWithData:(NSArray *)doTypes {
    NSDictionary *doAll_dict = @{@(1):@"上报",@(2):@"交办办理",@(4):@"办结",@(5):@"反馈",@(6):@"办理",@(61):@"自行办理",@(8):@"退办",@(98):@"申请延期",@(99):@"延期"};
   
    
    DLRadioButton *tempButton;
    NSMutableArray *others = @[].mutableCopy;
    UIView *lastView = nil;
    for (NSInteger i = 0; i < doTypes.count; i++) {
        
        NSString *title = doAll_dict[doTypes[i]];
        DLRadioButton *button = [[DLRadioButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tagLabel.frame), 0, 150, 30)];
        button.centerY = CGRectGetMidY(_tagLabel.frame) + 30 * i;
        button.iconColor = [UIColor blackColor];
        button.indicatorColor = [UIColor blackColor];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.iconSize = 20;
        [button addTarget:self action:@selector(radioButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_view addSubview:button];
        if (i == 0) {
            tempButton = button;
        } else {
            [others addObject:button];
            _height = CGRectGetMaxY(button.frame);
        }
        lastView = button;
        
    }
    tempButton.otherButtons = others.copy;
    
      return nil;
}

- (void)radioButtonClick:(DLRadioButton *)button {
    NSLog(@"xuanze");
}


- (void)dealloc {
    NSLog(@"dealloc");
}

@end
