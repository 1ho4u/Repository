//
//  ReadCarouselItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "ReadCarouselItem.h"

@implementation ReadCarouselItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.bgColor = dict[@"bgcolor"];
        self.bottomText = dict[@"bottom_text"];
        self.cover = dict[@"cover"];
        self.Id = [dict[@"id"] integerValue];
        self.pvURL = dict[@"pv_url"];
        self.title = dict[@"title"];
    }
    
    return self;
}

+ (instancetype)readCarouselItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
