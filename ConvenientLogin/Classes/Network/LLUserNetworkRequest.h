//
//  LLUserNetworkRequest.h
//  UserCenterDemo
//
//  Created by liguangjian on 17/4/10.
//  Copyright © 2017年 liguangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLUserNetworkRequestSerializer.h"

@interface LLUserNetworkRequest : NSObject

//@property (readonly, nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSURLSession *session;

/**
 *  request对象
 */
@property (nonatomic, strong) LLUserNetworkRequestSerializer * requestSerializer;

/**
 *  发送GET请求
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  发送POST请求
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  发送DELETE请求
 */
- (void)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  发送PATCH请求
 */
- (void)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;


/**
 *  发送PUT请求
 */
- (void)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

@end
