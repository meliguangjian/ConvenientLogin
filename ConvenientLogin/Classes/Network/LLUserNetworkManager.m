//
//  NetworkRequest.m
//  MQTTKit
//
//  Created by 黄强强 on 16/9/19.
//  Copyright © 2016年 Jeff Mesnil. All rights reserved.
//

#import "LLUserNetworkManager.h"


#import "LLUserNetInterface.h"
#import "LLUserFormatTime.h"
#import "LLUserHudTool.h"
#import "LLUserLocalizable.h"

#define kBoundary @"----WebKitFormBoundary0IQAt0HA7oxwIx3f"
#define KNewLine [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]

@interface LLUserNetworkManager (){
    int num;
}

@end

@implementation LLUserNetworkManager

+ (instancetype)defaultClient
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        config.timeoutIntervalForRequest = 20;
        
        _manager = [[LLUserNetworkRequest alloc]init];
        
        _manager.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
        _manager.requestSerializer = [LLUserNetworkRequestSerializer serializer];
        
        NSArray *languages = [NSLocale preferredLanguages];
        NSString *currentLanguage = [languages objectAtIndex:0];
        NSLog( @"currentLanguage：%@" , currentLanguage);
        NSString *language;
        if ([currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound)
        {   //繁体中文
            language = @"zh-TW";
        }else if([currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound)
        {   //简体中文
            language = @"zh-CN";
        }else{
            language = @"en-US";
        }
        
        [_manager.requestSerializer setValue:language forHTTPHeaderField:@"Accept-Language"];
    }
    return self;
}

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                showHud:(BOOL)showHud
                success:(SuccessBlock)success
                failure:(ServerHandleFailBlock)failure{
    
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    if (showHud) {
        [[LLUserHudTool sharedInstance]showHudWithLoadingText:NSLocalizedStringFromTableInBundle(@"Loading",@"LLUser",[LLUserLocalizable localizableBundle] , nil)];
        num++;
    }
    
    switch (method) {
        case HttpRequestGet:{
            [self openActivity];
            [_manager GET:urlStr parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self closeActivity];
                if (showHud) {
                    num--;
                    if (num == 0) {
                        [[LLUserHudTool sharedInstance]hideHud:YES delay:0.2];
                    }
                }
                success(operation, responseObject);
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self closeActivity];
                [self dealWithHttpError:showHud dataTask:operation error:error failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            
        }
            break;
        case HttpRequestPut:{
            [self openActivity];
            [_manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self closeActivity];
                if (showHud) {
                    num--;
                    if (num == 0) {
                        [[LLUserHudTool sharedInstance]hideHud:YES delay:0.2];
                    }
                }
                success(operation, responseObject);
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self closeActivity];
                [self dealWithHttpError:showHud dataTask:operation error:error failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            
        }
            break;
        case HttpRequestPost:{
            [self openActivity];
            [_manager POST:urlStr parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self closeActivity];
                if (showHud) {
                    num--;
                    if (num == 0) {
                        [[LLUserHudTool sharedInstance]hideHud:YES delay:0.2];
                    }
                }
                success(operation, responseObject);
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self closeActivity];
                [self dealWithHttpError:showHud dataTask:operation error:error failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            
        }
            break;
        case HttpRequestDelete:{
            [self openActivity];
            [_manager DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self closeActivity];
                if (showHud) {
                    num--;
                    if (num == 0) {
                        [[LLUserHudTool sharedInstance]hideHud:YES delay:0.2];
                    }
                }
                success(operation, responseObject);
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self closeActivity];
                [self dealWithHttpError:showHud dataTask:operation error:error failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            
        }
            break;
        case HttpRequestPATCH:{
            [self openActivity];
            [_manager PATCH:urlStr parameters:parameters success:^(NSURLSessionDataTask *operation, id responseObject) {
                [self closeActivity];
                if (showHud) {
                    num--;
                    if (num == 0) {
                        [[LLUserHudTool sharedInstance]hideHud:YES delay:0.2];
                    }
                }
                success(operation, responseObject);
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [self closeActivity];
                [self dealWithHttpError:showHud dataTask:operation error:error failure:^(NSError *error) {
                    failure(error);
                }];
            }];
            
        }
            break;
        default:
            break;
    }
    
}


-(void)dealWithHttpError:(BOOL)showHud dataTask:(NSURLSessionDataTask *)task error:(NSError*)error failure:(ServerHandleFailBlock)failure{
    NSHTTPURLResponse * responses = (NSHTTPURLResponse *)task.response;
    
    NSDictionary *responseObject = nil;
    NSString *hudStr = NSLocalizedStringFromTableInBundle(@"NET_Exception",@"LLUser",[LLUserLocalizable localizableBundle] , nil);
    responseObject = [error userInfo];
    if (responseObject.count>0) {
        hudStr = responseObject[@"message"];
    }
    
//    if (responses.statusCode == 401) {      //如果发现获取授权失败，重新拉取
//        hudStr = NSLocalizedStringFromTableInBundle(@"Try_Again",@"LLUser",[LLUserLocalizable localizableBundle] , nil);
//        //USERAPPKEY appSecret:USERAPPSECRET
//        NSMutableDictionary *parame = [NSMutableDictionary dictionary];
//        [parame setObject:USERAPPKEY forKey:@"client_id"];
//        [parame setObject:USERAPPSECRET forKey:@"client_secret"];
//        [parame setObject:@"client_credentials" forKey:@"grant_type"];
//        
//        [self requestWithPath:GetUserAPIOauth method:HttpRequestPost parameters:parame showHud:NO success:^(NSURLSessionDataTask *operation, id responseObject) {
//            NSLog(@"%@",responseObject);
//            [LLUserApiOauth seveOauthToken:responseObject[@"access_token"]];
//        } failure:^(NSError *error) {
//            
//        }];
//    }
    
    if (showHud) {
        num--;
        if (num == 0) {
            [[LLUserHudTool sharedInstance]showHudOneSecondWithText:hudStr];
        }
    }
    NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:hudStr, @"message", nil];
    NSError *errorMsg = [NSError errorWithDomain:NSURLErrorDomain code:responses.statusCode userInfo:userinfo];
    
    failure(errorMsg);
}

-(NSData *)getBodyData:(NSData *)file
{
    NSString *pictureFormat = [self typeForImageData:file];
    //5.拼接数据
    NSMutableData *fileData = [NSMutableData data];
    
    //5.1 拼接文件参数
    /*
      --分隔符
      Content-Disposition: form-data; name="file"; filename="Snip20151228_572.png"
      Content-Type: image/png
      空行
      文件二进制数据
     */
    [fileData appendData:[[NSString stringWithFormat:@"--%@",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    // name="file":参数,是固定的
    // filename:文件上传到服务器以什么名字来保存,随便
    NSString *dispoition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"avatarFile\"; filename=\"avatarFile.%@\"",pictureFormat];
    [fileData appendData:[dispoition dataUsingEncoding:NSUTF8StringEncoding]];
    
    [fileData appendData:KNewLine];
    //Content-Type:要上传的文件的类型 (MIMEType)
    NSString *contentType = [NSString stringWithFormat:@"Content-Type: image/%@",pictureFormat];
    
    [fileData appendData: [contentType dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];
    
    [fileData appendData:file];
    [fileData appendData:KNewLine];
    
    //5.2 拼接非文件参数
    /*
        --分隔符
        Content-Disposition: form-data; name="username"
        空行
        非文件参数的二进制数据
    */
    [fileData appendData:[[NSString stringWithFormat:@"--%@",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    
    //username:同file 是服务器规定
    [fileData appendData:[@"Content-Disposition: form-data; name=\"avatarFile\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    [fileData appendData:KNewLine];
    [fileData appendData:[@"dashen9" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:KNewLine];
    
    //5.3 拼接结尾标识
    /*--分隔符--*/
    [fileData appendData:[[NSString stringWithFormat:@"--%@--",kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return fileData;
}

-(NSString *)typeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D: ;
            
    }
    
    return nil;
    
}

-(NSString *)strUTF8Encoding:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
}

// 开启状态栏菊花
- (void)openActivity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

// 关闭状态栏菊花
- (void)closeActivity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


@end




