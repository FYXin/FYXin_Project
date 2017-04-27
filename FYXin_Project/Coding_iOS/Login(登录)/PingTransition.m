//
//  PingTransition.m
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "PingTransition.h"

static const NSString *kTransitionContextKey = @"transitionContext";

@implementation PingTransition

+ (instancetype)transitionWithType:(TransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case TransitionTypePresent:
        {
            [self presentAnimation:transitionContext];
        }
            break;
            
        case TransitionTypeDismiss:
        {
            [self dismissAnimation:transitionContext];
        }
            break;
            
        default:
            break;
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
   
    UINavigationController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    [containerView addSubview:toVC.view];
    
    
    CGFloat radius = sqrtf(containerView.frame.size.width * containerView.frame.size.width + containerView.frame.size.height * containerView.frame.size.height);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(containerView.frame.size.width/2, containerView.frame.size.height/2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"present"];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    
    CGFloat radius = sqrtf(containerView.frame.size.width * containerView.frame.size.width + containerView.frame.size.height * containerView.frame.size.height);
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:1 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"a"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
   
    switch (_type) {
        case TransitionTypePresent:
        {
             [transitionContext completeTransition:YES];
             [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            
        case TransitionTypeDismiss:
        {
            [transitionContext completeTransition:YES];
            [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
         
        }
            break;
            
        default:
            break;
    }
   
}
@end
