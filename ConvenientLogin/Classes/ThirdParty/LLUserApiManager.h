//
//  WxApiManager.h
//  TheThirdPartyLoginDome
//
//  Created by liguangjian on 2017/7/11.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^requestFailure)(NSError *error);

@interface LLUserApiManager : NSObject


/**
 微信登录获取AccessToken

 @param appkey 腾讯提供的appkey
 @param appsecret 腾讯提供的appsecret
 @param code 授权返回的code
 @param success 返回成功
 @param failure 返回失败
 */
+(void)getWXAccessTokenWithappkey:(NSString *)appkey
                      appsecret:(NSString *)appsecret
                           Code:(NSString *)code
                        success:(requestSuccess)success
                        failure:(requestFailure)failure;

/**
 微信登录获取AccessToken

 @param token 用户信息
 @param openid openid
 @param success 成功返回
 @param failure 返回失败
 */
+(void)getWXUserinfoWithToken:(NSString *)token
                     openid:(NSString *)openid
                    success:(requestSuccess)success
                    failure:(requestFailure)failure;


+(void)getQQUserInfoWithToken:(NSString *)token
                        appid:(NSString *)appid
                       openid:(NSString *)openid
                      success:(requestSuccess)success
                      failure:(requestFailure)failure;


@end
