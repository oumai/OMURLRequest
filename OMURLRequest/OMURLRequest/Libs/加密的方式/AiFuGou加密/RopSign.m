//
//  RopSign.m
//  kQueueDemo
//
//

#import "RopSign.h"
#import <CommonCrypto/CommonDigest.h>

@implementation RopSign

+ (NSString *) sign:(NSDictionary *)paramValues secret:(NSString *)secret
{
    NSArray * paramNames = paramValues.allKeys;
    
    NSArray * sortParamNames = [paramNames sortedArrayUsingComparator:^NSComparisonResult(NSString * obj1,NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString * compString = [NSMutableString string];
    
    [compString appendString:secret];
    
    for (NSString * key in sortParamNames) {
        NSString * value = [paramValues objectForKey:key];
        
        if (!value) {
            
            NSLog(@"出错了");
            return nil;
        }
        
        [compString appendString:key];
        
        [compString appendString:value];
    }
    
    [compString appendString:secret];
    
    return [[self sha1:compString] uppercaseString];
  
}

+ (NSString*) sha1:(NSString *)source
{
//    const char *cstr = [source cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:source.length];
    
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
