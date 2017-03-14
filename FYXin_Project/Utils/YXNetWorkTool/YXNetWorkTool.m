//
//  YXNetWorkTool.m
//  FYXin_Project
//
//  Created by FYXin on 2017/2/21.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import "YXNetWorkTool.h"


#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
    #import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#else
    #import "AFNetworking.h"
    #import "AFNetworkActivityIndicatorManager.h"
#endif

static AFHTTPSessionManager *_sessionManager;
static NSMutableArray *_allSessionTask;
static NSString *yx_networkBaseUrl = nil; //基础地址
static NSTimeInterval yx_timeout = 30.0f; //默认超时时间
static NSDictionary *yx_httpHeaders = nil; //默认请求头

//默认的请求数据形式 text/html
static YXRequestSerializer  yx_requestType  = YXRequestSerializerHTTP;

// 默认的响应数据类型 Json
static YXResponseSerializer yx_responseType = YXResponseTypeJSON;

static YXNetworkStatus yx_networkStatus = YXNetworkStatusReachableViaWiFi;


@implementation YXNetWorkTool

+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (URL == nil) return;
    if (!([URL hasPrefix:@"http"] || [URL hasPrefix:@"https"])) {
        return;
    }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


+ (void)configBaseURL:(NSString *)baseUrl {
    if (baseUrl.length == 0) {
        return;
    }
    if ([yx_networkBaseUrl isEqualToString:baseUrl]) {
        return;
    }
    yx_networkBaseUrl = baseUrl;
}


+ (NSString *)baseUrl {
    return yx_networkBaseUrl;
}


+ (NSString *)yx_absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        } else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            } else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    
    return absoluteUrl;
}


+ (NSString *)yx_URLEncode:(NSString *)url {

    return [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

}
#pragma mark - 相关配置

+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    yx_httpHeaders = httpHeaders;
}

+ (void)configRequestType:(YXRequestSerializer)requestType {
    yx_requestType = requestType;
    [self manager];
}

+ (void)configResponseType:(YXResponseSerializer)responseType {
    yx_responseType = responseType;
    [self manager];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    yx_timeout = time;
    [self manager].requestSerializer.timeoutInterval = time;
}


#pragma mark - GET请求
+ (NSURLSessionTask *)GET:(NSString *)URL
                parameter:(NSDictionary *)parameter
                  success:(YXHttpRequestSuccess)success
                   failed:(YXHttpRequestFailed)failed {
    
    NSString *absoluteURL = [self yx_absoluteUrlWithPath:URL];
    AFHTTPSessionManager *manager = [self manager];
    
    NSURLSessionTask *sessionTask = [manager GET:absoluteURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject,NO);
        [[self allSessionTask] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed ? failed(error) : nil;
        [self yx_handleResponseFailed:error.code];
        [[self allSessionTask] removeObject:task];
    }];
    
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

#pragma mark - POST请求
+ (NSURLSessionTask *)POST:(NSString *)URL
                 parameter:(NSDictionary *)parameter
                   success:(YXHttpRequestSuccess)success
                    failed:(YXHttpRequestFailed)failed {
    
    NSString *absoluteURL = [self yx_absoluteUrlWithPath:URL];
    AFHTTPSessionManager *manager = [self manager];
    
    NSURLSessionTask *sessionTask = [manager POST:absoluteURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        success(responseObject,NO);
        [[self allSessionTask] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        failed ? failed(error) : nil;
        [self yx_handleResponseFailed:error.code];
        [[self allSessionTask] removeObject:task];
    }];
    
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}


#pragma mark - UPLOAD（上传文件）
+ (NSURLSessionTask *)uploadFile:(NSString *)URL
                       parameter:(NSDictionary *)parameter
                            name:(NSString *)name
                        filePath:(NSString *)path
                        progress:(YXHttpProgress)progress
                         success:(YXHttpRequestSuccess)success
                          failed:(YXHttpRequestFailed)failed {
    
    AFHTTPSessionManager *manager = [self manager];
    NSString *absoluteURL = [self yx_absoluteUrlWithPath:URL];
    
    NSURLSessionTask *sessionTask = [manager POST:absoluteURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:path] name:name error:&error];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject,NO) : nil;
        [[self allSessionTask] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed ? failed(error) : nil;
        [self yx_handleResponseFailed:error.code];
        [[self allSessionTask] removeObject:task];
    }];
    
    [[self allSessionTask] addObject:sessionTask];
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                                parameter:(NSDictionary *)parameter
                                     name:(NSString *)name
                                   images:(NSArray <UIImage *>*)images
                                fileNames:(NSArray <NSString *>*)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(YXHttpProgress)progress
                                  success:(YXHttpRequestSuccess)success
                                   failed:(YXHttpRequestFailed)failed {

    AFHTTPSessionManager *manager = [self manager];
    NSString *absoluteURL = [self yx_absoluteUrlWithPath:URL];
    NSURLSessionTask *sessionTask = [manager POST:absoluteURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"]: imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success ? success(responseObject,NO) : nil;
        [[self allSessionTask] removeObject:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed ? failed(error) : nil;
        [self yx_handleResponseFailed:error.code];
        [[self allSessionTask] removeObject:task];
    }];
    
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

#pragma mark - downLoad(下载文件)
+ (NSURLSessionTask *)downLoadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(YXHttpProgress)progress
                              success:(YXHttpRequestSuccess)success
                               failed:(YXHttpRequestFailed)failed {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self yx_absoluteUrlWithPath:URL]]];
    AFHTTPSessionManager *manager = [self manager];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error && failed) {
            failed(error); return;
        }
        success ? success(filePath,NO) : nil;
        [[self allSessionTask] removeObject:downloadTask];
    }];
    
    [downloadTask resume];
    
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil;
    
    return downloadTask;
}

+ (void)yx_handleResponseFailed:(NSInteger)errorCode {
    switch (errorCode) {
        case -1001:
        {
            NSLog(@"服务器超时");
        }
            break;
            
        case -1004:
        {
            NSLog(@"失去连接");
        }
            break;
            
        case -1009:
        {
            NSLog(@"无网络");
        }
            break;
        default:
            break;
    }
}


#pragma mark - 开始监听网络状态
+ (void)networkStatusChanged:(YXNetworkChanged)networkChanged {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    yx_networkStatus = YXNetworkStatusUnknown;
                    networkChanged ? networkChanged(YXNetworkStatusUnknown) : nil;
                    NSLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    yx_networkStatus = YXNetworkStatusNotReachable;
                    networkChanged ? networkChanged(YXNetworkStatusNotReachable) : nil;
                    NSLog(@"无网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    yx_networkStatus = YXNetworkStatusReachableViaWWAN;
                    networkChanged ? networkChanged(YXNetworkStatusReachableViaWWAN) : nil;
                    NSLog(@"手机自带网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    yx_networkStatus = YXNetworkStatusReachableViaWiFi;
                    networkChanged ? networkChanged(YXNetworkStatusReachableViaWiFi) : nil;
                    NSLog(@"WIFI");
                }
                    break;
            }
        }];
    });
    
     [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

+ (AFHTTPSessionManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _sessionManager.requestSerializer.timeoutInterval = yx_timeout;
        _sessionManager.operationQueue.maxConcurrentOperationCount = 3;
         [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        [self networkStatusChanged:nil];
    });
    
    
    switch (yx_requestType) {
        case YXRequestSerializerJSON: {
            _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        case YXRequestSerializerHTTP: {
            _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    switch (yx_responseType) {
        case YXResponseTypeJSON: {
            _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case YXResponseTypeXML: {
            _sessionManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case YXResponseTypeHTTP: {
            _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default: {
            break;
        }
    }
    
    
    for (NSString *key in yx_httpHeaders.allKeys) {
        if (yx_httpHeaders[key] != nil) {
            [_sessionManager.requestSerializer setValue:yx_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    return _sessionManager;
}

@end
