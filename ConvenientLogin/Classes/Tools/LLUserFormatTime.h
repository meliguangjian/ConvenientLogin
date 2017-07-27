//
//  FormatTime.h
//  ChiHao
//
//  Created by ruiduan ma on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//  description 时间处理类
//

#import <Foundation/Foundation.h>

@interface LLUserFormatTime : NSObject
+(NSString *)getCurrentTime;
+(NSString *)getCurrentFullTime;
+(CFAbsoluteTime)getAbsoluteTime:(NSString *)dateStr;
//+(NSString *)getNSTime:(CFGregorianDate)time;

+(NSDate *)severalDaysLater:(NSDate *)date day:(NSInteger)second;
+(NSDate *)stringToDate:(NSString *)strDate dateFormatter:(NSString *)dateFormatter;
+(int)compareDate:(NSDate*)date01 withDate:(NSDate*)date02;
@end
