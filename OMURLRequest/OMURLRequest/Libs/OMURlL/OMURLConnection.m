//
//  OMURLConnection.m
//  AiFuGou
//
//  Created by Michael on 16/6/16.
//  Copyright © 2016年 jumper. All rights reserved.
//
#import "OMURLConnection.h"
#import "RopSign.h"
@implementation OMURLConnection

+(NSNumber *)getMsg:(id)data
{
    
    NSNumber *msg = [NSNumber numberWithInteger:[[(NSDictionary *)[[self doDESDecrypt:data] objectFromJSONString]objectForKey:@"msg"] integerValue]];
    return msg;
}


//加密
+(NSString *)doDEStoGetJson:(NSDictionary *)jsondict andMethod:(NSString *)method andVersion:(NSString *)version{
    
    NSString *jsonString = [jsondict JSONString];
    //    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *des = [[DesEncrypt encryptUseDES:jsonString key:pKey] uppercaseString];
    NSString *md5 = [[DesEncrypt md5:[NSString stringWithFormat:@"%@method%@params%@%@",sKey,method,des,sKey] ]uppercaseString];
    NSString *url;
    url = [NSString stringWithFormat:OMURLSring,normalUrl,version,method,des,md5];
    return url;
}

//解密
+ (NSString *)doDESDecrypt:(id)data
{
    
    NSString *str = [DesEncrypt decryptUseDES:data key:@"*JUMPER*"];
    str = [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [str stringByReplacingOccurrencesOfString:@"+"withString:@" "];
}

//爱福购项目的请求方法
+(void)requestAiFuGouAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    
    

    
    NSString *ret = [RopSign sign:dic secret:@"qwertyuiop"];
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:dic];  //下面是post请求的参数
    [newdic setObject:ret forKey:@"sign"];
    
    [manager POST:method parameters:newdic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];                         //这里的responseString是json串
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];//这里是把数据转化为字典了
        
        NSLog(@"responseString = %@",responseString);
        NSLog(@"dataDic == %@",content);    //成功返回
        completeBlock(nil,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败");
        NSLog(@"error == %@",error);        //失败返回
        errorBlock(error);
        
    }];
}

+(void)decryptionResonseObject:(id)data
{
    [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//这里是把数据转化为字典了
}


//天使医生请求的方法
+(void)requestAngelDoctorAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    
    NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    
    // AFN的经典Manager
    AFHTTPSessionManager *managerRequest = [AFHTTPSessionManager manager];
    managerRequest.requestSerializer     = [AFHTTPRequestSerializer serializer];
    managerRequest.responseSerializer    = [AFHTTPResponseSerializer serializer];
    
    
    // Get模式请求
    [managerRequest GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];                         //这里的responseString是json串
        
        k_NslogDesData;
        if (completeBlock)
        {
            completeBlock(nil,responseString);
        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败：error = %@",error); // 这里打印错误信息
        errorBlock(error);

    }];
    
  
}
@end
