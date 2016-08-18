//
//  QuestionItem.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "QuestionItem.h"

@implementation QuestionItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.answerContent = dict[@"answer_content"];
        self.answerTitle = dict[@"answer_title"];
        self.questionId = [dict[@"question_id"] integerValue];
        self.questionMakeTime = dict[@"question_makettime"];
        self.questionTitle = dict[@"question_title"];
    }
    
    return self;
}

+ (instancetype)questionItemWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
