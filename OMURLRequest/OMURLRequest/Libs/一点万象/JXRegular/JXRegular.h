//
//  RegularHelp.h
//

#import <Foundation/Foundation.h>

@interface JXRegular : NSObject

// 验证 Pwd 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)regularPwdLength_6to20_with_aAtozZ_or_0to9:(NSString *)pwd;

// 验证 Email
+ (BOOL)regularEmail:(NSString *)email;

// 验证 Url
+ (BOOL)regularUrl:(NSString *)url;

// 验证正数
+ (BOOL)regularPositiveNumber:(NSString *)number;

// 非负浮点数
+ (BOOL)regularUnNegativeFloat:(NSString *)unNegativeFloat;

// 验证用户名 满足 6-20位 的a-z A-Z 0-9组成
+ (BOOL)regularUserNameLength_3to20_with_aAtozZ_or_0to9:(NSString *)userName;

// 验证手机号
+ (BOOL)regularMobile:(NSString *)mobile;

// 验证6位数字验证码
+ (BOOL)regularAuthCode6:(NSString *)code6;

// 验证昵称 满足中文 大小写字母 数字
+ (BOOL)regularNickName:(NSString *)nickName;

// 验证中文
+ (BOOL)regularChinese:(NSString *)chinese;

// 验证是否有空格
+ (BOOL)regularHaveSpace:(NSString *)string;

// 验证单个字符是否是 ASCII 码
+ (BOOL)regularIsAscii:(NSString *)ascii;

// 验证是否 数字 大小写字母
+ (BOOL)regularIs_aAtozZ_or_0to9:(NSString *)charAndNumber;

// 昵称(满足中文 大小写字母 数字)的长度 (中文当两个字符, 数字 字母为一个字符)
+ (NSInteger)regularLengthOfNickName:(NSString *)nickName;

// 验证 18 位身份证
+ (BOOL)regularIDCard:(NSString *)idCard;

@end









