//
//  YXNetWorkTool.h
//  FYXin_Project
//
//  Created by FYXin on 2017/2/21.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, YXNetworkStatus) {
    YXNetworkStatusUnknown          = -1,//未知网络
    YXNetworkStatusNotReachable     = 0,//网络无连接
    YXNetworkStatusReachableViaWWAN = 1,//2，3，4G网络
    YXNetworkStatusReachableViaWiFi = 2,//WIFI网络
};

typedef NS_ENUM(NSUInteger,YXRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    YXRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    YXRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger,YXResponseSerializer) {
    YXResponseTypeJSON = 1, // 默认
    YXResponseTypeXML  = 2, // XML
    YXResponseTypeHTTP = 3  //二进制数据
};

/** 请求成功的block */
typedef void(^YXHttpRequestSuccess)(id responseObject,BOOL isCache);

/** 请求失败的block */
typedef void(^YXHttpRequestFailed)(NSError *error);

/**上传 或者 下载的进度  progress.completedUnitCount:当前大小 - progress.totalUnitCount:总大小 */
typedef void(^YXHttpProgress)(NSProgress *progress);

/**  网络状态的block */
typedef void(^YXNetworkChanged)(YXNetworkStatus status);

@interface YXNetWorkTool : NSObject



/**
 配置基地址
 */
+ (void)configBaseURL:(NSString *)baseUrl;


/**
 获取基地址
 */
+ (NSString *)baseUrl;


/**
 配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了，所有的配置都可以有一个通用的HEADER
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 配置请求类型，默认是json类型
 */
+ (void)configRequestType:(YXRequestSerializer)requestType;

/**
 配置响应类型，默认是json类型
 */
+ (void)configResponseType:(YXResponseSerializer)responseType;


/**
 配置超时时间,默认30s
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;


/**
 取消所有请求
 */
+ (void)cancleAllRequest;


/**
 根据URL取消特定的请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;



/**
 GET请求

 @param URL URL
 @param parameter 参数
 @param success 请求成功的回调blcok
 @param failed 请求失败的回调block
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
                parameter:(NSDictionary *)parameter
                  success:(YXHttpRequestSuccess)success
                   failed:(YXHttpRequestFailed)failed;


/**
 POST请求

 @param URL URL
 @param parameter 参数
 @param success 成功的回调
 @param failed 失败的回调
 @return NSURLSessionTask 用于其他的设置
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                 parameter:(NSDictionary *)parameter
                   success:(YXHttpRequestSuccess)success
                    failed:(YXHttpRequestFailed)failed;


/**
 文件上传

 @param URL URL
 @param parameter 参数
 @param name 文件名称
 @param path 文件的路径，必须填写的
 @param progress 文件上传过程的监听blcok
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (NSURLSessionTask *)uploadFile:(NSString *)URL
                       parameter:(NSDictionary *)parameter
                            name:(NSString *)name
                        filePath:(NSString *)path
                        progress:(YXHttpProgress)progress
                         success:(YXHttpRequestSuccess)success
                          failed:(YXHttpRequestFailed)failed;



/**
 图片上传

 @param URL URL
 @param parameter 参数
 @param name 名称
 @param images UIImage数组（数组中必须是UIImage实例）
 @param fileNames 文件名数组
 @param imageScale 图片缩放比例（ 0 - 1 ）
 @param imageType 图片类型（ 例如：image/jpeg）
 @param progress 监听上传过程的block
 @param success 成功的block
 @param failed 失败的block
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                parameter:(NSDictionary *)parameter
                                     name:(NSString *)name
                                   images:(NSArray <UIImage *>*)images
                                fileNames:(NSArray <NSString *>*)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(YXHttpProgress)progress
                                  success:(YXHttpRequestSuccess)success
                                   failed:(YXHttpRequestFailed)failed;

/**
 文件下载

 @param URL URL
 @param fileDir 下载路径
 @param progress 监听下载的过程
 @param success 成功的回调，值是下载后的地址
 @param failed 失败的回调
 */
+ (NSURLSessionTask *)downLoadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(YXHttpProgress)progress
                              success:(YXHttpRequestSuccess)success
                               failed:(YXHttpRequestFailed)failed;

@end
