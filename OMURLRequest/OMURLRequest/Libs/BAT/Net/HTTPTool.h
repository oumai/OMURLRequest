//
//  WebRequestManager.h
//  WebRequest
//
//  Created by iOS Developer 2 on 16/3/31.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPToolSession.h"
#import "Singleton.h"
//#import "Transformer.h"
//#import "NSString+Hash.h"
#import "Reachability.h"


/**
 HTTP请求方式

 - kGET: get请求
 - kPOST: post请求
 - kDELETE: delete请求
 - kPUT: put请求
 */
typedef NS_ENUM(NSUInteger,HTTPRequestType) {

    kGET = 0,
    kPOST,
    kDELETE,
    kPUT,
};



/**
 请求解析方式

 - RequestSerializerTypeJSON: json解析，默认
 - RequestSerializerTypeHTTP: http解析
 */
typedef NS_ENUM(NSUInteger, RequestSerializerType) {

    RequestSerializerTypeJSON = 0,

    RequestSerializerTypeHTTP
};


/**
 响应解析方式

 - ResponseSerializerTypeHTTP: http解析，默认
 - ResponseSerializerTypeJSON: json解析
 */
typedef NS_ENUM(NSUInteger, ResponseSerializerType) {

    ResponseSerializerTypeHTTP= 0,

    ResponseSerializerTypeJSON
};

@interface HTTPTool : NSObject

singletonInterface(HTTPTool)

@property (nonatomic, assign) RequestSerializerType  requestSerializerType;

@property (nonatomic, assign) ResponseSerializerType responseSerializerType;



/**
 获取当前网络状态

 @return 网络状态
 */
+ (NetworkStatus)currentNetStatus;


/**
 base请求

 @param URLString URL地址
 @param header 请求头，默认可传nil
 @param parameters 参数体
 @param type 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)baseRequestWithURLString:(NSString *)URLString
                      HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
                      parameters:(id)parameters
                            type:(HTTPRequestType)type
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError * error))failure;



/**
 base上传

 @param URLString URL地址
 @param header 请求头，默认可传nil
 @param params 参数体
 @param block 上传数据
 @param success 成功回调
 @param failure 失败回调
 @param fractionCompleted 进度
 */
+ (void)baseUploadFileWithURLString:(NSString *)URLString
                         HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
                         WithParams:(id)params
          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            success:(void(^)(id dic))success
                            failure:(void(^)(NSError *error))failure
                  fractionCompleted:(void(^)(double count))fractionCompleted;


/**
 base下载

 @param URLString URL地址
 @param header 请求头，默认可传nil
 @param success 成功回调
 @param failure 失败回调
 @param fractionCompleted 进度
 */
+ (void)baseDownloadFileWithURLString:(NSString *)URLString
                           HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
                              success:(void(^)(id dic))success
                              failure:(void(^)(NSError *error))failure
                    fractionCompleted:(void(^)(double count))fractionCompleted;


/**
 取消请求
 */
+ (void)cancelRequest;

/**
 *  创建AFManager
 *
 *  @param baseURL         baseURL
 *  @param isconfiguration
 *
 *  @return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration;



/**
 *  解析
 *
 *  @param responseObject 请求返回值
 *
 *  @return 解析后的请求返回值
 */
+ (id)responseConfiguration:(id)responseObject;

@end
