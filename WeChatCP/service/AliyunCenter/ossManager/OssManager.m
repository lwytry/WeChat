//
//  OssManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/30.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "OssManager.h"
#import "AliyunMacro.h"
#import "ApiHelper.h"
#import "NSFileManager+Chat.h"

@interface OssManager()

@property (nonatomic, strong) OSSClient *client;

@property (nonatomic, strong) NSString *accessKey;

@property (nonatomic, strong) NSString *secret;

@property (nonatomic, strong) NSString *endpoint;

@property (nonatomic, strong) NSString *bucket;

@end

@implementation OssManager

+ (OssManager *)sharedOssManager
{
    static OssManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[OssManager alloc] init];
    });
    return manager;
}

- (id)init
{
    if (self = [super init]) {
        self.endpoint = Aliyun_OSS_ENDPOINT;
        self.accessKey = Aliyun_OSS_ACCESSKEY;
        self.secret = Aliyun_OSS_SECRET;
        self.bucket = Aliyun_OSS_BUCKET;
    }
    return self;
}


#pragma mark - Getter

- (OSSClient *)client{
    if (_client == nil) {
        id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
            NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:self.secret];
            if (signature != nil) {
                *error = nil;
            } else {
                *error = [NSError errorWithDomain:@"OSSClientSignFailed" code:OSSClientErrorCodeSignFailed userInfo:nil];
                return nil;
            }
            return [NSString stringWithFormat:@"OSS %@:%@", self.accessKey, signature];
       }];
                                                                                                                
        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3; // 网络请求遇到异常失败后的重试次数
        conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
        conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
        _client = [[OSSClient alloc] initWithEndpoint:self.endpoint credentialProvider:credential clientConfiguration:conf];
    }
    
    return _client;
}

- (void)uploadFile:(NSString *)fileName data:(NSData *)data
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    // 配置必填字段，其中bucketName为存储空间名称；objectKey等同于objectName，表示将文件上传到OSS时需要指定包含文件后缀在内的完整路径，例如abc/efg/123.jpg。
    put.bucketName = self.bucket;
    put.objectKey = fileName;
    put.uploadingData = data;
    // 配置可选字段。
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        // 指定当前上传长度、当前已经上传总长度、待上传的总长度。
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * putTask = [self.client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
}

- (NSString *)getChatFileURL:(NSString *)path
{
    NSString *domain = [NSString stringWithFormat:@"https://%@.%@/", Aliyun_OSS_BUCKET, Aliyun_OSS_ENDPOINT];
    return [domain stringByAppendingString:path];
}

@end
