//
//  BATViewController.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/23.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "BATViewController.h"
#import "HTTPTool.h"
#import "HTTPTool+BATMainRequest.h"
@interface BATViewController ()

@end

@implementation BATViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    [HTTPTool requestWithURLString:@"/api/FamilyDoctor/GetFamilyDoctorList" parameters:@{@"keyword":@"",@"pageIndex":@(0),@"pageSize":@(10)} type:kGET success:^(id responseObject) {
        
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [self ConfigureAlertView:@"请求成功" message:[NSString stringWithFormat:@"%@",responseString]];
        
    } failure:^(NSError *error) {
        
        [self ConfigureAlertView:@"请求失败" message:nil];
    }];
    
}

- (void)ConfigureAlertView:(NSString *)titleString message:(NSString *)string
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
