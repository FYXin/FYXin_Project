//
//  YXTabBar.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/2.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "YXTabBar.h"
#import "UIImage+YYAdd.h"
#import "UIView+YYAdd.h"

@interface YXTabBar ()

@property (nonatomic, strong) UIButton *plusBtn;

@property (nonatomic, strong) UILabel *plusLabel;

@end

@implementation YXTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"发布";
        label.font = [UIFont systemFontOfSize:11.f];
        [label sizeToFit];
        label.textColor = [UIColor grayColor];

        self.plusLabel = label;
        [self addSubview:label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    Class class = NSClassFromString(@"UITabBarButton");
    self.plusBtn.centerX = self.centerX;
    
    self.plusBtn.centerY = self.height * 0.5 - 20;
    
    self.plusLabel.centerX = self.plusBtn.centerX;
    self.plusLabel.centerY = CGRectGetMaxY(self.plusBtn.frame) + 10;
    
    int btnIndex = 0;
    
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.width = self.width / 5;
            btn.left = btn.width * btnIndex;
            btnIndex++;
            
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

- (void)plusBtnDidClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(tabbarPlusClick:)]) {
        [self.plusDelegate tabbarPlusClick:self];
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newPoint = [self convertPoint:point toView:self.plusBtn];
        
        if ([self.plusBtn pointInside:newPoint withEvent:event]) {
            return  self.plusBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}
@end
