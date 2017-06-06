//
//  KMCloudHealthVC.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/26.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "KMCloudHealthVC.h"
#import "KMNetAPI.h"
@interface KMCloudHealthVC ()

@end

@implementation KMCloudHealthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    [[KMNetAPI manager] getAccountInfoWithAccount:@"13246766960" Block:^(int code, NSString *res)
     {
         
         if (code == 0 )
         {
             NSLog(@"请求成功  res = %@",res);
             [self ConfigureAlertView:@"请求成功" message:res];
         }
     }];

}
- (void)ConfigureAlertView:(NSString *)titleString message:(NSString *)string
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titleString message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
