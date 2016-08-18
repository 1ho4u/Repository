//
//  AuthorItem.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorItem : NSObject

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *wbName;
@property (nonatomic, copy) NSString *webURL;

+ (instancetype)authorItemWithDict:(NSDictionary *)dict;

@end
