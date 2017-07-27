//
//  NSMutableDictionary+ShareSDK.h
//  TheThirdPartyLoginDome
//
//  Created by liguangjian on 2017/7/11.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SSDKTypeDefine.h"

/**
 *  初始化平台相关
 */
@interface NSMutableDictionary (LLUserSDKInit)


/**
 *  设置新浪微博应用信息
 *
 *  @param appKey       应用标识
 *  @param appSecret    应用密钥
 *  @param redirectUri  回调地址
 
 */
- (void)LLUserSDKSetupSinaWeiboByAppKey:(NSString *)appKey
                         appSecret:(NSString *)appSecret
                       redirectUri:(NSString *)redirectUri;

/**
 *  设置微信(微信好友，微信朋友圈、微信收藏)应用信息
 *
 *  @param appId      应用标识
 *  @param appSecret  应用密钥
 */
- (void)LLUserSDKSetupWeChatByAppId:(NSString *)appId
                     appSecret:(NSString *)appSecret;

/**
 *  设置Twitter应用信息
 *
 *  @param consumerKey    应用标识
 *  @param consumerSecret 应用密钥
 *  @param redirectUri    回调地址
 */
- (void)LLUserSDKSetupTwitterByConsumerKey:(NSString *)consumerKey
                       consumerSecret:(NSString *)consumerSecret
                          redirectUri:(NSString *)redirectUri;

/**
 *  设置QQ平台应用信息
 *
 *  @param appKey         应用Key
 */
- (void)LLUserSDKSetupQQAppKey:(NSString *)appKey;



@end
