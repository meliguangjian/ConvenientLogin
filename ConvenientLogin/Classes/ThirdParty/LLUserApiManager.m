//
//  WxApiManager.m
//  TheThirdPartyLoginDome
//
//  Created by liguangjian on 2017/7/11.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserApiManager.h"

#import "LLUserNetworkManager.h"

@implementation LLUserApiManager

+(void)getWXAccessTokenWithappkey:(NSString *)appkey
                      appsecret:(NSString *)appsecret
                           Code:(NSString *)code
                  success:(requestSuccess)success
                  failure:(requestFailure)failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",appkey,appsecret,code];
    
    [[LLUserNetworkManager defaultClient]requestWithPath:url method:HttpRequestGet parameters:parameters showHud:NO success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];

}

+(void)getWXUserinfoWithToken:(NSString *)token
                     openid:(NSString *)openid
                    success:(requestSuccess)success
                    failure:(requestFailure)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"currentLanguage：%@" , currentLanguage);
    NSString *language;
    if ([currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound)
    {   //繁体中文
        language = @"zh-TW";
    }else if([currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound)
    {   //简体中文
        language = @"zh-CN";
    }else{
        language = @"en";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=%@",token,openid,language];
    [[LLUserNetworkManager defaultClient]requestWithPath:url method:HttpRequestGet parameters:parameters showHud:NO success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



+(void)getQQUserInfoWithToken:(NSString *)token
                        appid:(NSString *)appid
                       openid:(NSString *)openid
                      success:(requestSuccess)success
                      failure:(requestFailure)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"currentLanguage：%@" , currentLanguage);
    NSString *language;
    if ([currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound)
    {   //繁体中文
        language = @"zh-TW";
    }else if([currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound)
    {   //简体中文
        language = @"zh-CN";
    }else{
        language = @"en";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://graph.qq.com/user/get_user_info?access_token=%@&oauth_consumer_key=%@&openid=%@",token,appid,openid];
    
    [[LLUserNetworkManager defaultClient]requestWithPath:url method:HttpRequestGet parameters:parameters showHud:NO success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
