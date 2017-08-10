//
//  KtBaseTableViewCell.m
//  KtTableView
//
//  Created by bestswifter on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KtBaseTableViewCell.h"
#import "KtTableViewBaseItem.h"
#import "UIView+YYAdd.h"



@implementation KtBaseTableViewCell

@synthesize object = _object;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setObject:(KtTableViewBaseItem *)object { // 子类在这个方法中解析数据
    _object = object;
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubtitle;
    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(KtTableViewBaseItem *)object indexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

@end
