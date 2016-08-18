//
//  ReadBaseView.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/17.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "ReadBaseView.h"
#import "ReadBaseCell.h"
#import "EssayItem.h"
#import "QuestionItem.h"
#import "SerialItem.h"
#import <Masonry/Masonry.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

NSString *const kReadBaseViewID = @"ReadBaseViewID";

@interface ReadBaseView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MASConstraint *tableViewHeightConstraint;

@end


@implementation ReadBaseView {
    EssayItem *essayItem;
    QuestionItem *questionItem;
    SerialItem *serialItem;
    NSMutableArray *rowHeights;
}

#pragma mark - Initialize Method

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void) initDatas {
    essayItem = [EssayItem new];
    questionItem = [QuestionItem new];
    serialItem = [SerialItem new];
//    rowHeights = @[@0,@0,@0].mutableCopy;
}

- (void)setUpViews {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:252 / 255.0 blue:255 / 255.0 alpha:1];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(12, 12, SCREEN_WIDTH - 24, 450)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[ReadBaseCell class] forCellReuseIdentifier:kReadBaseCellID];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
//    _tableView.scrollsToTop = NO;
    //x,y中shadow延伸的尺寸
    _tableView.layer.shadowOffset = CGSizeZero;
    //渐变距离
    _tableView.layer.shadowRadius = 2;
    //shadow透明度
    _tableView.layer.shadowOpacity = 0.5;
    //圆角的弧度
    _tableView.layer.cornerRadius = 5;
    _tableView.layer.shadowColor = [UIColor colorWithWhite:102 / 255.0 alpha:1].CGColor;
    [_scrollView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(12, 12, 12, 12));
        make.width.equalTo(@(SCREEN_WIDTH-24));
        _tableViewHeightConstraint = make.height.equalTo(@450);
    }];
    
    
}

#pragma mark - Public Method

- (void)configureViewWithEssayItem:(EssayItem *)theEssayItem questionItem:(QuestionItem *)theQuestionItem serialItem:(SerialItem *)theSerialItem {
    
    [self initDatas];
    essayItem = theEssayItem;
    questionItem = theQuestionItem;
    serialItem = theSerialItem;
    
    rowHeights = @[@0,@0,@0].mutableCopy;
    _scrollView.contentOffset = CGPointZero;
    [_tableView reloadData];
    
}

#pragma mark - TableView Delegate
//自定义cell的行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat rowHeight = [tableView fd_heightForCellWithIdentifier:kReadBaseCellID configuration:^(ReadBaseCell *cell) {
        [self configureCell:cell atIndex:indexPath];
    }];
    rowHeights[indexPath.row] = @(ceil(rowHeight));
    if (indexPath.row == 2) {
        NSInteger tableViewHeight = 0;
        for (NSNumber *height in rowHeights) {
            tableViewHeight += [height integerValue];
        }
        _tableViewHeightConstraint.equalTo(@(tableViewHeight));
    }
    return ceil(rowHeight);
    
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReadBaseCellID];
    [self configureCell:cell atIndex:(NSIndexPath *)indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndex:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [(ReadBaseCell *)cell configureCellWithEssayItem:essayItem];
    }else if (indexPath.row == 1) {
        [(ReadBaseCell *)cell configureCellWithSerialItem:serialItem];
    }else {
        [(ReadBaseCell *)cell configureCellWithQuestionItem:questionItem];
    }
}

@end
