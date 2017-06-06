//
//  MCHttp.h
//  mixc
//
//  Created by augsun on 7/8/16.
//  Copyright © 2016 crland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//#import "MCInline.h"
#import "MCApi.h"

#define MC_HTTP_SUCCESS intValue(json[@"code"]) == 0

// 商场编号
#define MC_MALL_NO @"1102A001" // 商城编号


@interface MCHttp : NSObject

// ====================================================================================================
#pragma mark - 通用请求方法
// GET
+ (NSURLSessionDataTask *)GET:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// POST
+ (NSURLSessionDataTask *)POST:(NSString *)url
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionDataTask *task, id json))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// POST_UPLOAD <图片上传需要自已调用签名方法对参数进行签名, 再调用参数拼接到 url 里的方法 (参照头像上传)>
+ (NSURLSessionDataTask *)POSTUpLoad:(NSString *)url
                              params:(NSDictionary *)params
           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            progress:(void (^)(CGFloat progress))progress
                             success:(void (^)(NSURLSessionDataTask *task, id json))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// PUT
+ (NSURLSessionDataTask *)PUT:(NSString *)url
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// DEL
+ (NSURLSessionDataTask *)DELETE:(NSString *)url
                          params:(NSDictionary *)params
                         success:(void (^)(NSURLSessionDataTask *task, id json))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// ====================================================================================================
#pragma mark - 特殊场合请求方法
// GET (自定义超时时间)
+ (NSURLSessionDataTask *)GET:(NSString *)url
              timeoutInterval:(NSTimeInterval)timeoutInterval
                       params:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id json))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// POST (自定义超时时间)
+ (NSURLSessionDataTask *)POST:(NSString *)url
               timeoutInterval:(NSTimeInterval)timeoutInterval
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionDataTask *task, id json))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// POST_UPLOAD (自定义超时时间)
+ (NSURLSessionDataTask *)POSTUpLoad:(NSString *)url
                     timeoutInterval:(NSTimeInterval)timeoutInterval
                              params:(NSDictionary *)params
           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            progress:(void (^)(CGFloat progress))progress
                             success:(void (^)(NSURLSessionDataTask *task, id json))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

// ====================================================================================================
#pragma mark - 无签名请求
// GET (无签名)
+ (NSURLSessionDataTask *)unSignGET:(NSString *)url
                             params:(NSDictionary *)params
                            success:(void (^)(NSURLSessionDataTask *task, id json))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;




// ====================================================================================================
#pragma mark - 基本请求参数 签名等
/** 获取基本请求参数 */
+ (NSMutableDictionary *)baseParam;

/** 参数拼接到 url 里的方法 */
+ (NSString *)urlStringFromApi:(NSString *)api Params:(NSDictionary *)params;

/** 对请求的参数进行签名处理 (多加一个签名字段 sign=) */
+ (NSDictionary *)signParams:(NSDictionary *)params;

@end



















