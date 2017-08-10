//
//  TestPhotoGroup.m
//  FYXin_Project
//
//  Created by FYXin on 2017/4/8.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "TestPhotoGroup.h"
#import "YYPhotoGroupView.h"
#import <UIImageView+WebCache.h>

@interface TestPhotoGroup ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation TestPhotoGroup

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 400)];
    [self.view addSubview:view];
    
    NSArray *arr = @[@"http://ww2.sinaimg.cn/thumbnail/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                    @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                    @"http://ww1.sinaimg.cn/thumbnail/9be2329dgw1etlyb1yu49j20c82p6qc1.jpg"
                        ];
    
    NSArray *arr2 = @[@"http://ww2.sinaimg.cn/bmiddle/904c2a35jw1emu3ec7kf8j20c10epjsn.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/67307b53jw1epqq3bmwr6j20c80axmy5.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                      @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                      @"http://ww1.sinaimg.cn/bmiddle/9be2329dgw1etlyb1yu49j20c82p6qc1.jpg"];
    
    CGFloat margin = 10;
    CGFloat width = (self.view.bounds.size.width - 4 * margin) / 3;
    
    NSMutableArray *arrs = @[].mutableCopy;
    for (NSInteger i = 0; i < 6; i++) {
        int col = (int)(i / 3);
        int row = i % 3;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin + row * (margin + width), (width+margin) * col, width, width)];
        [view addSubview:imageView];
        
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer
                                         alloc] initWithTarget:self action:@selector(tap:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
        NSURL *url = [NSURL URLWithString:arr[i]];
        [imageView sd_setImageWithURL:url];
        
        
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imageView;
        item.largeImageURL = [NSURL URLWithString:arr2[i]];
      
        [arrs addObject:item];
    }
    
    _items = arrs.copy;
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:self.items];
    [v presentFromImageView:tap.view toContainer:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES completion:nil];
}

@end
