//
//  RopSign.h
//  kQueueDemo
//


#import <Foundation/Foundation.h>

@interface RopSign : NSObject

+ (NSString *) sign:(NSDictionary *)paramValues secret:(NSString *)secret;


/*
 
 NSDictionary * dict = @{@"method":@"rop.dictionnary.get",
 @"appKey": @"00001",
 @"v":@"1.0",
 @"format":@"json",
 @"parentid":@"100"};
 
 NSString * ret = [RopSign sign:dict secret:@"qwertyuiop"];
 
 NSLog(@"%@", ret);
 
 */

@end
