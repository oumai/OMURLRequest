//
//  OMURLConnection.h
//  AiFuGou
//
//  Created by Michael on 16/6/16.
//  Copyright © 2016年 jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completeBlock_tt)(NSData *data,id responseObject);

typedef void (^errorBlock_t)(NSError *error);

typedef void (^progressBlock)(CGFloat value);


@interface OMURLConnection : NSObject
/*
 需要满足其中至少一个条件
 Block的实现(声明、赋值、实现)
 1、有成员变量
 2、赋值时需要用到if()
 
 */
//{
//    NSMutableData *_data;
//    completeBlock_tt _completeBlock;
//    errorBlock_t _errorBlock;
//    progressBlock _progressBlock;
//}


+(NSNumber *)getMsg:(id)data;

//加密
+(NSString *)doDEStoGetJson:(NSDictionary *)jsondict andMethod:(NSString *)method andVersion:(NSString *)version;

//解密
+ (NSString *)doDESDecrypt:(id)data;




//爱福购(请求的方法)
+(void)requestAiFuGouAFNJSon:(NSDictionary *)dic
                      method:(NSString *)method
                        view:(UIView *)view
                     version:(NSString *)string
               completeBlock:(completeBlock_tt)completeBlock
                  errorBlock:(errorBlock_t)errorBlock;

//天使医生(请求的方法)
+(void)requestAngelDoctorAFNJSon:(NSDictionary *)dic
                      method:(NSString *)method
                        view:(UIView *)view
                     version:(NSString *)string
               completeBlock:(completeBlock_tt)completeBlock
                  errorBlock:(errorBlock_t)errorBlock;

@end
