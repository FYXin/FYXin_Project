//
//  StepCountTool.m
//  FYXin_Project
//
//  Created by FYXin on 2017/4/10.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "StepCountTool.h"
#import <CoreMotion/CoreMotion.h>

static CMPedometer *cmpedometer = nil;

@implementation StepCountTool

- (void)queryStepFromDate:(NSDate *)fromDate completion:(void(^)(NSString *steps))completion{
    //判断记步功能是否可用
    if ([CMPedometer isStepCountingAvailable]) {
        
        [cmpedometer queryPedometerDataFromDate:fromDate toDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            if (error) {
                
            } else {
                NSString *numberOfSteps = [NSString stringWithFormat:@"%@",pedometerData.numberOfSteps];
                completion(numberOfSteps);
            }
        }];
    } else {
        NSLog(@"记步功能不可用");
    }
}

@end
