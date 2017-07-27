//
//  LLUserLocalizable.m
//  UserCenterDemo
//
//  Created by liguangjian on 17/3/14.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserLocalizable.h"

@implementation LLUserLocalizable

+(NSBundle *)bundle{
    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"UserCenter" ofType:@"bundle"];
    
    NSBundle *userBundle = [NSBundle bundleWithPath:bundlepath];
    
    return userBundle;
}

+(NSBundle *)localizableBundle{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"currentLanguage：%@" , currentLanguage);
    NSString *language;
    if ([currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound)
    {   //繁体中文
        language = @"zh-Hant";
    }else if([currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound)
    {   //简体中文
        language = @"zh-Hans";
    }else{
        language = @"en";
    }
    
    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"UserCenter" ofType:@"bundle"];
    
    NSBundle *userBundle = [NSBundle bundleWithPath:bundlepath];
    
    NSString *path = [userBundle pathForResource:language ofType:@"lproj"];
    
    
    NSBundle *bundle = [NSBundle bundleWithPath:path];//生成bundle
    
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    
    return bundle;
}

+(NSString *)imageUrl:(NSString *)name{
    NSString *bundlepath = [[NSBundle mainBundle] pathForResource:@"UserCenter" ofType:@"bundle"];
    
    NSString *imageUrlStr;
    
    if (bundlepath) {
        imageUrlStr = [NSString stringWithFormat:@"%@/%@",bundlepath,name];
    }else{
        imageUrlStr = name;
    }
    
    return imageUrlStr;
}

@end
