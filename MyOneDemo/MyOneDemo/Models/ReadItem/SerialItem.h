//
//  SerialItem.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AuthorItem;

@interface SerialItem : NSObject

@property (nonatomic, strong) AuthorItem *authorItem;
@property (nonatomic, copy) NSString *excerpt;
@property (nonatomic, assign) NSUInteger hasAudio;
@property (nonatomic, assign) NSUInteger Id;
@property (nonatomic, copy) NSString *makeTime;
@property (nonatomic, copy) NSString *readNum;
@property (nonatomic, assign) NSUInteger number;
@property (nonatomic, assign) NSUInteger serialId;
@property (nonatomic, copy) NSString *title;

+ (instancetype)serialItemWithDict:(NSDictionary *)dict;

@end
