//
//  FPagesViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/6/21.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "FPagesViewController.h"
#import "FTitleLabel.h"
#import "HomeViewController.h"

@interface FPagesViewController ()<UIScrollViewDelegate>


/** 标题栏 */
@property (nonatomic,strong) UIScrollView *smallScrollView;


/** 内容栏目 */
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,strong) FTitleLabel *oldTitleLabel;
@property (nonatomic,assign) CGFloat beginOffsetX;

/** 当前点击状态栏滑动到顶部的VC */
@property (nonatomic,strong) UIViewController *needScrollToTopPage;


@end

@implementation FPagesViewController


#pragma mark - lazy load
- (UIScrollView *)smallScrollView {
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    }
    return _smallScrollView;
}

- (UIScrollView *)bigScrollView {
    if (_bigScrollView == nil) {
        _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.smallScrollView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.smallScrollView.frame) - 49)];
    }
    return _bigScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.smallScrollView];
    [self.view addSubview:self.bigScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    self.smallScrollView.scrollsToTop = NO;
    self.bigScrollView.scrollsToTop = NO;
    self.bigScrollView.delegate = self;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addController];
    [self addLabel];
    
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;

    
    //添加默认控制器
    UIViewController *VC = self.childViewControllers.firstObject;
    
    VC.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:VC.view];
    
    FTitleLabel *titleLabel = self.smallScrollView.subviews.firstObject;
    titleLabel.scale = 1;
    
}

- (void)addController {
    NSArray *vcTitles = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    for (int i = 0; i < vcTitles.count; i++) {
        UIViewController *VC;
        if (i%2 == 0) {
            VC = [HomeViewController new];
        } else {
            VC = [[UIViewController alloc] init];
        }
        
        VC.title = vcTitles[i];
        CGFloat value = random()%256/255.0;
        
        VC.view.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
        [self addChildViewController:VC];
    }
}

/** 添加标题 */
- (void)addLabel {
    
    for (int i = 0; i < 8; i++) {
        CGFloat labelWidth = 70;
        CGFloat labelHeight = 40;
        CGFloat labelY = 0;
        CGFloat labelX = i * labelWidth;
        
        FTitleLabel *label = [[FTitleLabel alloc] init];
        UIViewController *vc = self.childViewControllers[i];
        label.text = vc.title;
        label.frame = CGRectMake(labelX, labelY, labelWidth, labelHeight);
        label.font = [UIFont systemFontOfSize:18];
        [self.smallScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
    }
    
    self.smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
    
}


- (void)labelClick:(UITapGestureRecognizer *)tap {
    FTitleLabel *titleLabel = (FTitleLabel *)tap.view;
    
    CGFloat offsetX = titleLabel.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    [self setScrollToTopWithTableViewIndex:titleLabel.tag];
}


- (void)setScrollToTopWithTableViewIndex:(NSInteger)index {
    /*
     self.needScrollToTopPage.tableView.scrollsToTop = NO;
     self.needScrollToTopPage = self.childViewControllers[index];
     self.needScrollToTopPage.tableView.scrollsToTop = YES;

     */
}

#pragma mark - UIScrollViewDelegate
/** 滑动结束  (调用设置scroll的 contentSize方法结束后) */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    //标题
    FTitleLabel *titleLabel = (FTitleLabel *)self.smallScrollView.subviews[index];

    CGFloat offsetX = titleLabel.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax) {
        offsetX = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetX, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    
    
    //添加控制器
    UIViewController *VC = self.childViewControllers[index];
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            FTitleLabel *temLabel = self.smallScrollView.subviews[idx];
            temLabel.scale = 0.0;
        }
    }];
    
    [self setScrollToTopWithTableViewIndex:index];
    
    if (VC.view.superview) {
        return;
    }
    
    VC.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:VC.view];
    
}


/** 滑动结束  (手势结束后的调用) */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //设置标题Label的字体变化效果
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    
    FTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    
    if (rightIndex < self.smallScrollView.subviews.count) {
        FTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}

@end
