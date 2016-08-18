//
//  MovieItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/16.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "MovieItem.h"

@implementation MovieItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.imageURL = dict[@"cover"];
        self.movieId = [dict[@"id"] integerValue];
        self.releaseTime = dict[@"releasetime"];
        self.revisedScore = [dict[@"revisedscore"] integerValue];
        self.score = dict[@"score"];
        self.scoreTime = dict[@"scoretime"];
        self.title = dict[@"title"];
        self.verse = dict[@"verse"];
        self.verse_en = dict[@"verse_en"];
    }
    
    return self;
}

+ (instancetype)movieItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
