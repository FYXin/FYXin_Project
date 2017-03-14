//
//  ViewController.m
//  FYXin_Project
//
//  Created by FYXin on 2017/2/20.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACReturnSignal.h>
#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField2;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *myview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //[self testTextField];
}


- (void)testTextField {
    [_textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    [[_textField.rac_textSignal bind:^RACStreamBindBlock{
        
        // 什么时候调用:
        // block作用:表示绑定了一个信号.
        
        return ^RACStream *(id value, BOOL *stop){
            
            // 什么时候调用block:当信号有新的值发出，就会来到这个block。
            
            // block作用:做返回值的处理
            
            // 做好处理，通过信号返回出去.
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        };
        
    }] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];

    [[_textField.rac_textSignal flattenMap:^RACStream *(id value) {
        
        // block什么时候 : 源信号发出的时候，就会调用这个block。
        
        // block作用 : 改变源信号的内容。
        
        // 返回值：绑定信号的内容.
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        
    }] subscribeNext:^(id x) {
        
        // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。
        
        NSLog(@"%@",x);
        
    }];
}


- (void)test {
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个%@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个%@",x);
    }];
    
    [subject sendNext:@1];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"FYXin"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消订阅");
        }];
    }];
    
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        NSLog(@"====%@",x);
    }];
    
    [disposable dispose];
}

- (IBAction)btnClick:(id)sender {
  
}


@end
