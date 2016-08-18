//
//  AuthorItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "AuthorItem.h"

@implementation AuthorItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.desc = dict[@"dict"];
        self.userId = dict[@"user_id"];
        self.userName = dict[@"user_name"];
        if (dict[@"wb_name"]) {
            self.wbName = dict[@"wb_name"];
        }else {
            self.wbName = @"";
        }
        self.webURL = dict[@"web_url"];
    }
    return self;
}

+ (instancetype)authorItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
