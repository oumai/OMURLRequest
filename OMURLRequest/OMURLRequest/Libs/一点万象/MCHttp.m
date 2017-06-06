//
//  MCHttp.m
//  mixc
//
//  Created by augsun on 7/8/16.
//  Copyright © 2016 crland. All rights reserved.
//

#import "MCHttp.h"
#import "JXUUIDAndKeyChain.h"
#import "MCMacro.h"
#import "MCInline.h"
//#import "MCUserManager.h"
//#import "NSString+JXCategory.h"
#import "MCApiSign.h"
//#import "MCGlobalManager.h"

static const CGFloat MCHttpTimeOut = 10.f; // 网络请求超时(s)

@implementation MCHttp

// 日志输出
+ (void)httpDebugMethod:(NSString *)method
                    url:(NSString *)url
                 paramS:(NSDictionary *)params
              isSuccess:(BOOL)isSuccess
                    log:(id)log {
    NSLog(@"\n==================%@==================\n\%@\n%@\n%@\n----------------------------------------------\n\%@\n----------------------------------------------\n\n\n\n\n", isSuccess ? @"✅success:" : @"❌failure:", method, url, params, log);
}

// 菊花打开或关闭
+ (void)networkActivityIndicatorVisible:(BOOL)visible {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:visible];
}

// 生成一个 AFHTTPSessionManager
+ (AFHTTPSessionManager *)AFHTTPSessionManagerWithTimeoutInterval:(NSTimeInterval)timeoutInterval {
    [self networkActivityIndicatorVisible:YES];
    // 修改 解析数据格式 能够接受的内容类型 － 官方推荐的做法，民间做法：直接修改 AFN 的源代码
    NSSet *contentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/javascript", nil];
    AFHTTPSessionManager *sManager = [AFHTTPSessionManager manager];
    sManager.requestSerializer.timeoutInterval = timeoutInterval;
    sManager.responseSerializer.acceptableContentTypes = contentTypes;
    return sManager;
}

// 请求成功回调
+ (void)successWithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                     task:(NSURLSessionDataTask *)task
           responseObject:(id)responseObject
                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self networkActivityIndicatorVisible:NO];
        [self httpDebugMethod:@"GET" url:url paramS:params isSuccess:YES log:responseObject];
        //返回401的时候用户信息。
        //if (intValue(responseObject[@"code"]) == 401) { [[MCUserManager shareManager] deleUserInfo]; }
        !success ? : success(task, responseObject);
    });
}

// 请求失败回调
+ (void)failureWithMethod:(NSString *)method
                      url:(NSString *)url
                   params:(NSDictionary *)params
                     task:(NSURLSessionDataTask *)task
                    error:(NSError *)error
                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self networkActivityIndicatorVisible:NO];
        [self httpDebugMethod:method url:url paramS:params isSuccess:NO log:error];
        !failure ? : failure(task, error);
    });
}

// ====================================================================================================
#pragma mark - 通用请求方法
// GET
+ (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    //url = @"https://app.mixcapp.com/mixc/api/v1/merchant/searchShop";
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager GET:url parameters:[self signParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:@"GET" url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"GET" url:url params:params task:task error:error failure:failure];
    }];
}

// POST
+ (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionDataTask *task, id json))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager POST:url parameters:[self signParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:(@"POST") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"POST" url:url params:params task:task error:error failure:failure];
    }];
}

// POST_UPLOAD
+ (NSURLSessionDataTask *)POSTUpLoad:(NSString *)url
                              params:(NSDictionary *)params
           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            progress:(void (^)(CGFloat progress))progress
                             success:(void (^)(NSURLSessionDataTask *task, id json))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        !block ? : block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        !progress ? : progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:(@"POST_UPLOAD") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"POST_UPLOAD" url:url params:params task:task error:error failure:failure];
    }];
}

// PUT
+ (NSURLSessionDataTask *)PUT:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager PUT:url parameters:[self signParams:params] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self successWithMethod:(@"PUT") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self failureWithMethod:@"PUT" url:url params:params task:task error:error failure:failure];
    }];
}

// DEL
+ (NSURLSessionDataTask *)DELETE:(NSString *)url
                          params:(NSDictionary *)params
                         success:(void (^)(NSURLSessionDataTask *, id))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager DELETE:url parameters:[self signParams:params] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self successWithMethod:(@"DEL") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self failureWithMethod:@"DEL" url:url params:params task:task error:error failure:failure];
    }];
}

// ====================================================================================================
#pragma mark - 特殊场合请求方法
// GET (自定义超时时间)
+ (NSURLSessionDataTask *)GET:(NSString *)url
              timeoutInterval:(NSTimeInterval)timeoutInterval
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:timeoutInterval];
    return [sManager GET:url parameters:[self signParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:@"GET" url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"GET" url:url params:params task:task error:error failure:failure];
    }];
}

// POST (自定义超时时间)
+ (NSURLSessionDataTask *)POST:(NSString *)url
               timeoutInterval:(NSTimeInterval)timeoutInterval
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionDataTask *, id))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:timeoutInterval];
    return [sManager POST:url parameters:[self signParams:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:(@"POST") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"POST" url:url params:params task:task error:error failure:failure];
    }];
}

// POST_UPLOAD (自定义超时时间)
+ (NSURLSessionDataTask *)POSTUpLoad:(NSString *)url
                     timeoutInterval:(NSTimeInterval)timeoutInterval
                              params:(NSDictionary *)params
           constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                            progress:(void (^)(CGFloat))progress
                             success:(void (^)(NSURLSessionDataTask *, id))success
                             failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:timeoutInterval];
    return [sManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        !block ? : block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        !progress ? : progress(uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:(@"POST_UPLOAD") url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"POST_UPLOAD" url:url params:params task:task error:error failure:failure];
    }];
}

// ====================================================================================================
#pragma mark - 无签名请求
+ (NSURLSessionDataTask *)unSignGET:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    AFHTTPSessionManager *sManager = [self AFHTTPSessionManagerWithTimeoutInterval:MCHttpTimeOut];
    return [sManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithMethod:@"GET" url:url params:params task:task responseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureWithMethod:@"GET" url:url params:params task:task error:error failure:failure];
    }];
}

//// ====================================================================================================
//#pragma mark - 基本请求参数 签名等
//
/** 获取基本请求参数 */
+ (NSMutableDictionary *)baseParam {
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    // osVersion
    NSString *osVersion = strValue([UIDevice currentDevice].systemVersion);
    osVersion = osVersion.length == 0 ? @"unKnowOsVersion" : osVersion;
    param[@"osVersion"]     = osVersion;
    
    // imei
    NSString *imei = [self validParam:[JXUUIDAndKeyChain UUID]];
    imei = imei.length == 0 ? @"unKnowImei" : imei;
    param[@"imei"]          = imei;
    
    // platform
    param[@"platform"]      = @"iOS";
    
    // appVersion
    NSString *appVersion = strValue([self validParam:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]);
     appVersion = appVersion.length == 0 ? @"unKnowAppVersion" : appVersion;
    param[@"appVersion"]    = appVersion;
    
    // timestamp
    //param[@"timestamp"]     = [NSString stringWithFormat:@"%lld", (long long)[MCGlobalManager shareManager].timeStamp];
    
    // token
    //param[@"token"]         = MC_USER_MODEL.token;
    
    //
    param[@"mallNo"]        = @"1102A001";
    return param;
}

+ (NSString *)validParam:(id)param {
    if ([param isKindOfClass:[NSString class]] || [param isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", param];
    }
    else {
        return @"";
    }
}

/** 参数拼接到 url 里的方法 */
+ (NSString *)urlStringFromApi:(NSString *)api Params:(NSDictionary *)params {
    // 检查参数有效性 (至少一个参数)
    NSArray <NSString *> *keys = params.allKeys;
    BOOL haveValidParam = NO;
    for (NSString *key in keys) {
        if (isStringOrNumber(params[key])) {
            haveValidParam = YES;
            break;
        };
    }
    // 参数无效或没有参数
    if (!haveValidParam) { return api; }
    
    // 有参数且参数有效
    NSMutableString *mString=[NSMutableString stringWithFormat:@"%@?",api];
    for (NSString *key in keys) {
        [mString appendFormat:@"%@=%@&", key, params[key]];
    }
    [mString deleteCharactersInRange:NSMakeRange(mString.length - 1, 1)];
    return [mString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

/** 对请求的参数进行签名处理 (多加一个签名字段 sign=) */
+ (NSDictionary *)signParams:(NSDictionary *)params {
    return [MCApiSign signParams:params];
}

@end



















