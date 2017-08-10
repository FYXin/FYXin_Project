//
//  ICustomView.h
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ICustomView <NSObject>

@required


/**
 配置初始化的大小

 @param frame frame
 @return 返回实例本身
 */
- (instancetype)initWithFrame:(CGRect)frame;


/**
 获取视图
 */
- (UIView *)getView;


@optional

/**
 获取视图的高度
 */
- (CGFloat)getViewHeight;


/**
 传入视图配置

 @param config 配置参数
 @return 可选的结果，根据实际需求传出相关数据
 */
- (id)configWithData:(id)config;



/**
 获取视图的最终数据
 */
- (id)getResult;

@end
