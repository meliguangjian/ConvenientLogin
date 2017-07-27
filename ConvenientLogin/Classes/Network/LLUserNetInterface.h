//
//  LLUserNetInterface.h
//  LLUserSDK
//
//  Created by liguangjian on 17/2/24.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#ifndef LLUserNetInterface_h
#define LLUserNetInterface_h

#import "LLUserConstant.h"

#define LLUser_GetCode [NSString stringWithFormat:@"%@/sms-codes?access_token=",kLLUSER_API_BASE_URL]

#define LLUser_GetCodeEmail [NSString stringWithFormat:@"%@/email-codes?access_token=",kLLUSER_API_BASE_URL]

#define LLUser_UserLogin [NSString stringWithFormat:@"%@/tokens",kLLUSER_API_BASE_URL]

//用户中心接口授权
#define LLUser_GetUserAPIOauth [NSString stringWithFormat:@"%@/tokens",kLLUSER_API_BASE_URL]

#define LLUser_Users [NSString stringWithFormat:@"%@/users",kLLUSER_API_BASE_URL]

//用户注册
#define LLUser_UserRegister [NSString stringWithFormat:@"%@/users?access_token=",kLLUSER_API_BASE_URL]

//修改密码
#define LLUser_UserResetPass [NSString stringWithFormat:@"%@/users/password?access_token=",kLLUSER_API_BASE_URL]

//重置密码
#define LLUser_UserRepass [NSString stringWithFormat:@"%@/users/password?access_token=",kLLUSER_API_BASE_URL]

#define LLUser_QrcodeScan [NSString stringWithFormat:@"%@/qrcode-tokens/",kLLUSER_API_BASE_URL]

#define LLUser_CheckClient [NSString stringWithFormat:@"%@/oauth-clients/",kLLUSER_API_BASE_URL]

#define LLUser_UpdateAvatar [NSString stringWithFormat:@"%@/users/avatar",kLLUSER_API_BASE_URL]

#define LLUser_CreateUserName [NSString stringWithFormat:@"%@/users/username",kLLUSER_API_BASE_URL]

#define LLUser_UpdatePhone [NSString stringWithFormat:@"%@/users/phone",kLLUSER_API_BASE_URL]

#define LLUser_OauthClientsToken [NSString stringWithFormat:@"%@/oauth-clients/token",kLLUSER_API_BASE_URL]

#define LLUser_Oauths_Token [NSString stringWithFormat:@"%@/user-auths/token",kLLUSER_API_BASE_URL]


#define LLUser_UpdateEmail [NSString stringWithFormat:@"%@/users/email",kLLUSER_API_BASE_URL]

//新蛋账号登录
#define LLUser_NewEggsToken [NSString stringWithFormat:@"%@/new-eggs/token",kLLUSER_API_BASE_URL]

//新蛋账号同步登录 new-eggs/sync
#define LLUser_NewEggsSyncn [NSString stringWithFormat:@"%@/new-eggs/sync",kLLUSER_API_BASE_URL]

//授权登录新蛋记录 new-egg-oauths
#define LLUser_NewEggsOauths [NSString stringWithFormat:@"%@/new-egg-oauths",kLLUSER_API_BASE_URL]


#endif /* LLUserNetInterface_h */
