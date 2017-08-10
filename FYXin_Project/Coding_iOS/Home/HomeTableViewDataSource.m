//
//  HomeTableViewDataSource.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/4.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "HomeTableViewDataSource.h"
#import "KtTableViewSectionObject.h"
#import "HomeTableViewItem.h"
#import "KtBaseTableViewCell.h"
#import "HomeTableViewCell.h"

@implementation HomeTableViewDataSource

- (instancetype)init {
    if (self = [super init]) {
        [self configData];
    }
    return self;
}


- (void)configData {
    KtTableViewSectionObject *firstSectionObject = [[KtTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        [self createItem],
                                                                                                        nil]];
    self.sections = [NSMutableArray arrayWithObject:firstSectionObject];
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(KtTableViewBaseItem *)object indexPath:(NSIndexPath *)indexPath {
    return [HomeTableViewCell class];
}

- (HomeTableViewItem *)createItem {
    HomeTableViewItem *item = [[HomeTableViewItem alloc] init];
    item.headImage = @"headIcon";
    item.name = @"网格巡查人员001";
    item.time = [[NSDate date] timeIntervalSince1970];
    item.content = @"最近，关于图片圆角的话题讨论非常激烈，出现了许多好的文章。恰逢工作需要，用到了大量圆角图片。然而，系统圆角会导致离屏渲染的问题，出于性能考虑，于是有了图片圆角渲染工具HJCornerRadius，其最大优势在于使用简单，一行搞定图片圆角";
    item.address = @"东风路与金水路交叉口";
    item.images = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg"];
    
    return item;
}

@end
