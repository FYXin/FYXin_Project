//
//  HomeTableViewItem.h
//  FYXin_Project
//
//  Created by FYXin on 2017/5/4.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "KtTableViewBaseItem.h"

@interface HomeTableViewItem : KtTableViewBaseItem

@property (nonatomic, copy) NSString *headImage;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *category;

@end
