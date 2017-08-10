//
//  UIView+YX_Add.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/8.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "UIView+YX_Add.h"

@implementation UIView (YX_Add)

- (UIViewController *)yx_currentViewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;

    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    
    return viewController;
}

@end
