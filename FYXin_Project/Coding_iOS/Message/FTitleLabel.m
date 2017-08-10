//
//  FTitleLabel.m
//  FYXin_Project
//
//  Created by FYXin on 2017/6/21.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "FTitleLabel.h"

@implementation FTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
    }
    return self;
}



/**
 通过scale的改变 改变字体大小
 */
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat realScale = minScale + (1 - minScale) * scale;
    
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
}

@end
