//
//  Validate.m
//  BusApp
//
//  Created by jiaojiao on 7/10/14.
//  Copyright (c) 2014 qianxingwuyou. All rights reserved.
//

#import "LLUserValidate.h"

@implementation LLUserValidate

// 邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 手机号码验证
+ (BOOL)validateMobile:(NSString *)str
{
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSString *regex = @"^1+[34578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:str];
}

// 用户名
+ (BOOL)validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[a-zA-Z0-9_]{6,19}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}

// 必须为数组和字母组合6-20位密码
+ (BOOL)validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    if ([passWordPredicate evaluateWithObject:passWord]) {
        NSString *number = @"^[0-9]+$";
        NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
        if ([numberPre evaluateWithObject:passWord]) {
            return NO;
        }
        NSString *enber = @"^[a-zA-Z]+$";
        NSPredicate *enPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",enber];
        if ([enPre evaluateWithObject:passWord]) {
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
    
}

// 昵称
+ (BOOL)validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]{1,19}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

// 验证体重
+ (BOOL)validateWeight:(NSString *)weight
{
    NSString *weight_ = @"^\\d+(\\d|(\\.[1-9]{1,2}))$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",weight_];
    return [passWordPredicate evaluateWithObject:weight];
}

// 真实姓名
+ (BOOL)validateRealName:(NSString *)name
{
    NSString *realNameRegex = @"^[\u4E00-\u9FA5]{2,10}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realNameRegex];
    
    return [passWordPredicate evaluateWithObject:name];
}

// 邀请码
+ (BOOL)validateInviteCode:(NSString *)inviteCode
{
    return YES;
}

// 验证码
+ (BOOL)validateValidateCode:(NSString *)ValidateCode
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{2,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:ValidateCode];
}

// 商品名
+ (BOOL)validateNickGoodsName:(NSString *)goodsName
{
    NSString *goodsNameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9]{2,10}+$";
    NSPredicate *goodsNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",goodsNameRegex];
    
    return [goodsNamePredicate evaluateWithObject:goodsName];
}

// 商品介绍
+ (BOOL)validateGoodsInfo:(NSString *)goodsInfo
{
    NSString *goodsInfoRegex = @"^[\u4E00-\u9FA5A-Za-z0-9]{2,10}+$";
    NSPredicate *goodsInfoPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",goodsInfoRegex];
    
    return [goodsInfoPredicate evaluateWithObject:goodsInfo];
}

// 纯数字
+ (BOOL)validateNumber:(NSString *)textString
{
    NSString *number = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

// 用英文
+ (BOOL)validateEnglish:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:name];
}

/// 座机号码
+ (BOOL)validatePhoneNumber:(NSString *)string
{
    NSString *number = @"^(\\d{3,4}-)\\d{7,8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:string];
}

/// 整数或小数
+ (BOOL)validateIntOrDouble:(NSString *)string
{
    NSString *number = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:string];
}

/// 血型
+ (BOOL)validateBloodType:(NSString *)type
{
    if ([type isEqualToString:@"A"] || [type isEqualToString:@"B"] || [type isEqualToString:@"AB"] || [type isEqualToString:@"O"]) {
        return YES;
    } else {
        return NO;
    }
}

// 验证是否填写
+ (BOOL)validateInfoWrite:(NSString *)string
{
    if ([[string stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
        return NO;
    }
    return YES;
}

// 设备验证码
+ (BOOL)validateValidateDeviceCode:(NSString *)ValidateCode
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:ValidateCode];
}

// 设备ID
+ (BOOL)validateDeviceID:(NSString *)textString
{
    NSString *number = @"^[0-9]{9}+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

//验证输入手机号
+ (BOOL)textField:(NSString *)text shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    NSLog(@"location :%lu  ===========  %lu ======= %@     ===========    %@",(unsigned long)range.location,range.length,string,text);
    
    if (![LLUserValidate validateNumber:string] && ![string isEqualToString:@""]) {
        return NO;
    }
    if (text.length >10 && ![string isEqualToString:@""]) {
        return NO;
    }
    if ( text.length == 0 && ![string isEqualToString:@"1"] ) {
        // 只允许第一位为1
        return NO;
        
    }
//    if ( text.length == 1 && ![string isEqualToString:@"1"] ) {
//        // 只允许第一位为1
//        return NO;
//        
//    }
//    NSLog(@"aaaaa");
    return YES;
}

@end
