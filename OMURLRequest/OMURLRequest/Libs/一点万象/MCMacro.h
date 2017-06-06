//
//  MiMacro.h
//  mixc
//
//  Created by augsun on 7/5/16.
//  Copyright © 2016 crland. All rights reserved.
//

#ifndef MCMacro_h
#define MCMacro_h

// ====================================================================================================
#pragma mark - (颜色)Color
// 自定义色
#define COLOR_RANDOM                COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))    // 生成随机颜色
#define COLOR_RGB(r,g,b)            [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define COLOR_RGBA(r,g,b,a)         [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)/1.f]           //
#define COLOR_GRAY_PER(per)         [UIColor colorWithRed:(per)*.01f green:(per)*.01f blue:(per)*.01f alpha:1.f]            // 灰度 [0, 100]
#define COLOR_GRAY_PERA(per, a)     [UIColor colorWithRed:(per)*.01f green:(per)*.01f blue:(per)*.01f alpha:(a)]            // 灰度 + 透明度
#define COLOR_HEXA(hexValue,a)      [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define COLOR_HEX(hexValue)         COLOR_HEXA(hexValue,1.0)        // 十六进制颜色 exp -> COLOR_HEX(0x9daa76)

// 系统色
#define COLOR_SYS_SECTION           COLOR_RGB(239, 239, 244)        // (EFEFF4) section 颜色
#define COLOR_SYS_CELL_LINE         COLOR_RGB(200, 199, 204)        // (C8C7CC) cell分割线颜色
#define COLOR_SYS_CELL_SELECTION    COLOR_RGB(217, 217, 217)        // (D9D9D9) cell选中颜色
#define COLOR_SYS_BLUE              COLOR_RGB(000, 122, 255)        // (007AFF) btn 蓝色
#define COLOR_SYS_TAB_LINE          COLOR_RGB(167, 167, 170)        // (A7A7AA) tab nav 栏的横线
#define COLOR_SYS_TAB_FONT          COLOR_RGB(146, 146, 146)        // (929292) tab nav 栏的灰色字
#define COLOR_SYS_PLACEHOLDER       COLOR_RGB(199, 199, 204)        // (c7c7cc) placeholder
#define COLOR_SYS_IMG_BG            COLOR_RGB(217, 217, 217)        // (D9D9D9) 图片背景
#define COLOR_SYS_SEARCH            COLOR_RGB(200, 200, 206)        // (C8C8CE) 搜索框边上颜色

// MIXC颜色
#define COLOR_MC_MAIN               COLOR_RGB(245, 138,  61)        // (FE8A3D) 主色调 (黄)
#define COLOR_MC_IMG_BG             COLOR_RGB(217, 217, 217)        // (D9D9D9) 图片背景
#define COLOR_MC_VIEW_BG            COLOR_RGB(244, 244, 244)        // (F4F4F4) 视图背景
#define COLOR_MC_BLACK              COLOR_RGB(034, 034, 034)        // (222222) 黑色
#define COLOR_MC_BTN_NORMAL         COLOR_MC_MAIN                   // (F5A21D) 按钮默认状态背景色
#define COLOR_MC_BTN_HIGH           COLOR_RGB(224, 121,  21)        // (E07915) 按钮高亮状态背景色
#define COLOR_MC_BTN_DISABLE        COLOR_SYS_IMG_BG                // (D9D9D9) 按钮禁用状态背景色
#define COLOR_MC_CELL_LINE          COLOR_HEX(0xebebeb)             // (EBEBEB) 分割线颜色

// ====================================================================================================
#pragma mark - 文件存储路径
#define MC_DOCUMENT_DIRECTORY       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define MC_PATH_USER_MODEL          [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_user_model"]
#define MC_PATH_PERSONAL_DATA       [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_personal_data"]
#define MC_PATH_SEARCH_HISTORY      [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_search_history"]
#define MC_PATH_HOME_PAGE           [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_home_page"]
#define MC_PATH_MARKET              [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_market"]
#define MC_PATH_SHOP_INFO           [MC_DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"mixc_shopInfo"]

// ====================================================================================================
#pragma mark - 其它
#define MC_DEALLOC_TEST             - (void)dealloc { NSLog(@"dealloc -> %@",NSStringFromClass([self class])); }    // 对象释放
#define WEAK_SELF                   __weak __typeof(self) weakSelf = self
#define STRONG_SELF                 __strong __typeof(weakSelf) self = weakSelf

#define MCUserDefaults              [NSUserDefaults standardUserDefaults]
#define MC_USER_MODEL               [MCUserManager shareManager].userModel     // 判断用户是否登录 或 取得用户模型 (需要导入 MCUserManager.h 文件)
#define MC_DRAW_OPTION              NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading          // 计算文本属性
#define MC_APPSTORE_URL             @"https://itunes.apple.com/us/app/id1142151719"
#define MC_APP_ID                   @"1142151719"
#define H_STATUSBAR                 20.f                            // 状态栏高
#define H_NAVBAR                    64.f                            // 导航栏高
#define H_TABBAR                    49.f                            // 标签栏高
#define W_SCREEN        [UIScreen mainScreen].bounds.size.width     // 屏幕宽
#define H_SCREEN        [UIScreen mainScreen].bounds.size.height    // 屏幕高
#define IS_320_W                    (W_SCREEN == 320.f ? YES : NO)  // 是否是 320 宽的手机 5s
#define IS_375_W                    (W_SCREEN == 375.f ? YES : NO)  // 是否是 375 宽的手机 6s
#define IS_414_W                    (W_SCREEN == 414.f ? YES : NO)  // 是否是 414 宽的手机 6sP

#define IS_480_H                    (H_SCREEN == 480.f ? YES : NO)  // 是否是 480 高的手机 4s
#define IS_568_H                    (H_SCREEN == 568.f ? YES : NO)  // 是否是 568 高的手机 5s
#define IS_667_H                    (H_SCREEN == 667.f ? YES : NO)  // 是否是 667 高的手机 6s
#define IS_736_H                    (H_SCREEN == 736.f ? YES : NO)  // 是否是 736 高的手机 6sP


// ====================================================================================================
#pragma mark 刘祥
#define LXWidthValue(value) ((value)/750.0f*[UIScreen mainScreen].bounds.size.width)
#define LXHeightValue(value) ((value)/1334.0f*[UIScreen mainScreen].bounds.size.height)



// ====================================================================================================
#pragma mark 范星星

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
//#import "Masonry.h"

#define kHexColor(HexString) [UIColor colorForHexString:HexString]
#define kFontSize(size) [UIFont systemFontOfSize:size]
#define AutoConstraintOfWidth(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)
#define AutoConstraintOfHeight(value) ((value)/667.0f*[UIScreen mainScreen].bounds.size.height)
#define AdjustWidth(value) ((value)/750.0f*[UIScreen mainScreen].bounds.size.width)
#define AdjustHeight(value) ((value)/1334.0f*[UIScreen mainScreen].bounds.size.height)

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

// ====================================================================================================
#pragma mark 陈克燚

#define OrangeishColor COLOR_RGB(254,138,61)

#define QRFunOpen 0

#if (QRFunOpen ==0)
  #define QRAnimtionTime 0.1
#else
  #define QRAnimtionTime 0.5
#endif

#endif /* MiMacro_h */






























