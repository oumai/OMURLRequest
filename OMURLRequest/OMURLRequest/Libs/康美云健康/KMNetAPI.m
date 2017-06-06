//
//  KMNetAPI.m
//  InstantCare
//
//  Created by bruce-zhu on 15/12/4.
//  Copyright © 2015年 omg. All rights reserved.
//

#import "KMNetAPI.h"
//#import "KMUserRegisterModel.h"
#import "AFNetworking.h"
//#import "KMDeviceSettingModel.h"
//#import "KMBundleDevicesModel.h"
//#import "EXTScope.h"
//#import "MJExtension.h"

#define kNetworkReqTimeout      10

@interface KMNetAPI()

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) KMRequestResultBlock requestBlock;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation KMNetAPI

+ (instancetype)manager
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableData data];
    }

    return self;
}

-(void)dealloc{
    NSLog(@"dealloc KMNETAPI %@",self);
}

- (void)postWithURL:(NSString *)url body:(NSString *)body block:(KMRequestResultBlock)block
{
    // debug
    //DMLog(@"-> %@  %@", url, body);

    NSData *httpBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = 60;
    [request setURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPBody:httpBody];
    
    self.requestBlock = block;
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


/**
 *  获取账号信息
 *
 *  @param account 注册的手机号
 *  @param block
 */
- (void)getAccountInfoWithAccount:(NSString *)account
                            Block:(KMRequestResultBlock)block {
    self.requestBlock = block;
    
      
    NSString *url = [NSString stringWithFormat:@"http://%@/kmhc-modem-restful/services/member/accountInfo/%@?_type=json",
                     kServerAddress, account];
    //DMLog(@"-> %@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = kNetworkReqTimeout;
    
    __weak __typeof(self)weakSelf = self;
    [manager GET:url parameters:nil  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                     encoding:NSUTF8StringEncoding];
        //DMLog(@"<- %@", jsonString);
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.requestBlock) {
            strongSelf.requestBlock(0, jsonString);
        }
        self.requestBlock = nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.requestBlock) {
            strongSelf.requestBlock((int)error.code, nil);
        }
        strongSelf.requestBlock = nil;
    }];
}


#pragma mark - 连接成功
- (void)connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)aResponse
{
    self.data.length = 0;
}

#pragma mark 存储数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incomingData
{
    [self.data appendData:incomingData];
}

#pragma mark 完成加载
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *jsonData = [[NSString alloc] initWithData:self.data
                                               encoding:NSUTF8StringEncoding];

    // debug
    DMLog(@"<- %@", jsonData);

    if (self.requestBlock) {
        self.requestBlock(0, jsonData);
    }

    self.requestBlock = nil;
}

#pragma mark 连接错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.requestBlock) {
        self.requestBlock((int)error.code, nil);
    }

    self.requestBlock = nil;
}

#pragma mark - 重构代码

+ (instancetype)sharedInstance{
    static KMNetAPI* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestWithPath:(NSString*)path
          requestType:(RequestType)requestType
           parameters:(NSDictionary*)parameters
       successHandler:(void (^)(id data))success
       failureHandler:(void (^)(NSError *error))failure{
    
     DMLog(@"-> %@", path);
    
    if(requestType == RequestTypeGet){
        [self getRequestWithPath:path successHandler:success failureHandler:failure];
    }
}

-(void)getRequestWithPath:(NSString*)path
           successHandler:(void (^)(id data))success
           failureHandler:(void (^)(NSError *error))failure{
    
//    // 监测网路状态；
//    if ([KMMemberManager sharedInstance].netStatus < 1) {
//        
//        [SVProgressHUD showErrorWithStatus:kNetError];
//        return;
//    }
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = kNetworkReqTimeout;
   
    [manager GET:path
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSString *jsonString = [[NSString alloc] initWithData:responseObject
                                                          encoding:NSUTF8StringEncoding];
             DMLog(@"<- %@", jsonString);
             success(jsonString);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failure(error);
         }];
}

@end


