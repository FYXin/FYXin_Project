//
//  Macros.h
//  FYXin_Project
//
//  Created by FYXin on 2019/7/26.
//  Copyright © 2019 FYXin. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


/******************    屏幕相关          *************/

/** 屏幕宽度 */
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


///类型相关
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() ==  UIUserInterfaceIdiomPad)

#define IS_PHONE    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && SCREEN_MAX_LENGTH  < 568.0)
#define IS_IPHONE_5          (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7_8      (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_PLUS       (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//判断iPhone X
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)

//判断iPHoneXr
#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)

//判断iPhoneXs
#define IS_IPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)

//判断iPhoneXs_Max
#define IS_IPHONE_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)


// 判断是否是刘海屏
#define IS_LIUHAI_IPHONX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

///导航栏高度
#define APPLICATION_TOP_BAR_HEIGHT (IS_LIUHAI_IPHONX ? 88.f :64)

///tabbar高度
#define APPLICATION_TAB_BAR_HEIGHT (IS_LIUHAI_IPHONX ? 83.f :49)

/// 工具条高度 (常见的高度)
#define APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define APPLICATION_STATUS_BAR_HEIGHT (IS_LIUHAI_IPHONX?44:20.0f)


/// 色值
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

/// 随机色
#define RandomColor RGB((arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/// 是否为空对象
#define ObjectIsNil(__object) ((nil == __object) || [__object isKindOfClass:[NSNull class]])

///是否为空字符串
#define StringIsEmpty(__string)  ((__string.length == 0) || MHObjectIsNil(__string))

// 输入日志
#ifdef DEBUG

#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else

#define NSLog(format, ...)

#endif



/// 弱引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* Macros_h */
