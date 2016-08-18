//
//  HTTPRequester.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/9.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "HTTPRequester.h"

@implementation HTTPRequester

#pragma mark - Private Class Method
+ (NSString *)urlWithApi:(NSString *)api {
    return [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api%@", api];
}

+ (void)getWithURI:(NSString *)api success:(SuccessBlock)successBlock faile:(FailBlock)failBlock{
    NSString *urlString;
    NSURL *url;
    NSURLRequest *request;
    NSURLSession *session;
    NSURLSessionTask *sessionTask;
//    __block NSError *err;
    urlString = [self urlWithApi:api];
    NSLog(@"url:%@", urlString);
    url = [NSURL URLWithString:urlString];
    request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    session = [NSURLSession sharedSession];
    sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error:%@", error.localizedDescription);
            failBlock(error);
        } else if (successBlock) {
            successBlock(data);
        }
    }];
    [sessionTask resume];
}

- (void)postWithApi:(NSString *)api {
    
}

#pragma mark -Home Page
+ (void)requestHomeMoreWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [self getWithURI:@"/hp/more/0" success:successBlock faile:failBlock];
    
}

#pragma mark - Movie List

+ (void)requestMovieListWithOffset:(NSUInteger)offset success:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [self getWithURI:[NSString stringWithFormat:@"/movie/list/%li", offset] success:successBlock faile:failBlock];
}

#pragma mark - Read

+ (void)requestReadCarouselListWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [self getWithURI:@"/reading/carousel" success:successBlock faile:failBlock];
}

+ (void)requestReadIndexWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    [self getWithURI:@"/reading/index" success:successBlock faile:failBlock];
}

@end
