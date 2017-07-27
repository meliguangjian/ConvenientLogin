//
//  LLSSUserInfo.h
//  UserCenterDemo
//
//  Created by liguangjian on 2017/7/18.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLUserConstant.h"

@interface LLSSUserInfo : NSObject

@property(nonatomic,assign)LLUserSdkPlatformType type;      //平台类型

@property(nonatomic,strong)NSString *userId;      //唯一id

@property(nonatomic,strong)NSString *nickname;      //昵称

@property(nonatomic,strong)NSString *avatar;      //头像



@end
