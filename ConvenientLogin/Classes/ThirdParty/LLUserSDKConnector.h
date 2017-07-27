//
//  LLUserSDKConnector.h
//  ThirdPartyLoginDemo
//
//  Created by liguangjian on 2017/7/17.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLUserSDKConnector : NSObject

/**
 *  链接微信API已供ShareSDK可以正常使用微信的相关功能
 *
 *  @param wxApiClass 微信SDK中的类型，应先导入libWXApi.a，再传入[WXApi class]到此参数。注：此参数不能为nil，否则会导致授权、分享无法正常使用
 *  @param delegate 对于需要获取微信回复或请求时传入该委托对象。该对象必须实现WXApiDelegate协议中的方法。
 */
+ (void)connectWeChat:(Class)wxApiClass delegate:(id)delegate;

/**
 *  连接微博API以供ShareSDK可以使用微博客户端来分享内容，不调用此方法也不会影响应用授权等相关功能。
 *
 *  @param weiboSDKClass 微博SDK中的类型，应先导入libWeiboSDK.a,再传入[WeiboSDK class]到此参数.
 */
+ (void)connectWeibo:(Class)weiboSDKClass;

/**
 *  连接QQAPI以供ShareSDK可以正常使用QQ来授权。
 *
 * 应先导入TencentOpenAPI.framework，再调用。
 */
+ (void)connectQQ;


/**
 *  链接Facebook Messenger以供ShareSDK可以正常使用Facebook Messenger的相关功能
 *
 *  @param fbmApiClass Facebook Messenger SDK中的类型，应先导入FBSDKMessengerShareKit.framework，再将[FBSDKMessengerSharer class]传入到参数中。
 */
+ (void)connectFacebook:(Class)fbmApiClass launchOptions:(NSDictionary *)launchOptions;

+ (void)connectTwitter:(Class)twitterClass;

@end
