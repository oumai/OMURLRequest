//
//  AppDelegate.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/12.
//  Copyright © 2017年 康美. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Reachability.h"
@interface AppDelegate ()
@property (nonatomic, strong) Reachability *hostReach;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    
    
    //编码
    NSString *string = [[NSString alloc] init];
    
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *tranceString = [NSString stringWithString:[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    //1.编码
    
    NSString*hStr =@"你好啊";
    
    NSString*hString = [hStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"hString === %@",hString);
    
    
    
    NSString*hString2 = [hStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"hString2 === %@",hString2);
    
    
    
    NSArray *array = @[@"我",@"你",@"他"];
    NSString *arrayString = [NSString stringWithFormat:@"%@",array];
    
    NSString *str8 = [arrayString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"array = %@   arrayString = %@ ,str8 = %@",array,arrayString,str8);
    
    //解码
    NSString*str3 =@"\u5982\u4f55\u8054\u7cfb\u5ba2\u670d\u4eba\u5458\uff1f";
    
    NSString*str5 = [str3 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString*str6 = [str3 stringByRemovingPercentEncoding];
    
    NSLog(@"str5 ==== %@",str5);
    
    NSLog(@"str6 ==== %@",str6);


    /**
     判断网络的两种方法
     1、导入第三方(Reachability)
     2、AFNetworking自带的方法:  [self linkNet];
     */
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
    
    //[self linkNet];
  
    return YES;

}
#pragma mark -------------------------------------------------------------------------------------------------NET(网络)------------------------------------------------------------
- (void)reachabilityChanged:(NSNotification *)noti
{
    
    Reachability *reachability = [noti object];
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    
    switch (netStatus) {
        case NotReachable:
            NSLog(@"无网络");
            
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi网络");

         
            break;
        case ReachableViaWWAN:
            NSLog(@"移动网络");

                     break;
        default:
            break;
    }
}
- (void)linkNet
{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2.开始检测
    [manager startMonitoring];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    // 检查状态
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        
    }];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
