//
//  WebRequestSession.m
//  WebRequest
//
//  Created by iOS Developer 2 on 16/3/31.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import "HTTPToolSession.h"
#import "HTTPTool.h"
#define BaseUrl [NSURL URLWithString:@""]

@implementation HTTPToolSession

- (AFHTTPSessionManager *)requestManager
{
    
    if (_requestManager == nil) {

        _requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:BaseUrl];
        _requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain" ,@"image/png",@"image/jpeg",@"application/rtf",@"image/gif",@"application/zip",@"audio/x-wav",@"image/tiff",@"application/x-shockwave-flash",@"application/vnd.ms-powerpoint",@"video/mpeg",@"video/quicktime",@"application/x-javascript",@"application/x-gzip",@"application/x-gtar",@"application/msword",@"text/css",@"video/x-msvideo",@"text/xml", nil];

        switch ([HTTPTool sharedHTTPTool].requestSerializerType) {
        
            case RequestSerializerTypeJSON:

                _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
                
            case RequestSerializerTypeHTTP:
                
                _requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
                break;
                
            default:
                
                _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
                break;
        }
        
        switch ([HTTPTool sharedHTTPTool].responseSerializerType) {
                
            case ResponseSerializerTypeHTTP:
                
                _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
                
            case ResponseSerializerTypeJSON:
                
                _requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
                break;
                
            default:
                
                _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
                break;
        }
        
        _requestManager.requestSerializer.timeoutInterval = 30.f;
        
    }
    return _requestManager;
}

- (void) getDataWithURLString:(NSString *)URLString 
                   WithParams:(id)params 
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure
{

    [self.requestManager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void) postDataWithURLString:(NSString *)URLString 
                    WithParams:(id)params 
                       success:(void(^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure
{
    
    [self.requestManager POST:URLString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void)deleteRequestWithURLString:(NSString *)URLString
                        WithParams:(id)params
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure
{
    [self.requestManager DELETE:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            failure(error);
        }
    }];
}

- (void) putDataWithURLString:(NSString *)URLString
                   WithParams:(id)params
                      success:(void(^)(id responseObject))success
                      failure:(void(^)(NSError *error))failure
{
    [self.requestManager PUT:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            failure(error);
        }
    }];
}

- (void) uploadFileWithURLString:(NSString *)URLString 
                      WithParams:(id)params
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void(^)(id responseObject))success
                         failure:(void(^)(NSError *error))failure
               fractionCompleted:(void(^)(double count))fractionCompleted
{
    
    [self.requestManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        if (block) {
            block(formData);
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (fractionCompleted) {
            
            fractionCompleted(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void) downloadFileWithURLString:(NSString *)URLString 
                      fileDownPath:(NSString *)fileDownPath 
                           success:(void(^)(id responseObject))success 
                           failure:(void(^)(NSError *error))failure
                 fractionCompleted:(void(^)(double count))fractionCompleted
{

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSURLSessionDownloadTask *downloadTask =  [self.requestManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (fractionCompleted) {
            
            fractionCompleted(downloadProgress.fractionCompleted);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:fileDownPath];
        
        NSLog(@"%@",documentsDirectoryURL);
        
        return documentsDirectoryURL;

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (!error) {
            
            if (success) {
                
                success(filePath);
            }
        }else {
        
            if (failure) {
                
                failure(error);
            }
        }
        
    }];
    [downloadTask resume];
}

- (void)cancelRequest
{
    
    [self.requestManager.operationQueue cancelAllOperations];
}
@end
