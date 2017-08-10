//
//  UITableView+PlaceHolderView.m
//  PlaceHolderView
//
//  Created by FYXin on 2017/4/14.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "UITableView+PlaceHolderView.h"
#import <objc/runtime.h>


@implementation UITableView (PlaceHolderView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(reloadData);
        SEL swizzledSelector = @selector(yx_reloadData);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }

    });
}

- (void)yx_reloadData {
    if (!self.firstReload) {
        [self checkEmpty];
    }
    self.firstReload = NO;
    [self yx_reloadData];
}


- (void)checkEmpty {
    BOOL isEmpty = YES; //标志
    
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1; //默认一组
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];
        if (rows) {
            isEmpty = NO; //若rows > 0 ,不为空
        }
    }
    
    if (isEmpty) { //如果为空,加载占位图
        if (!self.placeHolderView) {
            [self configDefaultPlaceholderView];
        }
        self.placeHolderView.hidden = NO;
        [self addSubview:self.placeHolderView];
    } else {  //移除占位图
        self.placeHolderView.hidden = YES;
    }
}

- (void)configDefaultPlaceholderView {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
    label.text = @"暂无数据";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    label.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitle:@"点击屏幕，重新加载" forState:UIControlStateNormal];
    button.center = CGPointMake(label.center.x,CGRectGetMaxY(label.frame)+ button.frame.size.height);
    [view addSubview:button];
    
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    
    self.placeHolderView = view;
    
}

- (void)btn{
    NSLog(@"123456");
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)())reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)())reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY);
}

@end



@interface NodataView : UIView

@end


@implementation NodataView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
