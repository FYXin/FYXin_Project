//
//  YXTextField.m
//  JPCGProduct
//
//  Created by FYXin on 2017/3/30.
//  Copyright © 2017年 郭凯. All rights reserved.
//

#import "YXTextField.h"

#define padding             5
#define heightSpaceing      2

@interface YXTextField ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UILabel *placeholderLabel;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) CALayer *lineLayer;

@property (nonatomic,assign) BOOL moved;

@end

static const CGFloat lineWidth = 1.0;

@implementation YXTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;
    
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = [UIFont systemFontOfSize:15.0];
    _textField.textColor = [UIColor whiteColor];
    _textField.delegate = self;
    _textField.tintColor = [UIColor whiteColor];
    [self addSubview:_textField];
    
    _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _placeholderLabel.font = [UIFont systemFontOfSize:13.0];;
    _placeholderLabel.textColor = [UIColor lightGrayColor];;
    [self addSubview:_placeholderLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
    
    _lineLayer = [CALayer layer];
    _lineLayer.frame = CGRectMake(0, 0, 0, lineWidth);
    _lineLayer.anchorPoint = CGPointMake(0, 0.5);
    _lineLayer.backgroundColor = [UIColor whiteColor].CGColor;;
    [_lineView.layer addSublayer:_lineLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obserValue:) name:UITextFieldTextDidChangeNotification object:_textField];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) -lineWidth);
    _placeholderLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-lineWidth);
    _lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-lineWidth, CGRectGetWidth(self.frame), lineWidth);
}


- (void)obserValue:(NSNotification *)nf {
    [self changeFrameOfPlaceholder];
    _text = _textField.text;
}

- (void)changeFrameOfPlaceholder {
    CGFloat x = _placeholderLabel.center.x;
    CGFloat y = _placeholderLabel.center.y;
    
    if (_textField.text.length != 0 && !_moved) {
        [self moveAnimation:x y:y];
    } else if (_textField.text.length == 0 && _moved) {
        [self backAnimation:x y:y];
    }
}


- (void)moveAnimation:(CGFloat)x y:(CGFloat)y {
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    _placeholderLabel.font = [UIFont systemFontOfSize:10.f];
    _placeholderLabel.textColor = [UIColor blackColor];
    
    [UIView animateWithDuration:0.15 animations:^{
        moveY -= _placeholderLabel.frame.size.height/2 + heightSpaceing;
        moveX -= padding;
        
        _placeholderLabel.center = CGPointMake(moveX, moveY);
        _placeholderLabel.alpha = 1;
        _moved = YES;
        _lineLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), lineWidth);
    }];
}

- (void)backAnimation:(CGFloat)x y:(CGFloat)y {
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    _placeholderLabel.font = [UIFont systemFontOfSize:13.f];
    _placeholderLabel.textColor = [UIColor lightGrayColor];
    
    [UIView animateWithDuration:0.15 animations:^{
        moveY += _placeholderLabel.frame.size.height/2 + heightSpaceing;
        moveX += padding;
        _placeholderLabel.center = CGPointMake(moveX, moveY);
        _placeholderLabel.alpha = 1;
        _moved = NO;
        _lineLayer.bounds = CGRectMake(0, 0, 0, lineWidth);
    }];
}

- (void)setYx_placeholder:(NSString *)yx_placeholder {
    if (yx_placeholder != _yx_placeholder) {
        _yx_placeholder = yx_placeholder;
        _placeholderLabel.text = yx_placeholder;
    }
}

@end
