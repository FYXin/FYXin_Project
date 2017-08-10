//
//  IFactoryView.h
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IFactoryView <NSObject>

- (void)configViews:(NSArray *)views;

- (NSArray *)getViews;

@end
