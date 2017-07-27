//
//  LLUserNetworkRequestSerializer.h
//  MQTTKit
//
//  Created by 黄强强 on 16/9/29.
//  Copyright © 2016年 Jeff Mesnil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ParameterRequestMode){
    parameterRequestModeHTTPRequest,
    parameterRequestModeJSONRequest,
};

@interface LLUserNetworkRequestSerializer : NSObject

+ (instancetype _Nullable )serializer;

/**
 HTTP methods for which serialized requests will encode parameters as a query string. `GET`, `HEAD`, and `DELETE` by default.
 */
@property (nonatomic, strong) NSSet <NSString *> * _Nullable HTTPMethodsEncodingParametersInURI;

@property (readonly, nonatomic, strong) NSDictionary <NSString *, NSString *> * _Nullable HTTPRequestHeaders;

/**
 *  设置方式
 */
@property (nonatomic,assign)ParameterRequestMode requestMode;

/**
 *  设置请求头
 */
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *_Nullable)field;
- (nullable NSString *)valueForHTTPHeaderField:(NSString *_Nullable)field;
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *_Nullable)username password:(NSString *_Nullable)password;
- (void)clearAuthorizationHeader;

/**
 *  <#Description#>
 *
 *  @param method     <#method description#>
 *  @param URLString  <#URLString description#>
 *  @param parameters <#parameters description#>
 *  @param error      <#error description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableURLRequest *_Nullable)requestWithMethod:(NSString *_Nullable)method URLString:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters error:(NSError * _Nullable __autoreleasing *_Nullable)error;


/**
 *  <#Description#>
 *
 *  @param request    <#request description#>
 *  @param parameters <#parameters description#>
 *  @param error      <#error description#>
 *
 *  @return <#return value description#>
 */
- (NSURLRequest *_Nullable)requestBySerializingRequest:(NSURLRequest *_Nullable)request withParameters:(id _Nullable )parameters error:(NSError * _Nullable __autoreleasing *_Nullable)error;

@end
