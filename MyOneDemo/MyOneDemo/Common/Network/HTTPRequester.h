//
//  HTTPRequester.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/9.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseData);
typedef void(^FailBlock)(NSError *error);

@interface HTTPRequester : NSObject

#pragma mark - get api string

#pragma mark - Home
+ (void)requestHomeMoreWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma makr - Read
+ (void)requestReadCarouselListWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
+ (void)requestReadIndexWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

#pragma makr - Movie
+ (void)requestMovieListWithOffset:(NSUInteger)offset success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end
