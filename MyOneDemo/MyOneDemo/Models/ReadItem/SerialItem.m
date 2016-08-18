//
//  SerialItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "SerialItem.h"
#import "AuthorItem.h"

@implementation SerialItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.authorItem = [AuthorItem authorItemWithDict:dict[@"author"]];
        self.excerpt = dict[@"excerpt"];
        self.hasAudio = [dict[@"has_audio"] integerValue];
        self.Id = [dict[@"id"] integerValue];
        self.makeTime = dict[@"maketime"];
        self.number = [dict[@"number"] integerValue];
        self.readNum = dict[@"read_num"];
        self.serialId = [dict[@"serial_id"] integerValue];
        self.title = dict[@"title"];
    }
    
    return self;
}

+ (instancetype)serialItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
