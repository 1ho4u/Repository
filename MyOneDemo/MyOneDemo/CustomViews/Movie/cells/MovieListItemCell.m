//
//  MovieListItemCell.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/15.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "MovieListItemCell.h"
#import "MovieItem.h"
#import "ScoreView.h"
#import <Masonry/Masonry.h>

NSString *const kMovieListItemCellID = @"MovieListItemCellID";

@interface MovieListItemCell ()

@property (nonatomic ,strong) UIImageView *coverView;
@property (nonatomic, strong) ScoreView *scoreView;
@property (nonatomic, strong) UILabel *comingsoonLabel;

@end

@implementation MovieListItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    _coverView = [UIImageView new];
    //使用Fill后填充了行间距，
//    _coverView.contentMode = UIViewContentModeScaleAspectFill;
    _coverView.backgroundColor = [UIColor whiteColor];
//    _coverView.userInteractionEnabled = YES;
    [self.contentView addSubview:_coverView];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _scoreView = [[ScoreView alloc] init];
    [_coverView addSubview:_scoreView];
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(_coverView).offset(-15);
    }];
    
    _comingsoonLabel = [UILabel new];
    _comingsoonLabel.textColor = [UIColor colorWithWhite:85 / 255.0 alpha:1];
    _comingsoonLabel.text = @"即将上映";
    _comingsoonLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_comingsoonLabel];
    [_comingsoonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView).offset(-6);
    }];
    _comingsoonLabel.hidden = YES;
    
    
}

- (void)configureCellWithItem:(MovieItem *)movieItem atIndexPath:(NSIndexPath *)indexPath {
    __block NSData *data;
    __block NSError *error;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:movieItem.imageURL] options:NSDataReadingMappedIfSafe error:&error];
        if (error) {
            NSLog(@"图片加载错误，error:%@", error.localizedDescription);
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                _coverView.image = [UIImage imageWithData:data];
            });
        }
    });
    if ([movieItem.score isEqual:[NSNull null]]) {
        _comingsoonLabel.hidden = NO;
        _scoreView.hidden = YES;
    }else {
        _comingsoonLabel.hidden = YES;
        _scoreView.hidden = NO;
        _scoreView.scoreLabel.text = movieItem.score;
    }
    
}

@end
