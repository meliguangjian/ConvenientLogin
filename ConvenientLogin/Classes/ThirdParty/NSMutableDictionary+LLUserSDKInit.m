//
//  NSMutableDictionary+SSDKInit.m
//  ThirdPartyLoginDemo
//
//  Created by liguangjian on 2017/7/13.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "NSMutableDictionary+LLUserSDKInit.h"

@implementation NSMutableDictionary (LLUserSDKInit)

- (void)LLUserSDKSetupSinaWeiboByAppKey:(NSString *)appKey
                         appSecret:(NSString *)appSecret
                       redirectUri:(NSString *)redirectUri{
    if (appKey) {
        [self setObject:appKey forKey:@"appKey"];
    }
    if (appSecret) {
        [self setObject:appSecret forKey:@"appSecret"];
    }
    if (redirectUri) {
        [self setObject:redirectUri forKey:@"redirectUri"];
    }
}

- (void)LLUserSDKSetupWeChatByAppId:(NSString *)appId
                          appSecret:(NSString *)appSecret{
    if (appId) {
        [self setObject:appId forKey:@"appId"];
    }
    if (appSecret) {
        [self setObject:appSecret forKey:@"appSecret"];
    }
}

-(void)LLUserSDKSetupTwitterByConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret redirectUri:(NSString *)redirectUri{
    if (consumerKey) {
        [self setObject:consumerKey forKey:@"consumerKey"];
    }
    if (consumerSecret) {
        [self setObject:consumerSecret forKey:@"consumerSecret"];
    }
    if (redirectUri) {
        [self setObject:redirectUri forKey:@"redirectUri"];
    }
    
}

- (void)LLUserSDKSetupQQAppKey:(NSString *)appKey{
    if (appKey) {
        [self setObject:appKey forKey:@"appKey"];
    }
    
}

@end
