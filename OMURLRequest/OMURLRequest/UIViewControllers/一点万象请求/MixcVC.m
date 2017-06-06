//
//  MixcVC.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/26.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "MixcVC.h"
#import "MCHttp.h"
#import "MCInline.h"
@interface MixcVC ()

@end

@implementation MixcVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *param = @{
                            @"appVersion" : @"1.0.0",
                            @"imei" : @"ABC3EC5A-502B-4F65-BAA3-E704F30A9E94",
                            @"mallNo" : @"1102A001",
                            @"osVersion" : @"10.3.2",
                            @"pageNum" : @"1",
                            @"platform" : @"iOS",
                            @"timestamp" : @"1496284522272",
                            @"token" : @"92b9f6bd59e24383b433ca76d1f04b31",
                            };
    
    [MCHttp GET:API_SEARCHSHOP_MAIN params:param success:^(NSURLSessionDataTask *task, id json) {
        
        
        if (intValue(json[@"code"]) == 0) {
            
            NSLog(@"json = %@  code= %ld",json[@"code"],intValue(json[@"code"]));
            
            [self ConfigureAlertView:@"请求成功" message:[NSString stringWithFormat:@"%@",json]];
         
            
        }else{
        
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        [self ConfigureAlertView:@"请求失败" message:nil];
    }];
}
- (void)ConfigureAlertView:(NSString *)titleString message:(NSString *)string
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


@end
