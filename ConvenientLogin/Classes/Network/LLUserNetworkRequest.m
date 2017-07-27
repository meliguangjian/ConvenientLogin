//
//  LLUserNetworkRequest.m
//  UserCenterDemo
//
//  Created by liguangjian on 17/4/10.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import "LLUserNetworkRequest.h"

@interface LLUserNetworkRequest (){
    int num;
}


@end

@implementation LLUserNetworkRequest

//- (instancetype)init
//{
//    if (self = [super init]) {
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        self.session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
//        self.requestSerializer = [LLUserNetworkRequestSerializer serializer];
//        
//        NSArray *languages = [NSLocale preferredLanguages];
//        NSString *currentLanguage = [languages objectAtIndex:0];
//        NSLog( @"currentLanguage：%@" , currentLanguage);
//        NSString *language;
//        if ([currentLanguage rangeOfString:@"zh-Hant"].location != NSNotFound)
//        {   //繁体中文
//            language = @"zh-TW";
//        }else if([currentLanguage rangeOfString:@"zh-Hans"].location != NSNotFound)
//        {   //简体中文
//            language = @"zh-CN";
//        }else{
//            language = @"en-US";
//        }
//        
//        [self.requestSerializer setValue:language forHTTPHeaderField:@"Accept-Language"];
//        
//    }
//    return self;
//}

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
}

- (void)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"DELETE" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    
}

- (void)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PATCH" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
}

- (void)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PUT" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask resume];
    
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
            failure(nil, serializationError);
        }
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(dataTask, error);
                });
            }
        } else {
            if (success) {
                
                NSHTTPURLResponse * responses = (NSHTTPURLResponse *)dataTask.response;
                
                if (responses.statusCode >= 400) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (!error) {
                            id responseObject = nil;
                            if (data) {
                                responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                
                            }
                            NSError *error ;
                            //                            NSDictionary *errorDictionary = nil;
                            if ([responseObject isKindOfClass:[NSArray class]]) {
                                error = [NSError errorWithDomain:NSURLErrorDomain code:responses.statusCode userInfo:responseObject[0]];
                            }else{
                                error = [NSError errorWithDomain:NSURLErrorDomain code:responses.statusCode userInfo:responseObject];
                            }
                            
                            failure(dataTask, error);
                        }else{
                            failure(dataTask, error);
                        }
                        
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSDictionary *responseObject = nil;
                        if (data) {
                            responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        }
                        //回调或者说是通知主线程刷新，
                        success(dataTask, responseObject);
                    });
                }
                
            }
        }
    }];
    
    return dataTask;
}

@end
