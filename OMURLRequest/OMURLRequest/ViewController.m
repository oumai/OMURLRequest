//
//  ViewController.m
//  OMURLRequest
//
//  Created by MichaeOu on 2017/5/12.
//  Copyright © 2017年 康美. All rights reserved.
// 本类包含：加密、请求、解密不同的方法。
/*
 1、加密的方式：
 ①base64
 ②MD5(des) 哈希算法之一
 ③POST加密
 ④TOKEN值介绍
 ⑤时间戳密码
 ⑥钥匙串访问
 ⑦指纹识别
 */

#import "ViewController.h"
#import "OMURLConnection.h"
#import "AngelDoctorVC.h"
#import "KMCloudHealthVC.h"
#import "BATViewController.h"
#import "MixcVC.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;  //UITableViewCellSeparatorStyleNone
    [self.view addSubview:_tableView];
    
    
    
    
    int sum = 0;
    int n = 1;
    
    while (sum<1000) {
        sum+= n^3;
        n++;
    }
    
    
    //int i = 1;
    
    
    
    for (int i = 0; i<10000; i++)
    {
        if ((3^i - 2^i) > 1000) {
            
            NSLog(@"i = %d   ^ = %d",i,(3^i - 2^i));
        }

    }

    NSLog(@"log = %f",log10(100000));
    //i++;
    
    
}
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    NSArray *array = @[@"天使医生请求",@"康美云健康请求",@"健康BAT请求",@"一点万象请求"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        AngelDoctorVC *vc = [AngelDoctorVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        KMCloudHealthVC *vc = [KMCloudHealthVC new];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (indexPath.row == 2)
    {
        BATViewController *bat = [BATViewController new];
        [self.navigationController pushViewController:bat animated:YES];
    }
    else if (indexPath.row == 3)
    {
        MixcVC *bat = [MixcVC new];
        [self.navigationController pushViewController:bat animated:YES];
    }

}
@end

