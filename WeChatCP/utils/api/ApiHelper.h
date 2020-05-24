//
//  Api.h
//  WeChatCP
//
//  Created by lwy on 2020/5/23.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiMacro.h"

@interface ApiHelper : NSObject


+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString
                       parameters:(id)parameters
                         useToken:(BOOL)token
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (NSURLSessionDataTask *)getUrl:(NSString *)urlString
                       parameters:(id)parameters
                         useToken:(BOOL)token
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end

