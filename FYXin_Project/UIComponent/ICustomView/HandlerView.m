//
//  HandlerView.m
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "HandlerView.h"
#import <Masonry.h>


@interface HandlerView ()

/**
 主体视图
 */

@property (nonatomic, strong) UIScrollView *view;
//
/**
 子视图数组
 */
@property (nonatomic, strong) NSMutableArray<UIView *> *subViews;

/**
 子视图的Class类
 */
@property (nonatomic, strong) NSArray<Class> *subViewClasses;

@end

@implementation HandlerView

- (void)configViews:(NSArray *)views {
    _subViewClasses = [NSArray arrayWithArray:views];
    
    for (NSInteger i = 0; i < _subViewClasses.count; i++) {
        Class clazz = _subViewClasses[i];
        id<ICustomView> obj = [[clazz alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        UIView *subView = [obj getView];
        [_view addSubview:subView];
        [_subViews addObject:subView];
        
        if (_subViewClasses.count == 1) {
            
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(_view);
                make.top.equalTo(_view);
                
                // make.edges.equalTo(_view);
            }];
            
        } else if (i == 0) {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_view.mas_top);
                make.left.equalTo(_view.mas_left);
                make.right.equalTo(_view.mas_right);
                make.height.mas_equalTo(@(subView.frame.size.height));
            }];
        } else if (i > 0 && i < _subViewClasses.count - 1) {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(_view);
                make.top.equalTo(_subViews[i-1].mas_bottom);
                make.bottom.equalTo(@(subView.frame.size.height));
            }];
        } else {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.and.right.equalTo(_view);
                make.top.equalTo(_subViews[i-1].mas_bottom);
                make.bottom.equalTo(_view.mas_bottom);
            }];
        }
        
    }
    
}

- (NSArray *)getViews {
    return _subViews;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _view = [[UIScrollView alloc] initWithFrame:frame];
        _view.backgroundColor = [UIColor purpleColor];
        
    }
    return self;
}


- (UIView *)getView {
    return _view;
}

@end
