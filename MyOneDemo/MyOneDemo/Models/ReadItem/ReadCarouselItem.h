//
//  ReadCarouselItem.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadCarouselItem : NSObject

@property (nonatomic, copy) NSString *bgColor;
@property (nonatomic, copy) NSString *bottomText;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, assign) NSUInteger Id;
@property (nonatomic, copy) NSString *pvURL;
@property (nonatomic, copy) NSString *title;

+ (instancetype)readCarouselItemWithDict:(NSDictionary *)dict;

@end
