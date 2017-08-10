//
//  ViewController.m
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "ViewController.h"
#import "InfoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    InfoView *infoView = [[InfoView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    [self.view addSubview:[infoView getView]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
