//
//  NetworkRequest.h
//  MQTTKit
//
//  Created by 黄强强 on 16/9/19.
//  Copyright © 2016年 Jeff Mesnil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLUserNetworkRequest.h"

typedef void(^ServerHandleFailBlock) (NSError *error);
typedef void(^SuccessBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask *operation, NSError *error,int code);

//Request请求类型
typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestPut,
    HttpRequestDelete,
    HttpRequestPATCH
};

@interface LLUserNetworkManager : NSObject{
    BOOL isConnectNetWork;
}

@property (nonatomic,strong)LLUserNetworkRequest *manager;

+ (instancetype)defaultClient;

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                showHud:(BOOL)showHud
                success:(SuccessBlock)success
                failure:(ServerHandleFailBlock)failure;


@end
