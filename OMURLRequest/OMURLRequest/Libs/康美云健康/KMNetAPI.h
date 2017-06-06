//
//  KMNetAPI.h
//  InstantCare
//
//  Created by bruce-zhu on 15/12/4.
//  Copyright © 2015年 omg. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "KMPersonModel.h"
//#import "KMNetworkResModel.h"
/*
 * code: 请求是否成功，0成功，其他失败
 *  res: 从网络获取到的数据
 */
typedef void (^KMRequestResultBlock)(int code, NSString *res);

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypeUpload,
    RequestTypeDelete,
    RequestTypePut,
    RequestTypePatch,
    RequestTypeHead
};

@interface KMNetAPI : NSObject

+ (instancetype)manager;


- (void)postWithURL:(NSString *)url body:(NSString *)body block:(KMRequestResultBlock)block;

/**
 *  获取设备列表
 *
 *  @param account 用户账号
 *  param block   结果返回block
 */
- (void)getDevicesListWithAccount:(NSString *)account
                            Block:(KMRequestResultBlock)block;

/**
 *  获取打卡点数
 *
 *  @param imei  IMEI
 *  param block 结果返回block
 */
- (void)getValWithIMEI:(NSString *)imei
                 Block:(KMRequestResultBlock)block;
/**
 *  获取打卡记录
 *
 *  @param imei  IMEI
 *  param block 结果返回block
 */
- (void)getCheckRecordsWithIMEI:(NSString *)imei
                          Block:(KMRequestResultBlock)block;

/**
 *  获取历史记录
 *
 *  param imei  IMEI
 *  param block
 */
- (void)getHisRecordsWithIMEI:(NSString *)imei
                        Block:(KMRequestResultBlock)block;

/**
 *  获取紧急救援记录
 *
 *  param imei  IMEI
 *  param block
 */
- (void)getEmgRecordsWithIMEI:(NSString *)imei
                        Block:(KMRequestResultBlock)block;

/**
 *  获取跌倒记录
 *
 *  @param imei  IMEI
 *  param block
 */
- (void)getFallRecordsWithIMEI:(NSString *)imei
                         Block:(KMRequestResultBlock)block;

/**
 *  获取账号信息
 *
 *  @param account 注册的手机号
 *  param block
 */
- (void)getAccountInfoWithAccount:(NSString *)account
                            Block:(KMRequestResultBlock)block;

/**
 *  更新用户信息
 *
 *  @param model   用户信息模型
 *  @param account 用户账号
 *  param block
 */
//- (void)updateAccountInfoWith:(KMPersonDetailModel *)model
//                      account:(NSString *)account
//                        block:(KMRequestResultBlock)block;

/**
 *  通用GET网络请求接口
 *
 *  @param keyURL  前面一部分
 *  param block   结果
 */
- (void)commonGetRequestWithURL:(NSString *)keyURL
                          Block:(KMRequestResultBlock)block;
/**
 *  通用POST网络请求接口
 *
 *  @param keyURL 后面的URL
 *  @param body   body
 *  param block
 */
- (void)commonPOSTRequestWithURL:(NSString *)keyURL
                        jsonBody:(NSString *)body
                           Block:(KMRequestResultBlock)block;
/**
 *  上传头像
 *
 *  @param imei   IMEI
 *  @param header 头像
 *  param block
 */
- (void)updateUserHeaderWithIMEI:(NSString *)imei
                          header:(UIImage *)header
                           block:(KMRequestResultBlock)block;

- (void)checkVersionWithAPPID:(NSString *)appid
                        block:(KMRequestResultBlock)block;


/**
 *  获取用户健康档案接口
 */
- (void)getUserHealthRecordWithUrl:(NSString *)urlString
                             block:(KMRequestResultBlock)block;

//重构代码
+ (instancetype)sharedInstance;

- (void)requestWithPath:(NSString*)path
            requestType:(RequestType)requestType
             parameters:(NSDictionary*)parameters
         successHandler:(void (^)(id data))success
         failureHandler:(void (^)(NSError *error))failure;

@end



