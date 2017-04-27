//
//  UITableView+PlaceHolderView.h
//  PlaceHolderView
//
//  Created by FYXin on 2017/4/14.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (PlaceHolderView)

@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeHolderView;

@property (nonatomic, copy) void(^reloadBlock)();

@end
