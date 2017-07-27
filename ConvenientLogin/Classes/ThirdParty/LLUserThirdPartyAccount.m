//
//  AccountManger.m
//  ThirdPartyLoginDemo
//
//  Created by liguangjian on 2017/7/18.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserThirdPartyAccount.h"

#import "LLUserApiManager.h"
#import "LLUserLocalizable.h"

LLUserThirdPartyAccount *accout;

id tencentOAuth;

LLUserAuthorizeStateChangedHandler stateHandler;


@implementation LLUserThirdPartyAccount

+ (id)sharedInstance
{
    __strong static LLUserThirdPartyAccount *sharedInstance = nil;
    if (sharedInstance == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            sharedInstance = [[self alloc] init];
            accout = [LLUserThirdPartyAccount sharedInstance];
        });
    }
    return sharedInstance;
}

-(void)createQQOauth{

    if (NSClassFromString(@"TencentOAuth")) {
        
        tencentOAuth = [[NSClassFromString(@"TencentOAuth") alloc]performSelector:@selector(initWithAppId:andDelegate:) withObject:accout.qqAccountInfo[@"appKey"] withObject:self];
        
    }
    
}

+ (void)authorize:(LLUserSdkPlatformType)type
currentViewController:(UIViewController *)controller
   onStateChanged:(LLUserAuthorizeStateChangedHandler)stateChangedHandler{
    
    stateHandler = stateChangedHandler;
    
    if (type == LLUserSdkPlatformTypeSinaWeibo) {
        if (NSClassFromString(@"WBAuthorizeRequest")) {
            Class wbReqClass = [NSClassFromString(@"WBAuthorizeRequest") performSelector:@selector (request)];
            
            [wbReqClass performSelector:@selector (setRedirectURI:) withObject:accout.weiboAccountInfo[@"redirectUri"] ];
            
            [wbReqClass performSelector:@selector (setScope:) withObject:@"all"];
            
            [wbReqClass performSelector:@selector (setUserInfo:) withObject:@{@"SSO_From": @"LLUser"}];
            
            [NSClassFromString(@"WeiboSDK") performSelector:@selector (sendRequest:) withObject:wbReqClass];
        }
        
    }
    if (type == LLUserSdkPlatformTypeQQ) {
        if (NSClassFromString(@"TencentOAuth")){
            NSArray* permissions = [NSArray arrayWithObjects:
                                    @"get_user_info",
                                    @"get_simple_userinfo",
                                    @"get_info",
                                    @"get_vip_info",
                                    @"get_vip_rich_info",
                                    nil];
            
            [tencentOAuth performSelector:@selector(authorize:inSafari:) withObject:permissions withObject:@NO];
        }
    }
    if (type == LLUserSdkPlatformTypeTencentWeiXin) {
        if (NSClassFromString(@"SendAuthReq")) {
            id sendReq = [[NSClassFromString(@"SendAuthReq") alloc]init];
            [sendReq performSelector:@selector (setScope:) withObject:@"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"];
            [sendReq performSelector:@selector (setState:) withObject:@"xxx"];
            
            SEL selector = @selector(sendAuthReq:viewController:delegate:);
            
            NSMethodSignature *signature = [NSClassFromString(@"WXApi") methodSignatureForSelector:selector];
            //1、创建NSInvocation对象
            NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
            invocation.target = NSClassFromString(@"WXApi");
            //invocation中的方法必须和签名中的方法一致。
            invocation.selector = selector;
            [invocation setArgument:&sendReq atIndex:2];
            [invocation setArgument:&controller atIndex:3];
            [invocation setArgument:&self atIndex:4];
            [invocation invoke];
        }
        
        
        
    }
    if (type == LLUserSdkPlatformTypeFacebook) {
        
        id fbManager = [[NSClassFromString(@"FBSDKLoginManager")alloc]init];
    
//        [fbManager setObject:@3 forKey:@"loginBehavior"];
        
        void (^fbLogInWithCompletion)(id ,NSError* ) = ^(id result,NSError *error){
            NSLog(@"result:%@",result);
            
            BOOL isCancelled = [[result valueForKey:@"isCancelled"]boolValue];
            if (error) {
                
                stateHandler(LLUserResponseStateFail,nil,error);
            
            }else if (isCancelled) {
                NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_Cancelled",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
                NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
                stateHandler(LLUserResponseStateCancel,nil,error);
                
            }else{
                
                void (^fbUserCompletion)(id,id ,NSError* ) = ^(id conn,id resultUser,NSError *error){
                    if (error) {
                        stateHandler(LLUserResponseStateFail,nil,error);
                    }else{
                        NSLog(@"resultUser:%@",resultUser);
                        NSString *userId = @"";
                        NSString *name = @"";
                        NSString *logo = @"";
                        if ([resultUser valueForKey:@"id"]) {
                            userId = [resultUser valueForKey:@"id"];
                        }
                        if ([resultUser valueForKey:@"name"]) {
                            name = [resultUser valueForKey:@"name"];
                        }
                        id prefile = [NSClassFromString(@"FBSDKProfile")performSelector:@selector(currentProfile)];
                        if ([prefile valueForKey:@"linkURL"]) {
                            logo = [prefile valueForKey:@"linkURL"];
                        }
                        LLSSUserInfo *user = [[LLSSUserInfo alloc]init];
                        user.avatar = logo;
                        user.nickname = name;
                        user.userId = userId;
                        user.type = LLUserSdkPlatformTypeFacebook;
                        stateHandler(LLUserResponseStateSuccess,user,nil);
                    }
                };
                [[[NSClassFromString(@"FBSDKGraphRequest")alloc]performSelector:@selector(initWithGraphPath:parameters:) withObject:@"me" withObject:nil] performSelector:@selector(startWithCompletionHandler:) withObject:fbUserCompletion];
            }
            
        };
        
        NSArray *parameter = @[@"public_profile",@"email",@"user_about_me"];
        
        SEL selector = @selector(logInWithReadPermissions:fromViewController:handler:);
        
        NSMethodSignature *signature = [fbManager methodSignatureForSelector:selector];
        //1、创建NSInvocation对象
        NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = fbManager;
        //invocation中的方法必须和签名中的方法一致。
        invocation.selector = selector;
        [invocation setArgument:&parameter atIndex:2];
        [invocation setArgument:&controller atIndex:3];
        [invocation setArgument:&fbLogInWithCompletion atIndex:4];
        [invocation invoke];
        
    }
    if (type == LLUserSdkPlatformTypeTwitter) {
        
        if (NSClassFromString(@"Twitter")) {
            id twObj = [NSClassFromString(@"Twitter") performSelector:@selector (sharedInstance)];
            
            void (^logInWithCompletion)(id ,NSError* ) = ^(id session,NSError *error){
                
                if (!error) {
                    NSString *userId = [session valueForKey:@"userID"];
                    
                    NSString *name = [session valueForKey:@"userName"];
                    
                    id client = [NSClassFromString(@"TWTRAPIClient") performSelector:@selector(clientWithCurrentUser)];
                    
                    void (^getUserCompletion)(id ,NSError* ) = ^(id user,NSError *error){
                        
                        if (!error) {
                            NSString *uid = [user valueForKey:@"userID"];
                            NSString *screenName = [user valueForKey:@"screenName"];
                            NSString *logo = [user valueForKey:@"profileImageURL"];
                            LLSSUserInfo *user = [[LLSSUserInfo alloc]init];
                            user.avatar = logo;
                            user.nickname = screenName;
                            user.userId = uid;
                            user.type = LLUserSdkPlatformTypeTwitter;
                            stateHandler(LLUserResponseStateSuccess,user,nil);
                        }else{
                            
                            stateHandler(LLUserResponseStateFail,nil,error);
                        }
                        
                    };
                    
                    [client performSelector:@selector(loadUserWithID:completion:) withObject:userId withObject:getUserCompletion];
                    
                }else{
                    
                    stateHandler(LLUserResponseStateFail,nil,error);
                }
                
            };
            
            [twObj performSelector:@selector(logInWithCompletion:) withObject:logInWithCompletion];
           
        }
        
        
    }
    
}

#pragma mark    微博代理
-(void)didReceiveWeiboRequest:(id)request{
    NSLog(@"request:%@",request);
}

-(void)didReceiveWeiboResponse:(id)response{
    NSLog(@"response:%@",response);
    
    if ([response isKindOfClass:[NSClassFromString(@"WBAuthorizeResponse") class]])
    {
        
        NSLog(@"response%@",[response  valueForKey:@"userInfo"]) ;
        
        int statusCode = [[response valueForKey:@"statusCode"] intValue];
        if (statusCode == 0) {
            if ([response  valueForKey:@"userInfo"]) {
                NSDictionary *userinfo = [response valueForKey:@"userInfo"];
                NSString *userId;
                if (userinfo[@"uid"]) {
                    userId = userinfo[@"uid"];
                }
                NSString *logo;
                NSString *name;
                if (userinfo[@"app"]) {
                    if (userinfo[@"app"][@"logo"]) {
                        logo = userinfo[@"app"][@"logo"];
                    }
                    if (userinfo[@"app"][@"name"]) {
                        name = userinfo[@"app"][@"name"];
                    }
                }
                LLSSUserInfo *user = [[LLSSUserInfo alloc]init];
                user.avatar = logo;
                user.nickname = name;
                user.userId = userId;
                user.type = LLUserSdkPlatformTypeSinaWeibo;
                stateHandler(LLUserResponseStateSuccess,user,nil);
            }

        }else if(statusCode == -1){
            NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_Cancelled",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
            NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
            stateHandler(LLUserResponseStateCancel,nil,error);
        }else{
            NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_denied",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
            NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
            stateHandler(LLUserResponseStateFail,nil,error);
        }
        
    }
    
}
#pragma mark    qq的代理
-(void)tencentDidNotNetWork{
    
    NSLog(@"tencentDidNotNetWork:%@",tencentOAuth);
    
}

-(void)tencentDidNotLogin:(BOOL)cancelled{
    
//    NSLog(@"tencentDidNotLogin:%@",tencentOAuth);
    NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_Cancelled",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
    NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
    stateHandler(LLUserResponseStateCancel,nil,error);
    
}

-(void)tencentDidLogin{
//    NSLog(@"tencentDidLogin:%@",tencentOAuth);
    NSString *token;
    NSString *openid;
    NSString *appid;
    if ([tencentOAuth valueForKey:@"accessToken"]) {
        token = [tencentOAuth valueForKey:@"accessToken"];
    }
    if ([tencentOAuth valueForKey:@"openId"]) {
        openid = [tencentOAuth valueForKey:@"openId"];
    }
    if ([tencentOAuth valueForKey:@"appId"]) {
        appid = [tencentOAuth valueForKey:@"appId"];
    }
    
    [LLUserApiManager getQQUserInfoWithToken:token appid:appid openid:openid success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"qqinfo:%@",responseObject);
        
        LLSSUserInfo *user = [[LLSSUserInfo alloc]init];
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        if (dic[@"nickname"]) {
            user.nickname = dic[@"nickname"];
        }
        
        user.type = LLUserSdkPlatformTypeQQ;
        
        user.userId = [NSString stringWithFormat:@"%@-%@",appid,openid];
        
        if (dic[@"figureurl_qq_2"]) {
            user.avatar = dic[@"figureurl_qq_2"];
        }
        
        stateHandler(LLUserResponseStateSuccess,user,nil);
        
    } failure:^(NSError *error) {
        stateHandler(LLUserResponseStateFail,nil,error);
    }];
    
//    [NSClassFromString(@"WBAuthorizeResponse") performSelector:@selector (sharedInstance)];
}



#pragma mark    微信结果回调代理
-(void) onReq:(id )req{
    NSLog(@"req:%@",req);
    
}

-(void) onResp:(id )resp{
    NSLog(@"resp:%@",resp);
    
    if ([resp isKindOfClass:[NSClassFromString(@"SendAuthResp") class]])
    {
        int errorCode = [[resp valueForKey:@"errCode"] intValue];
        if (errorCode == 0) {
            NSLog(@"response%@",[resp  valueForKey:@"code"]) ;
            NSString *code = [resp  valueForKey:@"code"];
            
            [LLUserApiManager getWXAccessTokenWithappkey:accout.weiXinAccountInfo[@"appId"] appsecret:accout.weiXinAccountInfo[@"appSecret"] Code:code success:^(NSURLSessionDataTask *task, id responseObject) {
                //            NSLog(@"responseObject:%@",responseObject);
                
                if (!responseObject[@"errcode"]) {
                    [LLUserApiManager getWXUserinfoWithToken:responseObject[@"access_token"] openid:responseObject[@"openid"] success:^(NSURLSessionDataTask *task, id response) {
                        NSLog(@"responseObject:%@",response);
                        if (!responseObject[@"errcode"]) {
                            LLSSUserInfo *user = [[LLSSUserInfo alloc]init];
                            NSDictionary *dic = (NSDictionary *)response;
                            
                            if (dic[@"nickname"]) {
                                user.nickname = dic[@"nickname"];
                            }
                            
                            user.type = LLUserSdkPlatformTypeTencentWeiXin;
                            if (dic[@"unionid"]) {
                                user.userId = dic[@"unionid"];
                            }
                            
                            
                            if (dic[@"headimgurl"]) {
                                user.avatar = dic[@"headimgurl"];
                            }
                            
                            stateHandler(LLUserResponseStateSuccess,user,nil);
                        }else{
                            NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:responseObject[@"errcode"], @"message",nil];
                            NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:809 userInfo:userinfo];
                            stateHandler(LLUserResponseStateFail,nil,error);
                        }
                        
                    } failure:^(NSError *error) {
                        
                        stateHandler(LLUserResponseStateFail,nil,error);
                    }];
                }else{
                    NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:responseObject[@"errcode"], @"message",nil];
                    NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:809 userInfo:userinfo];
                    stateHandler(LLUserResponseStateFail,nil,error);
                }
                
            } failure:^(NSError *error) {
                stateHandler(LLUserResponseStateFail,nil,error);
            }];
        }else if(errorCode == -2){
            NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_Cancelled",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
            NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
            stateHandler(LLUserResponseStateFail,nil,error);
        }else{
            NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedStringFromTableInBundle(@"User_denied",@"LLUser", [LLUserLocalizable localizableBundle] ,nil), @"message",nil];
            NSError * error = [NSError errorWithDomain:NSURLErrorDomain code:805 userInfo:userinfo];
            stateHandler(LLUserResponseStateFail,nil,error);
        }
        
    }
    
}

+ (void)logoutType:(LLUserSdkPlatformType)type{
    if (type == LLUserSdkPlatformTypeSinaWeibo) {
        //+ (void)logOutWithToken:(NSString *)token delegate:(id<WBHttpRequestDelegate>)delegate withTag:(NSString*)tag
        
        
    }
    if(type == LLUserSdkPlatformTypeQQ){
        //- (void)logout:(id<TencentSessionDelegate>)delegate;
        
        [tencentOAuth performSelector:@selector(logout:) withObject:self];
    }
    if(type == LLUserSdkPlatformTypeTencentWeiXin){
        
    }
    if(type == LLUserSdkPlatformTypeTwitter){
        
    }
    if(type == LLUserSdkPlatformTypeFacebook){
        //FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        //- (void)logOut;
        if (NSClassFromString(@"FBSDKLoginManager")) {
            id fbManager = [[NSClassFromString(@"FBSDKLoginManager")alloc]init];
            [fbManager performSelector:@selector(logOut)];
        }
    }
}

- (void)tencentDidLogout{
    
}

@end
