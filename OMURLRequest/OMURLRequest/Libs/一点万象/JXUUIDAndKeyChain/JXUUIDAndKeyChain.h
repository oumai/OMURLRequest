//
//  JXUUIDAndKeyChain.h
//  KeyChain
//
//  Created by augsun on 3/25/15.
//  Copyright © 2015 codersun. All rights reserved.
//

/** 确保 provisioning profile 一致 */

#import <Foundation/Foundation.h>

@interface JXUUIDAndKeyChain : NSObject

/** 取得 UUID */
+ (NSString *)UUID;

/** 保存或更新 */
+ (void)setObject:(id)object forKey:(NSString *)key;

/** 取出 */
+ (id)objectForKey:(NSString *)key;

/** 删除 */
+ (void)removeObjectForKey:(NSString *)key;

@end









