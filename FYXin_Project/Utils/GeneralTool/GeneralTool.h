//
//  GeneralTool.h
//  FYXin_Project
//
//  Created by FYXin on 2017/2/20.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GeneralTool : NSObject

/**
 转化为MD5字符串
 */
+ (NSString *) md5:(NSString *)string;

/**
 验证身份证是否有效
 */
+ (BOOL)validateIdentityCard:(NSString *)value;


/**
 根据颜色创建UIImage实例
 */
+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect;

/**
 获取顶层视图控制器
 */
+ (UIViewController *)presentingVC;

+ (NSString *)convertToFromattime:(NSInteger)timeInteval;

@end
