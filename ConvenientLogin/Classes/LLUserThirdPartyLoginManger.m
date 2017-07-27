//
//  ThirdPartyLoginManger.m
//  TheThirdPartyLoginDome
//
//  Created by liguangjian on 2017/7/11.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserThirdPartyLoginManger.h"

#import "LLUserThirdPartyAccount.h"
#import "LLUserFormatTime.h"
#import "LLUserLocalizable.h"

@implementation LLUserThirdPartyLoginManger

+(void)registerActivePlatforms:(NSArray *)activePlatforms
                      onImport:(LLUserSdkImportHandler)importHandler
               onConfiguration:(LLUserSdkConfigurationHandler)configurationHandler{
    
    LLUserThirdPartyAccount *account = [LLUserThirdPartyAccount sharedInstance];
    
    for (int i = 0;i < activePlatforms.count;i++) {
        
        LLUserSdkPlatformType type = [activePlatforms[i] integerValue];
        
        //------------------配置各平台参数     start   ------------------
        if (type == LLUserSdkPlatformTypeSinaWeibo) {
            
            account.weiboAccountInfo = [NSMutableDictionary dictionary];
            
            configurationHandler(type,account.weiboAccountInfo);
        }
        if (type == LLUserSdkPlatformTypeQQ) {
            account.qqAccountInfo = [NSMutableDictionary dictionary];
            
            configurationHandler(type,account.qqAccountInfo);
        }
        if (type == LLUserSdkPlatformTypeTencentWeiXin) {
            account.weiXinAccountInfo = [NSMutableDictionary dictionary];
            
            configurationHandler(type,account.weiXinAccountInfo);
        }
        if (type == LLUserSdkPlatformTypeFacebook) {
            account.facebookAccountInfo = [NSMutableDictionary dictionary];
            
            configurationHandler(type,account.facebookAccountInfo);
        }
        if (type == LLUserSdkPlatformTypeTwitter) {
            account.twitterAccountInfo = [NSMutableDictionary dictionary];
            
            configurationHandler(type,account.twitterAccountInfo);
        }
        //------------------配置各平台参数     end   ------------------
        importHandler(type);
        
    }
    
}


+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
   
    
    return YES;
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([url.absoluteString hasPrefix:@"wb"]) {
        
        return [NSClassFromString(@"WeiboSDK") performSelector:@selector (sendRequest::) withObject:url withObject:[LLUserThirdPartyAccount sharedInstance]];
    }
    
    if ([url.absoluteString hasPrefix:@"tencent"]) {
        return [NSClassFromString(@"TencentOAuth") performSelector:@selector (HandleOpenURL:) withObject:url];
    }
    if ([url.absoluteString hasPrefix:@"fb"]) {
//        [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        
        id fbsdkdelegate = [NSClassFromString(@"FBSDKApplicationDelegate") performSelector:@selector (sharedInstance)];
        
        SEL selector = @selector(application:openURL:sourceApplication:annotation:);
        
        NSMethodSignature *signature = [fbsdkdelegate methodSignatureForSelector:selector];
        //1、创建NSInvocation对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = fbsdkdelegate;
        //invocation中的方法必须和签名中的方法一致。
        invocation.selector = selector;
        [invocation setArgument:&application atIndex:2];
        [invocation setArgument:&url atIndex:3];
        [invocation setArgument:&sourceApplication atIndex:4];
        [invocation setArgument:&sourceApplication atIndex:5];
        [invocation invoke];
        id res = nil;
        if (signature.methodReturnLength!=0) {
            //getReturnValue获取返回值
            [invocation getReturnValue:&res];
        }
//        NSLog(@"res%@",res);
        return YES;
    }
    
    return YES;
}

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    if ([url.absoluteString hasPrefix:@"wx"]) {
//        return [WXApi handleOpenURL:url delegate:self];
        return [NSClassFromString(@"WXApi") performSelector:@selector (handleOpenURL:delegate:) withObject:url withObject:[LLUserThirdPartyAccount sharedInstance]];
    }
    if ([url.absoluteString hasPrefix:@"tencent"]) {
        return [NSClassFromString(@"TencentOAuth") performSelector:@selector (HandleOpenURL:) withObject:url];
    }
    if ([url.absoluteString hasPrefix:@"wb"]) {
        return [NSClassFromString(@"WeiboSDK") performSelector:@selector (handleOpenURL:delegate:) withObject:url withObject:[LLUserThirdPartyAccount sharedInstance]];
    }
    if([url.absoluteString hasPrefix:@"fb"]){
        id fbsdkdelegate = [NSClassFromString(@"FBSDKApplicationDelegate") performSelector:@selector (sharedInstance)];
        
        SEL selector = @selector(application:openURL:options:);
        
        NSMethodSignature *signature = [fbsdkdelegate methodSignatureForSelector:selector];
        //1、创建NSInvocation对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = fbsdkdelegate;
        //invocation中的方法必须和签名中的方法一致。
        invocation.selector = selector;
        [invocation setArgument:&app atIndex:2];
        [invocation setArgument:&url atIndex:3];
        [invocation setArgument:&options atIndex:4];
        [invocation invoke];
//        id res = nil;
//        if (signature.methodReturnLength!=0) {
//            //getReturnValue获取返回值
//            [invocation getReturnValue:&res];
//        }
//        NSLog(@"res%d",res);
        return YES;
        
    }
    if([url.absoluteString hasPrefix:@"Twitter"]){
//        return [[Twitter sharedInstance] application:app openURL:url options:options];
        id tw = [NSClassFromString(@"Twitter") performSelector:@selector (sharedInstance)];
        
        SEL selector = @selector(application:openURL:openURL:options:);
        
        NSMethodSignature *signature = [tw methodSignatureForSelector:selector];
        //1、创建NSInvocation对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = tw;
        //invocation中的方法必须和签名中的方法一致。
        invocation.selector = selector;
        [invocation setArgument:&app atIndex:2];
        [invocation setArgument:&url atIndex:3];
        [invocation setArgument:&options atIndex:4];
        [invocation invoke];
        id res = nil;
        if (signature.methodReturnLength!=0) {
            //getReturnValue获取返回值
            [invocation getReturnValue:&res];
        }
//        NSLog(@"res%@",res);
        return res;
    }
    
    return YES;
}

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([url.absoluteString hasPrefix:@"wb"]) {
        return [NSClassFromString(@"WeiboSDK") performSelector:@selector (handleOpenURL:delegate:) withObject:url withObject:[LLUserThirdPartyAccount sharedInstance]];
//        return [WeiboSDK handleOpenURL:url delegate:self];
    }else if([url.absoluteString hasPrefix:@"tencent"]){
        return [NSClassFromString(@"TencentOAuth") performSelector:@selector (HandleOpenURL:) withObject:url];
//        return [TencentOAuth HandleOpenURL:url];
    }else if([url.absoluteString hasPrefix:@"wx"]){
        return [NSClassFromString(@"WXApi") performSelector:@selector (handleOpenURL:delegate:) withObject:url withObject:[LLUserThirdPartyAccount sharedInstance]];
//        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return YES;
    }
    return YES;
}
+(void)activateApp{
    if (NSClassFromString(@"FBSDKAppEvents")) {
        [NSClassFromString(@"FBSDKAppEvents") performSelector:@selector (activateApp)];
    }
}


+(void)logoutType:(LLUserSdkPlatformType)type{
    [LLUserThirdPartyAccount logoutType:type];
}

@end
