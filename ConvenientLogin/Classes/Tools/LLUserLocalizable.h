//
//  LLUserLocalizable.h
//  UserCenterDemo
//
//  Created by liguangjian on 17/3/14.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LLUserLocalizable(key) [[LLUserLocalizable bundle] localizedStringForKey:(key) value:@"" table:nil]

@interface LLUserLocalizable : NSObject

+(NSBundle *)bundle;

+(NSBundle *)localizableBundle;

+(NSString *)imageUrl:(NSString *)name;

@end
