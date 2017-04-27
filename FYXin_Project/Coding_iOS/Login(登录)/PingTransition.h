//
//  PingTransition.h
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TransitionType) {
    TransitionTypePresent = 0,
    TransitionTypeDismiss
};

@interface PingTransition : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>

@property (nonatomic,assign) TransitionType type;

+ (instancetype)transitionWithType:(TransitionType)type;

@end
