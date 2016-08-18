//
//  ReadBaseView.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EssayItem;
@class QuestionItem;
@class SerialItem;

FOUNDATION_EXPORT NSString *const kReadBaseViewID;

@interface ReadBaseView : UIView

- (void)configureViewWithEssayItem:(EssayItem *)essayItem questionItem:(QuestionItem *)questionItem serialItem:(SerialItem *)serialItem;

@end
