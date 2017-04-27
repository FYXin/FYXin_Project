//
//  YXLoginButton.m
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "YXLoginButton.h"

static const CGFloat lineWidth = 2;

@interface YXLoginButton ()<CAAnimationDelegate>

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@property (nonatomic,strong) CAShapeLayer *maskLayer;

@property (nonatomic,strong) CAShapeLayer *clickCircleLayer;

@property (nonatomic,strong) CAShapeLayer *loadingLayer;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UIBezierPath *roundPath;

@property (nonatomic,strong) UIBezierPath *largeRoundPath;


@end

@implementation YXLoginButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil)  return nil;
    
    [self.layer addSublayer:self.shapeLayer];
    [self.layer addSublayer:self.maskLayer];
    
    _button = [[UIButton alloc] initWithFrame:self.bounds];
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitle:@"登录" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_button];
    return self;
}

- (void)btnClick {
    [self addMaskLayerAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addZoomOutAnimation];
    });
    if (self.ClickBlcok) {
        self.ClickBlcok();
    }
}


- (void)addMaskLayerAnimation {
    _maskLayer.opacity = 0.15;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.25;
    animation.toValue = (__bridge id _Nullable)(self.largeRoundPath.CGPath);
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [_maskLayer addAnimation:animation forKey:@"maskAnimation"];
}

- (void)addZoomOutAnimation {
    [_maskLayer removeAllAnimations];
    [_maskLayer removeFromSuperlayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 0.15;
    UIBezierPath *toPath = [UIBezierPath bezierPath];
    [toPath addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.height/2-lineWidth startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    [toPath addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.height/2-lineWidth startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    pathAnimation.toValue = (__bridge id _Nullable)(toPath.CGPath);
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.duration = 0.15;
    animation2.beginTime = 0.1;
    animation2.toValue = @0;
    animation2.removedOnCompletion = NO;
    animation2.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[pathAnimation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [_shapeLayer addAnimation:group forKey:@"zoomOut"];
    [UIView animateWithDuration:0.15 animations:^{
        _button.alpha = 0;
    }];
}

- (void)resetAnimation {
    [_loadingLayer removeAllAnimations];
    [self.loadingLayer removeFromSuperlayer];
    
    [self.layer addSublayer:self.shapeLayer];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = 0.25;
    animation.fromValue = (__bridge id _Nullable)(_roundPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(_largeRoundPath.CGPath);
    [_shapeLayer addAnimation:animation forKey:@"reverAnimation"];
    [UIView animateWithDuration:0.15 delay:0 options:0 animations:^{
        _button.alpha = 1;
    } completion:nil];
    
}


- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.lineWidth = lineWidth;
        
        CGFloat radius = self.frame.size.height/2 - lineWidth;
        CGFloat left = lineWidth;
        CGFloat right = self.frame.size.width - left;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineJoinStyle = kCGLineJoinRound;
        path.lineCapStyle = kCGLineCapRound;
        
        //画左边半圆
        [path addArcWithCenter:CGPointMake(left + radius, self.frame.size.height/2) radius:radius startAngle:M_PI/2 endAngle:-M_PI/2 clockwise:YES];
        
        //画右边半圆
        [path addArcWithCenter:CGPointMake(right - radius, self.frame.size.height/2) radius:radius startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
        _largeRoundPath = path;
        [path closePath];
        _shapeLayer.path = path.CGPath;
    }
    return _shapeLayer;
}

- (CAShapeLayer *)maskLayer {
    if (_maskLayer == nil) {
        _maskLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.height/2-lineWidth startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.height/2-lineWidth startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
        _roundPath = path;
        _maskLayer.path = path.CGPath;
        _maskLayer.fillColor = [UIColor whiteColor].CGColor;
        _maskLayer.opacity = 0;
    }
    return _maskLayer;
}

- (CAShapeLayer *)loadingLayer {
    if (_loadingLayer == nil) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.frame = self.bounds;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.height/2 - lineWidth startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
        _loadingLayer.lineWidth = lineWidth;
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.strokeColor = [UIColor whiteColor].CGColor;
        _loadingLayer.lineCap = kCALineCapRound;
        _loadingLayer.path = path.CGPath;
    }
    return _loadingLayer;
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_shapeLayer removeAllAnimations];
    [_shapeLayer removeFromSuperlayer];
    
    [self.layer addSublayer:self.loadingLayer];
    CABasicAnimation *loadingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    loadingAnimation.toValue = @(M_PI * 2);
    loadingAnimation.duration = 0.7;
    loadingAnimation.repeatCount = LONG_MAX;
    [_loadingLayer addAnimation:loadingAnimation forKey:@"loading"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self resetAnimation];
    });
}
@end
