//
//  MIApi.h
//  mixc
//
//  Created by augsun on 7/5/16.
//  Copyright © 2016 crland. All rights reserved.
//

#ifndef MIApi_h
#define MIApi_h

// 发布(正式包)
#if MC_DISTRIBUTION
    #define API_BASE                    @"https://app.mixcapp.com/"

// 发布(测试包)
#elif MC_DISTRIBUTION_AD_HOC
    // 阿里环境
    #if 1
        #define API_BASE                @"https://app.mixcapp.com/"
    // UAT环境
    #elif 0
        #define API_BASE                @"http://183.234.125.178:8880/"
    // 测试环境
    #else
        #define API_BASE                @"http://183.234.125.178:8800/"
    #endif

// 开发(产生环境 测试环境 开发环境)
#else
    // 生产环境(阿里云)
    #if 0
        #define API_BASE                @"https://app.mixcapp.com/"
    #else
        // 测试环境
        #if 0
            #define API_BASE            @"http://183.234.125.178:8800/"
        #else
            // 开发环境
            #define API_BASE            @"http://10.72.8.97:8001/"
        #endif
    #endif
#endif




// 接口版本
#define API_BASE_V1                     API_BASE"mixc/api/v1/"       // v1 接口使用 API_BASE_V1 基地址
#define API_BASE_V2                     API_BASE"mixc/api/v2/"       // v2 接口使用 API_BASE_V2 基地址

// ====================================================================================================
#pragma mark - H5 页面 rul

// H5 基地址
#define API_BASE_H5                     API_BASE"h5/"

// 抽奖
#define API_H5_LOTTERY                  API_BASE_H5"lottery/index.html"

// 兑换规则
#define API_H5_POINTS                   API_BASE_H5"texthtml/points.html"

// 活动规则
#define API_H5_INVITATION_RULE          API_BASE_H5"texthtml/invitation.html"

// 用户协议
#define API_H5_USER_AGREEMENT           API_BASE_H5"texthtml/userAgreement.html"

// 象果说明
#define API_H5_COIN_EXPLAIN             API_BASE_H5"mixccoin/explain.html"

// 扫码积分自助积分指南
#define API_H5_POINTS_GUIDE             API_BASE_H5"texthtml/pointsGuide.html"

// 万象时间
#define API_H5_MIXCTIME                 API_BASE_H5"mixctime/templets/sign.html"

// 签到记录
#define API_H5_MIXCTIME_SIGNLIST        API_BASE_H5"mixctime/templets/list.html"

// 会员特权
#define API_H5_VIP                      API_BASE_H5"vip/views/mine.html"

// 特权详情
#define API_H5_ALL                      API_BASE_H5"vip/views/all.html?itemId=%@"

// 活动分享
#define API_H5_SHARE_EVENT              API_BASE_H5"share/templates/event.html?eventId=%@"

// 礼品分享
#define API_H5_SHARE_GIFT               API_BASE_H5"share/templates/goods.html?giftId=%@"

// 店铺分享
#define API_H5_SHARE_SHOP               API_BASE_H5"share/templates/shop.html?shopId=%@"

// 邀请好友 (inviteCode<优惠码>, userName<用户昵称>)
#define API_H5_INVITATION               API_BASE_H5"invitation/templets/invitation.html?inviteCode=%@&userName=%@"

// 商场简介
#define API_H5_MALLINFO                 API_BASE_H5"mallinfo/templets/info.html"

// 秒杀团购分享
#define API_H5_DISCOUNTGOOD             API_BASE_H5"share/templates/discountGood.html?gbId=%@"



// ====================================================================================================
#pragma mark - 系统配置
//  系统配置
#define API_CONFIG                      API_BASE_V1"config"

// ====================================================================================================
#pragma mark - 首页
// 首页 G Y(mallNo<商城编码>)
#define API_HOMEPAGE                    API_BASE_V1"homepage"

// 首页活动列表
// G Y(pageNum) N(pageSize)
#define API_HOMEPAGE_EVENT              API_BASE_V1"homepageEvent"

// ====================================================================================================
#pragma mark - 邀请
// U030邀请有礼
// G
#define API_MEMBER_INVITE               API_BASE_V1"member/invite"

// U032邀请奖励详情记录
// G Y(pageNum) N(pageSize)
#define API_MEMBER_INVITE_RECORD        API_BASE_V1"member/invite/rewardRecord"

// ====================================================================================================
#pragma mark - 签到

// ====================================================================================================
#pragma mark - 消息模块
// M最新消息列表
// G Y(mallCode)
#define API_MESSAGEBOX_LATEST           API_BASE_V1"messagebox/latest"

// M某类型消息列表
// G Y(mallCode<商城标识>, notifyType<消息类型 1积分通知，2会员活动，3礼品兑换，4系统通知>, pageNum) N(pageSize)
#define API_MESSAGEBOX_LIST             API_BASE_V1"messagebox/list"

// ====================================================================================================
#pragma mark - 收藏模块
// F001商品收藏列表
// G Y(pageNum) N(pageSize)
#define API_FAVORITE_GIFTS              API_BASE_V1"favorite/gifts"

// F002店铺收藏列表
// G Y(pageNum) N(pageSize)
#define API_FAVORITE_SHOPS              API_BASE_V1"favorite/shops"

// F003批量取消收藏
// G Y(bizIds, bizType)
#define API_FAVORITE_UNFAVORITEBATCH    API_BASE_V1"favorite/unFavoriteBatch"

// 收藏/取消收藏商品/店铺/活动
// G Y(action<动作：favorite/unFavorite>, bizId<业务ID>, bizType<业务类型(10-活动;20-礼品;30-店铺)>)
#define API_FAVORITE_TOGGLE             API_BASE_V1"favorite/toggle"

// F005活动收藏列表
// G Y(pageNum) N(pageSize)
#define API_FAVORITE_EVENT              API_BASE_V1"favorite/event"

// ====================================================================================================
#pragma mark - 搜索模块
// 搜索
// G Y(keyword, mallNo, pageNum) N(pageSize)
#define API_SYSTEM_SEARCH               API_BASE_V1"system/search"

// ====================================================================================================
#pragma mark - 抽奖

// ====================================================================================================
#pragma mark - 找店
// 商场店铺类型和楼层数据
// G Y(mallNo)
#define API_MALL_MALLSHOPINFO           API_BASE_V1"mall/mallShopInfo"

//店铺详情
// G Y(shopId)
#define API_MERCHANT_SHOPID             API_BASE_V1"merchant/"

//找店首页
// G Y(mallNo, pageNum) N(disCountInfos<折扣信息>, shopCode<店铺Code>, shopFloor<商铺楼层>, shopId<商铺id>, shopName<商铺名称>, shopPicture<商铺logo>,  shopType<商铺类型>)
#define API_SEARCHSHOP_MAIN             API_BASE_V1"merchant/searchShop"

// ====================================================================================================
#pragma mark - 扫码
// P010小票记录
// G Y(pageNum) N(pageSize)
#define API_WIPETICKET_RECORD           API_BASE_V1"point/ticketsRecord"

// P011扫码积分
// P Y(cardNumber)
#define API_WIPETICKET_EARNBYRQ         API_BASE_V1"point/earnByQR"

// P012拍照积分
// P Y(mallNo, pictureGroupId)
#define API_WIPETICKET_EARNBYPICTURE    API_BASE_V1"point/earnByPicture"

// ====================================================================================================
#pragma mark - 会员特权

// ====================================================================================================
#pragma mark - 会员卡绑定
// U021手动绑定卡
// G Y(cardNumber<卡号>, mobile<手机号>, mallNo<商城编码>)
#define API_MEMBERCARD_BINDCARD         API_BASE_V1"memberCard/bindCard"

// U022用户绑定的会员卡列表
// G
#define API_MEMBERCARD_MYCARDLIST       API_BASE_V1"memberCard/myCardList"

// U023自动绑卡
// G Y(cardNumber)
#define API_MEMBERCARD_BINDCARDAUTO     API_BASE_V1"memberCard/bindCardAuto"

// ====================================================================================================
#pragma mark - 会员中心
// P004积分兑换象果
// G Y(point<兑换积分数>)
#define API_POINT_EXCHANGEMIXC          API_BASE_V1"point/exchangeMixc"

// P005积分纪录
// G Y(cardNumber, pageNum) N(pageSize)
#define API_POINT_POINTRECORD           API_BASE_V1"point/pointRecord"

//P006象果纪录
// G (bizId <业务id>, content<业务名称>, mixcCoin<象果值>, time<时间>, transferType<象果流转类型[消耗类别包括：O701-活动报名、O702-象果兑礼、O703-象果抽奖；赚取类包括：>, todayCost<今天支出>, totalIncome<总收入>)
#define API_MCRECORD_MCFRUIT            API_BASE_V1"point/mixcRecord"

// R001检查用户名是否存在接口
// G Y(userName<用户名>)
#define API_CHECK_USER_NAME             API_BASE_V1"checkUsername"

// R002发送手机注册验证码接口
// G Y(mob, type<11-手机注册,21-找回密码,31-验证码登录>)
#define API_SEND_CHECK_CODE             API_BASE_V1"sendCheckCode"

// R003验证手机验证码接口
// G Y(code<验证码>, mob<电话号码>, type<验证码类型(11-手机注册,21-找回密码,31-验证码登录)>)
#define API_VERIFY_CHECK_CODE           API_BASE_V1"verifyCheckCode"

// R004手机会员注册接口
// P Y(code, password, userName) N(inviteCode)
#define API_REGISTER                    API_BASE_V1"register"

// R010传统登录接口
// P (password, userName)
#define API_LOGIN                       API_BASE_V1"login"

// R011验证码登录接口
// G (code, userName<用户名>)
#define API_LOGIN_BY_CHECK_CODE         API_BASE_V1"loginByCheckCode"

// R020修改密码接口
// G (password, userName<用户名>)
#define API_CHANGE_PWD                  API_BASE_V1"changePwd"

// R021修改个人信息
// P N(address, area, avatar, birthday, city, gender, idNumber, idType, name, nickName, province
#define API_PROFILE_SAVE                API_BASE_V1"profile/save"

// R022完善个人资料（开卡）
// G Y(mallCode, address, area, birthday, city, gender, idNumber, idType, name, province)
#define API_MEMBERCARD_CREATEPOINTCARD  API_BASE_V1"memberCard/createPointCard"    // 该接口商城编码为 mallCode

// R023获取个人中心数据
// G
#define API_MEMBER_GETPERSONALDATA      API_BASE_V1"member/getPersonalData"

// R024获取用户基本信息
// G
#define API_MEMBER_GETBASEPERSONALDATA  API_BASE_V1"member/getBasePersonalData"

// R090登出系统
// G
#define API_LOGINOUT                    API_BASE_V1@"logout"

// ====================================================================================================
#pragma mark - 上传图片
// 上传图片接口
// P (image, model<模块名称（point为拍照积分模块）>, createThumb, pictureGroupId)
#define API_POSTIMAGE                   API_BASE_V1@"uploadImage"

// ====================================================================================================
#pragma mark - 万象市集
// E001获取活动列表
// G Y(mallNo, pageNum) N(beginTime, endTime, eventType<1为商场活动，2为会员活动>, pageSize, status)
#define API_EVENT_QUERYLIST             API_BASE_V1"event/querylist"

// E002活动详情
// Y(eventId)
#define API_EVENT_INFO                  API_BASE_V1"event/info"

// E004活动报名
// P Y(eventId, participant<姓名>, participantMobileNo) N(eventSessionId<场次>)
#define API_EVENT_SIGNUP                API_BASE_V1"event/signup"

// E006用户报名的活动列表
// G Y(mallNo, pageNum) N(beginTime, endTime, eventType<1为商场活动，2为会员活动>, pageSize, status)
#define API_EVENT_USEREVENTLIST         API_BASE_V1"event/usereventlist"

// G001获取礼品兑换列表
// G Y(mallNo, pageNum) N(giftType, merchantNo, mixcCoinOrder, pageSize, status)
#define API_GIFT_QUERYLIST              API_BASE_V1"gift/querylist"

// G002礼品详情
// G Y(giftId)
#define API_GIFT_INFO                   API_BASE_V1"gift/info"

// G003兑换礼品
// G Y(count, giftId)
#define API_GIFT_EXCHANGE               API_BASE_V1"gift/exchange"

// G004礼品兑换码信息
// G Y(couponNo)
#define API_GIFT_COUPON_INFO            API_BASE_V1"gift/couponinfo"

// G005会员礼品兑换列表
// G (beginTime, endTime, exchangeState, mallNo, pageSize, pageNum)
#define API_GIFT_USERGIFTLIST           API_BASE_V1"gift/usergiftlist"

// G006删除兑换信息
// D Y(couponNo)
#define API_GIFT_DELETE_COUPON_INFO     API_BASE_V1"gift/deletecouponinfo"

// 万象市集首页
// G Y(mallCode)
#define API_MARKET                      API_BASE_V1"mixcMarket"

// 万象市集首页兑换列表
// G Y(mallCode, pageNum) N(pageSize)
#define API_MIXC_MARKETGIFT             API_BASE_V1"mixcMarketGift"

/********************** 以上按协议文档归类, 新增协议依旧写在自已名称下面, 格式参照以上格式 **********************/
/********************** 以上按协议文档归类, 新增协议依旧写在自已名称下面, 格式参照以上格式 **********************/
/********************** 以上按协议文档归类, 新增协议依旧写在自已名称下面, 格式参照以上格式 **********************/
/********************** 以上按协议文档归类, 新增协议依旧写在自已名称下面, 格式参照以上格式 **********************/
/********************** 以上按协议文档归类, 新增协议依旧写在自已名称下面, 格式参照以上格式 **********************/






// ====================================================================================================
#pragma mark 杨健星

// 秒杀列表
// G Y(mallNo)
#define API_GROUPBUY_MIAOSHA            API_BASE_V1"groupbuy/flashsalelist"

// 优惠列表
// G Y(mallNo, pageNum) N(pageSize)
#define API_GROUPBUY_YOUHUI             API_BASE_V1"groupbuy/onsalelist"

// 关注/取消关注
// G Y(gbId, isNofity<是否关注, 1关注, 2取消关注>)
#define API_GROUPBUY_NOFITY             API_BASE_V1"groupbuy/nofity"

// 我的抢购列表
// G
#define API_GROUPBUY_NOFITY_LIST        API_BASE_V1"groupbuy/nofity_list"








// ====================================================================================================
#pragma mark 陈克燚

/**
 *  扫码板块
 */
#pragma  -mark  -扫码

#define API_API_WIPETICKET_MEMEBER_USE  API_BASE_V1"point/earnByQR?m=3001&d=DFACB41260B0F84EC9C763B1B37343C2C50E47FDA25058FABE7D24D5A56AB4CB7A0A094FF3E0E2751AFA3DF5A146495614C4A16E88EE74DBB8822B3EB47D10FE"

#pragma  -mark  -团购订单
#define API_GROUPBUY_ORDER_LIST  API_BASE_V1"groupbuy/order/list"

#define API_GROUPBUY_ORDER_orderDetail  API_BASE_V1"groupbuy/order/orderDetail"

#define API_GROUPBUY_ORDER_orderAction  API_BASE_V1"groupbuy/order/orderAction"

#define API_GROUPBUY_ORDER_cancelRefund API_BASE_V1"groupbuy/order/cancelRefund"

#define API_GROUPBUY_ORDER_applyRefund API_BASE_V1"groupbuy/order/applyRefund"


#define API_ORDER_HELP         API_BASE_H5"texthtml/help.html"

#define API_ORDER_REFUNDDETAL  API_BASE_H5"refund/views/refund.html?"
// ====================================================================================================
#pragma mark 刘祥

//订单列表 类型 1,待支付（订单状态为1），2，待核销（订单状态为2），3退款单（订单状态为7,8,9,10）
#define API_ORDER_LIST                  API_BASE_V1"order/list"

//订单详情
#define API_ORDER_DETAIL                API_BASE_V1"order/detail"

//取消/删除订单  1:取消，2:删除
#define API_ORDER_ACTION                API_BASE_V1"/order/action"

//取消退款申请
#define API_ORDER_CANCELREFUND          API_BASE_V1"order/cancelRefund"

//申请退款
#define API_ORDER_APPLYREFUND           API_BASE_V1"order/applyRefund"

//订单支付（二次支付）
#define API_PAY_TOPAY                   API_BASE_V1"pay/topay"




// ====================================================================================================
#pragma mark 范星星

//退款详情
//G Y(refundsNo)
#define API_ORDER_REFUNDDETAIL          API_BASE_V1"order/refundDetail"





// ====================================================================================================
#pragma mark 陈冬
// 商品详情
#define API_GOOD_DETAIL                  API_BASE_V1"groupbuy/info"

// 生成订单
#define API_GOOD_GENERATEORDER           API_BASE_V1"order/generateOrder"

// 支付结果验证
#define API_GOOD_CHECKPAYRESULT          API_BASE_V1"pay/verifyResult"

// 二次支付
#define API_GOOD_TOPAY                  API_BASE_V1"pay/topay"






#endif /* MIApi_h */










