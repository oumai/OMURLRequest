//
//  RegularHelp.m
//

#import "JXRegular.h"

@implementation JXRegular

// 验证 Pwd 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)regularPwdLength_6to20_with_aAtozZ_or_0to9:(NSString *)pwd {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z0-9]{6,20}$"] evaluateWithObject:pwd];
}

// 验证 Email
+ (BOOL)regularEmail:(NSString *)email {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"] evaluateWithObject:email];
}

// 验证 Url
+ (BOOL)regularUrl:(NSString *)url {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"] evaluateWithObject:url];
}

// 验证正数
+ (BOOL)regularPositiveNumber:(NSString *)number {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]+$"] evaluateWithObject:number];
}

+ (BOOL)regularUnNegativeFloat:(NSString *)unNegativeFloat {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d+(\\.\\d+)?$"] evaluateWithObject:unNegativeFloat];
}

// 验证用户名 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)regularUserNameLength_3to20_with_aAtozZ_or_0to9:(NSString *)userName {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z0-9]{6,20}$"] evaluateWithObject:userName];
}

// 验证手机号
+ (BOOL)regularMobile:(NSString *)mobile {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1[3|4|5|7|8][0-9][0-9]{8}$"] evaluateWithObject:mobile];//@"^1[34578]\\d{9}$"
}

// 验证6位数字验证码
+ (BOOL)regularAuthCode6:(NSString *)code6 {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"\\d{6}"] evaluateWithObject:code6];
}

// 验证昵称 满足中文 大小写字母 数字
+ (BOOL)regularNickName:(NSString *)nickName {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[a-zA-Z0-9\u4e00-\u9fa5]+$"] evaluateWithObject:nickName];
}

// 验证中文
+ (BOOL)regularChinese:(NSString *)chinese {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\u4e00-\u9fa5]+$"] evaluateWithObject:chinese];
}

// 验证是否有空格
+ (BOOL)regularHaveSpace:(NSString *)string {
    return ![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(?m)^[\\S]*$"] evaluateWithObject:string];
}

// 验证单个字符是否是 ASCII 码
+ (BOOL)regularIsAscii:(NSString *)ascii {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\x00-\x7F]"] evaluateWithObject:ascii];
}

// 验证是否 数字 大小写字母
+ (BOOL)regularIs_aAtozZ_or_0to9:(NSString *)charAndNumber {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[A-Za-z0-9]+$"] evaluateWithObject:charAndNumber];
}

// 昵称(满足中文 大小写字母 数字)的长度 (中文当两个字符, 数字 字母为一个字符)
+ (NSInteger)regularLengthOfNickName:(NSString *)nickName {
    NSInteger len = nickName.length;
    NSInteger lenActual = 0;
    for (NSInteger i = 0; i < len; i ++) {
        NSString *strChar = [nickName substringWithRange:NSMakeRange(i, 1)];
        if (![self regularIsAscii:strChar]) lenActual += 2;
        else lenActual ++;
    }
    return lenActual;
}

// 验证 18 位身份证
+ (BOOL)regularIDCard:(NSString *)idCard {
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\\d]{15}|[\\d]{17}[\\dxX]{1}$"] evaluateWithObject:idCard];
}

@end









