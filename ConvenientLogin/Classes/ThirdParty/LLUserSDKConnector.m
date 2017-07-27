//
//  LLUserSDKConnector.m
//  ThirdPartyLoginDemo
//
//  Created by liguangjian on 2017/7/17.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserSDKConnector.h"

#import <UIKit/UIKit.h>
#import "LLUserThirdPartyAccount.h"

@implementation LLUserSDKConnector

+ (void)connectWeChat:(Class)wxApiClass delegate:(id)delegate{
    LLUserThirdPartyAccount *accout = [LLUserThirdPartyAccount sharedInstance];
//    registerApp:wxappkey enableMTA:YES];
    [wxApiClass performSelector:@selector (registerApp:enableMTA:) withObject:accout.weiXinAccountInfo[@"appId"] withObject:@NO];
}

+ (void)connectWeibo:(Class)weiboSDKClass{
    
    LLUserThirdPartyAccount *accout = [LLUserThirdPartyAccount sharedInstance];
    
//    [weiboSDKClass performSelector:@selector (enableDebugMode:) withObject:@YES];
    [weiboSDKClass performSelector:@selector (registerApp:) withObject:accout.weiboAccountInfo[@"appKey"] ]; //调用选择器方法
}

+ (void)connectQQ{
    [[LLUserThirdPartyAccount sharedInstance]createQQOauth];
}

+ (void)connectTwitter:(Class)twitterClass{
    LLUserThirdPartyAccount *accout = [LLUserThirdPartyAccount sharedInstance];
    
    [[twitterClass sharedInstance]performSelector:@selector (startWithConsumerKey:consumerSecret:)withObject:accout.twitterAccountInfo[@"consumerKey"] withObject:accout.twitterAccountInfo[@"consumerSecret"]];
}

+ (void)connectFacebook:(Class)fbmApiClass launchOptions:(NSDictionary *)launchOptions{
    UIApplication *application = [UIApplication sharedApplication];
    
    [[fbmApiClass sharedInstance]performSelector:@selector (application:didFinishLaunchingWithOptions:) withObject:application withObject:launchOptions];
    
}

@end
