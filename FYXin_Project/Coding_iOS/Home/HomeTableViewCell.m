//
//  HomeTableViewCell.m
//  FYXin_Project
//
//  Created by FYXin on 2017/5/4.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "HomeTableViewCell.h"
#import <Masonry.h>
#import "GeneralTool.h"
#import "UIImage+YYAdd.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView * headIcon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UICollectionView *imageContentView;

@property (nonatomic, strong) UILabel *contentTextLabel;
@property (nonatomic, strong) UILabel *address;

@end



@implementation HomeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
        [self setMasonryLayout];
    }
    
    return self;
}

- (void)configUI {
    _headIcon = [UIImageView new];
    _nameLabel = [UILabel new];
    _timeLabel = [UILabel new];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(120, 120);
    layout.minimumInteritemSpacing = 10;
    _imageContentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_imageContentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ImageViewCell"];
    _imageContentView.delegate = self;
    _imageContentView.dataSource = self;
    _contentTextLabel = [UILabel new];
    _contentTextLabel.numberOfLines = 0;
    _address = [UILabel new];
    
    
    [self.contentView addSubview:_headIcon];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_imageContentView];
    [self.contentView addSubview:_contentTextLabel];
    [self.contentView addSubview:_address];
    
    _nameLabel.font = [UIFont boldSystemFontOfSize:13];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _contentTextLabel.font = [UIFont boldSystemFontOfSize:12];
    _contentTextLabel.numberOfLines = 0;
    _address.font = [UIFont systemFontOfSize:12];
      
}

- (void)setMasonryLayout {
    UIView *contentView = self.contentView;
    
    [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.left.equalTo(contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIcon);
        make.left.equalTo(_headIcon.mas_right).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
    }];
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom);
        make.width.equalTo(_nameLabel);
        make.height.equalTo(@10);
    }];
    
    
    [_imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headIcon.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(10);
        make.right.equalTo(contentView).offset(10);
        make.height.equalTo(@120);
    }];
    
    [_contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_imageContentView);
        make.top.equalTo(_imageContentView.mas_bottom).offset(10);
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentTextLabel);
        make.top.equalTo(_contentTextLabel.mas_bottom).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.mas_bottom);
    }];

    // 215
}

- (void)setObject:(HomeTableViewItem *)item {
    [super setObject:item];
    NSLog(@"%@",@(item.cellHeight));
    self.headIcon.image = [UIImage imageNamed:item.headImage].circleImage;
    self.nameLabel.text = item.name;
    self.timeLabel.text = [GeneralTool convertToFromattime:item.time];
    self.contentTextLabel.text = item.content;
    self.address.text = item.address;
 
    CGSize size = [self.contentTextLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName, nil] context:nil].size;
    [self.contentTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(size.height));
    }];
    item.cellHeight = 215 + size.height;
    [_imageContentView reloadData];
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageViewCell" forIndexPath:indexPath];
    
    UIImageView *view = [cell viewWithTag:'cell'];
    [view removeFromSuperview];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    imageView.tag = 'cell';
    [cell addSubview:imageView];
    
    HomeTableViewItem *item = self.object;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
   
    imageView.image = [UIImage imageNamed:item.images[indexPath.row]];
    
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    HomeTableViewItem *item = self.object;
    return item.images.count;
}


+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(KtTableViewBaseItem *)object indexPath:(NSIndexPath *)indexPath {
    
    return 280;
}

@end

