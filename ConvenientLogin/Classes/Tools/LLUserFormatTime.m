//
//  FormatTime.m
//  ChiHao
//
//  Created by ruiduan ma on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LLUserFormatTime.h"

@implementation LLUserFormatTime

//格式化当前时间
+(NSString *)getCurrentTime
{
    NSDate *_date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [[format stringFromDate:_date] substringToIndex:14];

    return dateTime;
}

//格式化当前时间 199001101201
+(NSString *)getCurrentFullTime
{
    NSDate *_date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [format stringFromDate:_date];
    
    return dateTime;
}

//当前时间转化为格里高利时间
+(CFAbsoluteTime)getAbsoluteTime:(NSString *)dateStr
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];
    NSDate *oneDay =[date dateFromString:dateStr];
    
    NSDate *xDay = [date dateFromString:@"2001-01-01"];
        
    NSTimeInterval late=[xDay timeIntervalSince1970]*1;
    
    NSTimeInterval now=[oneDay timeIntervalSince1970]*1;

    CFAbsoluteTime cha = now - late;
    return cha;
}

////将格里高利格式化成2010-03-01格式
//+(NSString *)getNSTime:(CFGregorianDate)time
//{
//    NSString *year = [NSString stringWithFormat:@"%d",(int)time.year];
//    NSString *month;
//    NSString *day;
//    if (time.month>9) {
//        month = [NSString stringWithFormat:@"%d",time.month];
//    }
//    else {
//        month = [NSString stringWithFormat:@"0%d",time.month];
//    }
//    
//    if (time.day>9) {
//        day = [NSString stringWithFormat:@"%d",time.day];
//    }
//    else {
//        day = [NSString stringWithFormat:@"0%d",time.day];
//    }
//    
//    return [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
//}
//根据格式对string的时间转换成date
+(NSDate *)stringToDate:(NSString *)strDate dateFormatter:(NSString *)dateFormatter {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:dateFormatter];
    
    NSDate *newDate = [df dateFromString:strDate];
    return newDate;
}

//判断传进来的时间跟second之后的时间进行比较
+(NSDate *)severalDaysLater:(NSDate *)date day:(NSInteger)second {
    NSDate* theDate;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    
    if(second !=0)
    {
//        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [[NSDate alloc]initWithTimeInterval:second sinceDate:date];
    }else{
        theDate = date;
    }
    return theDate;
}

+(int)compareDate:(NSDate*)date01 withDate:(NSDate*)date02{
    int ci;

//    int cha;
//    cha = [date02 timeIntervalSince1970] -  [date01 timeIntervalSince1970];
//    if (cha>0) {
//        ci=1;
//    }else if(cha == 0){
//        ci=0;
//    }else{
//        ci=-1;
//    }
   
    NSComparisonResult result = [date01 compare:date02];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", date01, date02); break;
    }
    return ci;
}

@end
