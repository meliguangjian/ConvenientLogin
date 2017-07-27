//
//  LLUserConstant.h
//  LLUserCenterSDK
//
//  Created by liguangjian on 17/2/27.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#ifndef LLUserConstant_h
#define LLUserConstant_h

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DEFAULTS [NSUserDefaults standardUserDefaults]

#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height

#define IS_iPhone4 (SCREEN_Height == 480)
#define IS_iPhone5 (SCREEN_Height == 568)
#define IS_iPhone6 (SCREEN_Height == 667)
#define IS_iPhone6p (SCREEN_Height == 736)


/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, LLUserSdkPlatformType){
    /**
     *  新浪微博
     */
    LLUserSdkPlatformTypeSinaWeibo           = 0,
    /**
     *  微信
     */
    LLUserSdkPlatformTypeTencentWeiXin        = 1,
    /**
     *  QQ平台
     */
    LLUserSdkPlatformTypeQQ                  = 2,
    /**
     *  Facebook
     */
    LLUserSdkPlatformTypeFacebook            = 3,
    /**
     *  Twitter
     */
    LLUserSdkPlatformTypeTwitter            = 4
};

#endif /* LLUserConstant_h */
