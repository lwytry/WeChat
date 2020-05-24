//
//  Api.m
//  WeChatCP
//
//  Created by lwy on 2020/5/23.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ApiHelper.h"
#import <AFNetworking.h>
#import "ApiMacro.h"

@implementation ApiHelper

+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString parameters:(id)parameters useToken:(BOOL)token success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (token) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *token = [userDefault objectForKey:@"token"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return [manager POST:urlString parameters:parameters progress:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)getUrl:(NSString *)urlString parameters:(id)parameters useToken:(BOOL)token success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (token) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *token = [userDefault objectForKey:@"token"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return [manager GET:urlString parameters:parameters progress:nil success:success failure:failure];
}

@end
