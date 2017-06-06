//
//  WebRequestSession.h
//  WebRequest
//
//  Created by iOS Developer 2 on 16/3/31.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPToolSession : NSObject

/**
 *  请求管理者
 */
@property (nonatomic,strong)AFHTTPSessionManager *requestManager;


/**
 get请求

 @param URLString URL地址
 @param params 参数体
 @param success 成功回调
 @param failure 失败回调
 */
- (void) getDataWithURLString:(NSString *)URLString 
                   WithParams:(id)params 
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure;



/**
 post请求

 @param URLString URL地址
 @param params 参数体
 @param success 成功回调
 @param failure 失败回调
 */
- (void) postDataWithURLString:(NSString *)URLString 
                    WithParams:(id)params 
                       success:(void(^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure;


/**
 delete请求

 @param URLString URL地址
 @param params 参数体
 @param success 成功回调
 @param failure 失败回调
 */
- (void)deleteRequestWithURLString:(NSString *)URLString
                        WithParams:(id)params
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure;


/**
 put请求

 @param URLString URL地址
 @param params 参数体
 @param success 成功回调
 @param failure 失败回调
 */
- (void) putDataWithURLString:(NSString *)URLString
                   WithParams:(id)params
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure;

/**
 上传请求

 @param URLString URL地址
 @param params 参数体
 @param block 上传数据
 @param success 成功回调
 @param failure 失败回调
 @param fractionCompleted 进度
 */
- (void) uploadFileWithURLString:(NSString *)URLString
                      WithParams:(id)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void(^)(id responseObject))success
                         failure:(void(^)(NSError *error))failure
               fractionCompleted:(void(^)(double count))fractionCompleted;


/**
 下载请求

 @param URLString URL地址
 @param fileDownPath 下载文件存储路径
 @param success 成功回调
 @param failure 失败回调
 @param fractionCompleted 进度
 */
- (void) downloadFileWithURLString:(NSString *)URLString 
                      fileDownPath:(NSString *)fileDownPath 
                           success:(void(^)(id responseObject))success 
                           failure:(void(^)(NSError *error))failure
                 fractionCompleted:(void(^)(double count))fractionCompleted;


/**
 取消请求
 */
- (void)cancelRequest;

@end
