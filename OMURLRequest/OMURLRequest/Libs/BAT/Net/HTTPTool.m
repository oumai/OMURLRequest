//
//  WebRequestManager.m
//  WebRequest
//
//  Created by iOS Developer 2 on 16/3/31.
//  Copyright © 2016年 Laughing. All rights reserved.
//

#import "HTTPTool.h"
#import "HTTPToolSession.h"
#define  kWebCachePath [NSTemporaryDirectory() stringByAppendingString:@"cache"]
#define  kWebBaseURLPath @""

@interface HTTPTool ()

@property (nonatomic, strong)  HTTPToolSession     *HTTPSession;           //session请求

@property (nonatomic,strong) NSMutableDictionary *operationCachePool;    //初始化操作缓存池

@property (nonatomic,assign) BOOL                isCanceled;             //是否取消网络请求

@end

@implementation HTTPTool

singletonImplemention(HTTPTool)

+ (NetworkStatus)currentNetStatus {

    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.jkbat.com"];

    return [reachability currentReachabilityStatus];
}

// 初始化操作缓存池
- (NSMutableDictionary *)operationCachePool
{
    
    if (_operationCachePool == nil) {
        
        _operationCachePool = [[NSMutableDictionary alloc] init];
    
    }

    return _operationCachePool;
}

+ (void)baseRequestWithURLString:(NSString *)URLString
                      HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
                      parameters:(id)parameters
                            type:(HTTPRequestType)type
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSError * error))failure
{

    
    URLString = [[HTTPTool sharedHTTPTool] beforeRequestWithSettingWithURLString:URLString];

    HTTPToolSession *requestSession = [[HTTPToolSession alloc]init];

    [[HTTPTool sharedHTTPTool].operationCachePool setObject:requestSession forKey:URLString];

    [HTTPTool sharedHTTPTool].HTTPSession = requestSession;

    if (header) {
        header(requestSession);
    }

    switch (type) {
        case kGET:
        {
            
            [requestSession getDataWithURLString:URLString WithParams:parameters success:^(id responseObject) {

                [[HTTPTool sharedHTTPTool] setReturnSuccessWithSuccess:success responseObject:responseObject URLString:URLString];
                
                //success(responseObject);

            } failure:^(NSError *error) {

                [[HTTPTool sharedHTTPTool] BlockWith:error success:success failure:failure URL:URLString];
                
            }];

        }
            break;

        case kPOST:
        {

            [requestSession postDataWithURLString:URLString WithParams:parameters success:^(id responseObject) {

                [[HTTPTool sharedHTTPTool] setReturnSuccessWithSuccess:success responseObject:responseObject URLString:URLString];

            } failure:^(NSError *error) {

                [[HTTPTool sharedHTTPTool] BlockWith:error success:success failure:failure URL:URLString];

            }];

        }
            break;

        case kDELETE:
        {

            [requestSession deleteRequestWithURLString:URLString WithParams:parameters success:^(id responseObject) {

                [[HTTPTool sharedHTTPTool] setReturnSuccessWithSuccess:success responseObject:responseObject URLString:URLString];

            } failure:^(NSError *error) {

                [[HTTPTool sharedHTTPTool] BlockWith:error success:success failure:failure URL:URLString];

            }];
        }
            break;

        case kPUT:
        {

            [requestSession putDataWithURLString:URLString WithParams:parameters success:^(id responseObject) {

                [[HTTPTool sharedHTTPTool] setReturnSuccessWithSuccess:success responseObject:responseObject URLString:URLString];

            } failure:^(NSError *error) {

                [[HTTPTool sharedHTTPTool] BlockWith:error success:success failure:failure URL:URLString];

            }];
        }
            break;


        default:
            break;
    }

}

// Upload请求
+ (void)baseUploadFileWithURLString:(NSString *)URLString
                         HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
                         WithParams:(id)params
          constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            success:(void(^)(id responseObject))success
                            failure:(void(^)(NSError *error))failure
                  fractionCompleted:(void(^)(double count))fractionCompleted
{
    
    HTTPToolSession *requestSession = [[HTTPToolSession alloc]init];

    [HTTPTool sharedHTTPTool].HTTPSession = requestSession;

    if (header) {
        header(requestSession);
    }

    [requestSession uploadFileWithURLString:URLString WithParams:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        if (block) {

            block(formData);
        }
    } success:^(id responseObject) {

        if (success) {

            //responseObject = [Transformer dictionaryWithData:responseObject];
            success(responseObject);
        }
    } failure:^(NSError *error) {

        [HTTPTool sharedHTTPTool].isCanceled = NO;

        if (failure) {
            failure(error);
        }

    } fractionCompleted:^(double count) {

        if (fractionCompleted) {

            fractionCompleted(count);
        }
    }];
}

//+ (void)baseDownloadFileWithURLString:(NSString *)URLString
//                           HTTPHeader:(void(^)(HTTPToolSession *requestSession))header
//                              success:(void(^)(id responseObject))success
//                              failure:(void(^)(NSError *error))failure
//                    fractionCompleted:(void(^)(double count))fractionCompleted
//{
//
//    URLString = [[HTTPTool sharedHTTPTool] beforeRequestWithSettingWithURLString:URLString];
//    
//    HTTPToolSession *requestSession = [[HTTPToolSession alloc]init];
//    
//    [HTTPTool sharedHTTPTool].HTTPSession = requestSession;
//    
//    [[HTTPTool sharedHTTPTool].operationCachePool setObject:requestSession forKey:URLString];
//    
//    NSString *hash = [URLString md5String];
//    
//    NSString *filePath = [[HTTPTool sharedHTTPTool] pathForDocumentWithComponent:hash];
//
//    if (header) {
//        header(requestSession);
//    }
//
//    [requestSession downloadFileWithURLString:URLString fileDownPath:filePath success:^(id responseObject) {
//        
//        if (success) {
//
//            //responseObject = [Transformer dictionaryWithData:responseObject];
//
//            success(responseObject);
//        }
//    } failure:^(NSError *error) {
//        
//        [HTTPTool sharedHTTPTool].isCanceled = NO;
//        
//        if (failure) {
//
//            failure(error);
//        }
//    } fractionCompleted:^(double count) {
//        
//        if (fractionCompleted) {
//            
//            fractionCompleted(count);
//        }
//    }];
//
//}
//// 请求前设置
- (NSString *)beforeRequestWithSettingWithURLString:(NSString *)URLString
{
    
    URLString = [NSString stringWithFormat:@"%@%@",kWebBaseURLPath,URLString];

    if ([self.operationCachePool objectForKey:URLString]) {
        
        NSLog(@"----重复的请求----%@",URLString);
        
    }
    
    return URLString;
}

// 请求数据成功
- (void)setReturnSuccessWithSuccess:(void(^)(id responseObject))success responseObject:(id)responseObject URLString:(NSString *)URLString
{
    
    if ([self.operationCachePool objectForKey:URLString]) {
        
        [self.operationCachePool removeObjectForKey:URLString];
  
    }

    if (success) {

        //NSDictionary *tmpDic = [Transformer dictionaryWithData:responseObject];

        success(responseObject);
    }
    
    [self.operationCachePool removeObjectForKey:URLString];
    
}

// 请求数据失败
- (void)BlockWith:(NSError*)error success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure URL:(NSString *)URLString
{
    
    if (self.isCanceled) {
        
        self.isCanceled = NO;
        
        if (failure) {
            
            failure(error);
        }
        
    }else{

        if (failure) {

            failure(error);
        }

    }
}

////存入本地缓存
//- (void)saveCacheWithURL:(NSString *)URLString responseObject:(id)responseObject {
//
//    //本地缓存，暂时不需要
//    NSString *hash = [URLString md5String];
//
//    NSString *filePath = [self pathForDocumentWithComponent:hash];
//
//    //NSData *data = [Transformer dataWithResponseObject:responseObject];
//
//    [data writeToFile:filePath atomically:YES];
//}
//
////取本地缓存
//- (void)getLocalCacheWith:(NSError*)error success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure URL:(NSString *)URLString {
//
//    //取缓存
//    NSString *hash = [URLString md5String];
//
//    NSString *filePath = [self pathForDocumentWithComponent:hash];
//    NSData *localData = [[NSMutableData alloc]initWithContentsOfFile:filePath];
//    //id responseObject = [Transformer responseObjectWithData:localData];
//    //responseObject = [Transformer dictionaryWithData:responseObject];
//
//    if(responseObject){
//
//        NSLog(@"%@",responseObject);
//
//        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//
//            if (success) {
//
//                success(responseObject);
//            }
//
//            NSLog(@"网络不畅，缓存中取~~~~~~~~");
//        }
//
//    }else {
//
//        NSLog(@"%@~~~",responseObject);
//
//        if (failure) {
//
//            failure(error);
//        }
//    }
//}

// 获取沙盒路径
- (NSString *)pathForDocumentWithComponent:(NSString *)fid
{

    NSString *fullPath = nil;

    if (fid&& [fid length]) {
        
        NSString *path = NSHomeDirectory();
        
        NSString *cacheDiretory= [path stringByAppendingPathComponent:@"Library/Caches/"];
        
        cacheDiretory = [cacheDiretory stringByAppendingPathComponent:@"webCache"];
        
        fullPath = [cacheDiretory stringByAppendingPathComponent:fid];
        
    } else {
        
        fullPath = kWebCachePath;
        
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fullPath]) {
        
        NSError *err=nil;
        
        if ([fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err]) {
            
            return [fullPath stringByAppendingPathComponent:fid];
            
        }else{
            
            [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&err];
            
            return [fullPath stringByAppendingPathComponent:fid];
        }
    }
    
    fullPath = [fullPath stringByAppendingPathComponent:fid];
    
    return fullPath;
}

//取消请求
+ (void)cancelRequest
{
    
    if ([HTTPTool sharedHTTPTool].operationCachePool.count) {
        
        [[HTTPTool sharedHTTPTool].operationCachePool removeAllObjects];
        
        [[HTTPTool sharedHTTPTool].HTTPSession cancelRequest];
        
        [HTTPTool sharedHTTPTool].isCanceled = YES;
    }
    
}

// 获取当前时间
- (NSString*)getDate
{
    
    NSDate* now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; 
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd  HH:mm:ss"];
    
    NSLog(@"%@",[dateFormatter stringFromDate:now]);
    
    return [dateFormatter stringFromDate:now];
}

+ (AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+ (id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}

@end
