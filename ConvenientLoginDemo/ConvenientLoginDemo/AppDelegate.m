//
//  AppDelegate.m
//  ConvenientLoginDemo
//
//  Created by liguangjian on 2017/7/27.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"
#import <WeiboSDK.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Twitter/Twitter.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "LLUserThirdPartyLoginManger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LLUserThirdPartyLoginManger registerActivePlatforms:@[@(LLUserSdkPlatformTypeSinaWeibo),@(LLUserSdkPlatformTypeTencentWeiXin),@(LLUserSdkPlatformTypeTwitter),@(LLUserSdkPlatformTypeQQ),@(LLUserSdkPlatformTypeFacebook)] onImport:^(LLUserSdkPlatformType platformType) {
        
        switch (platformType)
        {
            case LLUserSdkPlatformTypeSinaWeibo:
                [LLUserSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            case LLUserSdkPlatformTypeTencentWeiXin:
                [LLUserSDKConnector connectWeChat:[WXApi class] delegate:self];
                break;
            case LLUserSdkPlatformTypeFacebook:
                [LLUserSDKConnector connectFacebook:[FBSDKApplicationDelegate class] launchOptions:launchOptions];
                break;
            case LLUserSdkPlatformTypeTwitter:
                [LLUserSDKConnector connectTwitter:[Twitter class]];
                break;
            case LLUserSdkPlatformTypeQQ:
                [LLUserSDKConnector connectQQ];
                
                break;
            default:
                break;
        }
        
    } onConfiguration:^(LLUserSdkPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {     //facebook请在info.plist上设置FacebookAppID跟FacebookDisplayName
            case LLUserSdkPlatformTypeSinaWeibo:
                [appInfo LLUserSDKSetupSinaWeiboByAppKey:@"1634853870" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUri:@"https://www.baidu.com"];
                
                break;
            case LLUserSdkPlatformTypeTencentWeiXin:
                [appInfo LLUserSDKSetupWeChatByAppId:@"wxc60eab93d2dba545" appSecret:@"6d033ba665bb11207b5c43fc13d06d5d"];
                
                break;
            case LLUserSdkPlatformTypeQQ:
                [appInfo LLUserSDKSetupQQAppKey:@"1104957962"];
                
                break;
            case LLUserSdkPlatformTypeTwitter:
                [appInfo LLUserSDKSetupTwitterByConsumerKey:@"uS0oG2HGdJu7VzrzMtcuQUSYX" consumerSecret:@"CMY0X8dIsuIEOBHL6ED8SLFRjhsIISllQ1TlXVEVyU6PLOupw0" redirectUri:nil];
                
                break;
            default:
                break;
        }
        
    }];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
