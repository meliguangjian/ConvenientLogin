//
//  AccountManger.h
//  ThirdPartyLoginDemo
//
//  Created by liguangjian on 2017/7/18.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "LLUserConstant.h"
#import "LLSSUserInfo.h"

typedef NS_ENUM(NSUInteger, LLUserResponseState){
    
    /**
     *  成功
     */
    LLUserResponseStateSuccess    = 0,
    
    /**
     *  失败
     */
    LLUserResponseStateFail       = 1,
    
    /**
     *  取消
     */
    LLUserResponseStateCancel     = 2,
    
};

typedef void(^LLUserAuthorizeStateChangedHandler) (LLUserResponseState state, LLSSUserInfo *user, NSError *error);

@interface LLUserThirdPartyAccount : NSObject


//Singleton Design pattern
+ (id)sharedInstance;

@property(nonatomic,strong)NSMutableDictionary *qqAccountInfo;

@property(nonatomic,strong)NSMutableDictionary *weiboAccountInfo;

@property(nonatomic,strong)NSMutableDictionary *weiXinAccountInfo;

@property(nonatomic,strong)NSMutableDictionary *twitterAccountInfo;

@property(nonatomic,strong)NSMutableDictionary *facebookAccountInfo;

-(void)createQQOauth;


+ (void)authorize:(LLUserSdkPlatformType)type
currentViewController:(UIViewController *)controller
   onStateChanged:(LLUserAuthorizeStateChangedHandler)stateChangedHandler;

+ (void)logoutType:(LLUserSdkPlatformType)type;

@end
