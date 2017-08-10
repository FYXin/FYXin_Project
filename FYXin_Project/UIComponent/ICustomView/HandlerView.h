//
//  HandlerView.h
//  CustomView
//
//  Created by FYXin on 2017/5/24.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFactoryView.h"
#import "ICustomView.h"

@interface HandlerView : NSObject<ICustomView,IFactoryView>

@end
