//
//  HomeItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/9.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "HomeItem.h"

@implementation HomeItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.authorId = dict[@"author_id"];;
        self.commentnum = [dict[@"commentnum"] integerValue];;
        self.author = dict[@"hp_author"];
        self.content = dict[@"hp_content"];
        self.imageOriginalURL = dict[@"hp_img_original_url"];
        self.imageURL = dict[@"hp_img_url"];
        self.makeTime = dict[@"hp_makettime"];
        self.title = dict[@"hp_title"];
        self.contentId = dict[@"hpcontent_id"];
        self.ipadURL = dict[@"ipad_url"];
        self.lastUpdateDate = dict[@"last_update_date"];
        self.praisenum = [dict[@"praisenum"] integerValue];;
        self.sharenum = [dict[@"sharenum"] integerValue];;
        self.webImageURL =dict[@" wb_img_url"];
        self.webURL = dict[@"web_url"];
    }
    
    return self;
}

+ (instancetype)homeItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
