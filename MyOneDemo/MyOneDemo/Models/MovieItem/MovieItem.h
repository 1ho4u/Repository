//
//  MovieItem.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/16.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 cover = "http://image.wufazhuce.com/FtLdIEDs1s49gOi_tJDONmtaJmQk";
 id = 95;
 releasetime = "2016-07-15 00:00:00";
 revisedscore = 0;
 score = 80;
 scoretime = "2016-07-16 00:00:00";
 servertime = 1471317985;
 title = "\U8def\U8fb9\U91ce\U9910";
 verse = "";
 "verse_en" = "";
 */
@interface MovieItem : NSObject

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, assign) NSUInteger movieId;
@property (nonatomic, copy) NSString *releaseTime;
@property (nonatomic, assign) NSUInteger revisedScore;
@property (nonatomic, assign) NSString *score;
@property (nonatomic, copy) NSString *scoreTime;
@property (nonatomic, assign) NSUInteger serverTime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *verse;
@property (nonatomic, copy) NSString *verse_en;

+ (instancetype)movieItemWithDict:(NSDictionary *)dict;

@end
