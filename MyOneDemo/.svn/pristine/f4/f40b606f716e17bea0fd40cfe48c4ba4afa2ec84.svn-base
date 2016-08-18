//
//  essay.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "EssayItem.h"
#import "AuthorItem.h"

@implementation EssayItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.authorItems = [NSMutableArray arrayWithCapacity:1];
        [[NSArray arrayWithArray:dict[@"author"]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AuthorItem *authorItem = [AuthorItem authorItemWithDict:obj];
            [self.authorItems addObject:authorItem];
        }];
        self.contentID = dict[@"content_id"];
        self.guideWord = dict[@"guide_word"];
        self.hasAudio = [dict[@"guide_word"] integerValue];
        self.makeTime = dict[@"hp_makettime"];
        self.title = dict[@"hp_title"];
    }
    return self;
}

+ (instancetype)essayItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
