//
//  ReadViewController.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/7/30.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadBaseView.h"
#import "HTTPRequester.h"
#import "ReadCarouselItem.h"
#import "EssayItem.h"
#import "AuthorItem.h"
#import "QuestionItem.h"
#import "SerialItem.h"

#import <GMCPagingScrollView/GMCPagingScrollView.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <Masonry/Masonry.h>

@interface ReadViewController () <GMCPagingScrollViewDelegate, GMCPagingScrollViewDataSource>

@property (nonatomic, strong) GMCPagingScrollView *pagingScrollView;
@property (nonatomic, strong) SDCycleScrollView *carouselView;

@end

@implementation ReadViewController {
    NSArray *carousels;
    NSArray *essayItems;
    NSArray *authorItems;
    NSArray *questionItems;
    NSArray *serialItems;
    NSMutableArray *carouselDataSource;
}

#pragma mark - UIView Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"阅读";
    [self addNavigationBarRightMeItem];
    [self addNavigationBarLeftSearchItem];
    
    [self initDatas];
    [self setUpViews];
    [self requestCarouselList];
    [self requestReadIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)initDatas {
    carousels = [NSArray array];
    essayItems = [NSArray array];
    authorItems = [NSArray array];
    questionItems = [NSArray array];;
    serialItems = [NSArray array];
    carouselDataSource = [NSMutableArray arrayWithCapacity:1];
}

- (void)setUpViews {
    _carouselView = [[SDCycleScrollView alloc] init];
    _carouselView.autoScrollTimeInterval = 5;
    _carouselView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _carouselView.backgroundColor = [UIColor colorWithWhite:170 / 255.0 alpha:1];
    [self.view addSubview:_carouselView];
    [_carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@143.5);
    }];
    
    _pagingScrollView = [[GMCPagingScrollView alloc] init];
    _pagingScrollView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:252 / 255.0 blue:255 / 255.0 alpha:1];
    _pagingScrollView.delegate = self;
    _pagingScrollView.dataSource = self;
    _pagingScrollView.interpageSpacing = 0;
    [_pagingScrollView registerClass:[ReadBaseView class] forReuseIdentifier:kReadBaseViewID];
    [self.view addSubview:_pagingScrollView];
    [_pagingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_carouselView.mas_bottom);
    }];
    
    
}

- (void) setCarouselViewDataSource:(NSArray *)theCarousels {
    if (carouselDataSource.count > 0) {
        [carouselDataSource removeAllObjects];
    }
    
    [theCarousels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ReadCarouselItem *item = obj;
        [carouselDataSource addObject:item.cover];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        _carouselView.imageURLStringsGroup = carouselDataSource;
    });
    
}

#pragma mark - Network request

- (void)requestCarouselList {
    [HTTPRequester requestReadCarouselListWithSuccess:^(id responseData) {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:1];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        [[dict objectForKey:@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ReadCarouselItem *item = [ReadCarouselItem readCarouselItemWithDict:obj];
            [items addObject:item];
        }];
        carousels = items;
        [self setCarouselViewDataSource:carousels];
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

- (void)requestReadIndex {
    [HTTPRequester requestReadIndexWithSuccess:^(id responseData) {
        NSError *error;
        NSArray *essay;
        NSArray *question;
        NSArray *serial;
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:1];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error) {
            NSLog(@"解析数据错误，错误原因：%@", error.localizedDescription);
        }else {
            if ([dict[@"res"] integerValue] == 0) {
                essay = [dict[@"data"] objectForKey:@"essay"];
                [essay enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    EssayItem *item = [EssayItem essayItemWithDict:obj];
                    [items addObject:item];
                }];
                essayItems = items.copy;
                [items removeAllObjects];
                question = [dict[@"data"] objectForKey:@"question"];
                [question enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    QuestionItem *item = [QuestionItem questionItemWithDict:obj];
                    [items addObject:item];
                }];
                questionItems = items.copy;
                [items removeAllObjects];
                serial = [dict[@"data"] objectForKey:@"serial"];
                [serial enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    SerialItem *item = [SerialItem serialItemWithDict:obj];
                    [items addObject:item];
                }];
                serialItems = items.copy;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_pagingScrollView reloadData];
                });
            }else {
                NSLog(@"无数据");
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
    
}

#pragma mark - GMCPagingScrollViewDelegate Method

#pragma mark - GMCPagingScrollViewDataSource Method


-(NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView {
    return essayItems.count;
}

-(UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index {
    UIView *view = [pagingScrollView dequeueReusablePageWithIdentifier:kReadBaseViewID];
    [(ReadBaseView *)view configureViewWithEssayItem:essayItems[index] questionItem:questionItems[index] serialItem:serialItems[index]];
    return view;
}


@end
