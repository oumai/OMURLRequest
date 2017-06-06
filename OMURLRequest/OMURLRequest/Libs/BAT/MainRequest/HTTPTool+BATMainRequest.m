//
//  HTTPTool+BATMainRequest.m
//  HealthBAT_Pro
//
//  Created by KM on 16/9/232016.
//  Copyright © 2016年 KMHealthCloud. All rights reserved.
//

#import "HTTPTool+BATMainRequest.h"


@implementation HTTPTool (BATMainRequest)

#pragma mark -- POST/GET网络请求 --
+ (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HTTPRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError * error))failure
{


    URLString = [NSString stringWithFormat:@"%@%@",APP_API_URL,URLString];

    [HTTPTool baseRequestWithURLString:URLString HTTPHeader:^(HTTPToolSession *requestSession) {
        
    } parameters:parameters type:type success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        success(error);
        
    }];
}

@end
