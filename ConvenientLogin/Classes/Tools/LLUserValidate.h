//
//  Validate.h
//  BusApp
//
//  Created by jiaojiao on 7/10/14.
//  Copyright (c) 2014 qianxingwuyou. All rights reserved.
//
//  description 验正工具类
//

#import <Foundation/Foundation.h>

@interface LLUserValidate : NSObject

// 邮箱
+ (BOOL) validateEmail:(NSString *)email;

// 手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

// 用户名
+ (BOOL) validateUserName:(NSString *)name;

// 密码
+ (BOOL) validatePassword:(NSString *)passWord;

// 昵称
+ (BOOL)validateNickname:(NSString *)nickname;

// 验证体重
+ (BOOL)validateWeight:(NSString *)weight;

// 真实姓名
+ (BOOL)validateRealName:(NSString *)name;

// 邀请码
+ (BOOL)validateInviteCode:(NSString *)inviteCode;

// 验证码
+ (BOOL)validateValidateCode:(NSString *)ValidateCode;

// 商品名
+ (BOOL)validateNickGoodsName:(NSString *)nickname;

// 商品介绍
+ (BOOL)validateGoodsInfo:(NSString *)nickname;

/// 纯数字
+ (BOOL)validateNumber:(NSString *)textString;

// 用英文
+ (BOOL)validateEnglish:(NSString *)name;

/// 座机号码
+ (BOOL)validatePhoneNumber:(NSString *)string;

/// 整数或小数
+ (BOOL)validateIntOrDouble:(NSString *)string;

/// 血型
+ (BOOL)validateBloodType:(NSString *)type;

// 验证是否填写
+ (BOOL)validateInfoWrite:(NSString *)string;

// 设备验证码
+ (BOOL)validateValidateDeviceCode:(NSString *)ValidateCode;

// 设备ID
+ (BOOL)validateDeviceID:(NSString *)textString;

+ (BOOL)textField:(NSString *)text shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
