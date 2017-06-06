//
//  AngelDoctorRequest.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/26.
//  Copyright © 2017年 康美. All rights reserved.
//
/*  
 UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 button.backgroundColor = [UIColor blueColor];
 button.frame = CGRectMake(100, 100, 100, 100);
 [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
 [self.view addSubview:button];
*/

#import "AngelDoctorVC.h"

@interface AngelDoctorVC ()

@end

@implementation AngelDoctorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /**
     请求数据。
     1、加密
     2、请求
     3、解密(把请求出来的数据转换成普通数据）
     */
    
    NSDictionary *json = nil;
    
    
    NSString *stringMethod = nil;
    
    
    NSInteger integer = 0;
    
    switch (integer) {
        case 0:
            //诊所规则
            json = @{};
            stringMethod = @"jumper.clinic.doctor.getClinicRuleList";
            break;
        case 1:
            //主页
            json=@{@"doctor_id":@"12663"};               //主页
            stringMethod = @"jumper.clinic.doctor.getclinichomepage";
            break;
        case 2:
            //明星医生
            json = @{@"page_index":@1,@"page_size":@30}; //明星医生
            stringMethod = @"jumper.clinic.doctor.getstardoctor";
            
            break;
            
        default:
            break;
    }
    
    [OMURLConnection requestAngelDoctorAFNJSon:json method:stringMethod view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[OMURLConnection getMsg:responseObject] isEqual:@1])
        {
            NSLog(@"请求成功");
            NSArray *dataArr = [[[OMURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            NSLog(@"%@=====%ld",dataArr,dataArr.count);
            
            [self ConfigureAlertView:@"请求成功" message:[NSString stringWithFormat:@"%@",dataArr]];

        }
        
    } errorBlock:^(NSError *error) {
        
        [self ConfigureAlertView:@"请求失败" message:nil];

    }];

}

- (void)ConfigureAlertView:(NSString *)titleString message:(NSString *)string
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}


@end
