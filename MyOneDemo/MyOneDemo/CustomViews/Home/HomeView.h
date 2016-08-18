//
//  HomeView.h
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/1.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeItem;

FOUNDATION_EXPORT NSString *const kHomeViewID;

@interface HomeView : UIView

- (void)setUpViews;
- (void)configureViewWithHomeItem:(HomeItem *)homeItem atIndex:(NSInteger)index inViewController:(UIViewController *)viewController;

@end
