//
//  UIImage+YYAdd.h
//  FYXin_Project
//
//  Created by FYXin on 2017/5/2.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYAdd)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (instancetype)circleImage;

@end
