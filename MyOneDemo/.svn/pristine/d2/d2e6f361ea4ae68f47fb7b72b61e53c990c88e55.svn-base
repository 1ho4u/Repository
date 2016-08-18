//
//  essay.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthorItem;

@interface EssayItem : NSObject

//@property (nonatomic, strong) AuthorItem *authorItem;
@property (nonatomic, strong) NSMutableArray<AuthorItem *> *authorItems;
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *guideWord;
@property (nonatomic, assign) NSUInteger hasAudio;
@property (nonatomic, copy) NSString *makeTime;
@property (nonatomic, copy) NSString *title;

+ (instancetype)essayItemWithDict:(NSDictionary *)dict;

@end
