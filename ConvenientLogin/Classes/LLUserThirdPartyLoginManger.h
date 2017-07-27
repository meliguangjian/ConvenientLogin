//
//  ThirdPartyLoginManger.h
//  TheThirdPartyLoginDome
//
//  Created by liguangjian on 2017/7/11.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LLUserConstant.h"
#import "LLUserSDKConnector.h"
#import "NSMutableDictionary+LLUserSDKInit.h"

typedef void(^LLUserSdkImportHandler) (LLUserSdkPlatformType platformType);

typedef void(^complete)( id responseObject,NSError *error);

typedef void(^LLUserSdkConfigurationHandler) (LLUserSdkPlatformType platformType, NSMutableDictionary *appInfo);

@interface LLUserThirdPartyLoginManger : NSObject


+(void)registerActivePlatforms:(NSArray *)activePlatforms
                      onImport:(LLUserSdkImportHandler)importHandler
               onConfiguration:(LLUserSdkConfigurationHandler)configurationHandler;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

+(void)activateApp;

+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+(void)logoutType:(LLUserSdkPlatformType)type;

@end
