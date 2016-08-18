//
//  ScoreView.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/16.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "ScoreView.h"
#import <Masonry/Masonry.h>

@interface ScoreView ()

@property (nonatomic, strong) UIImageView *scoreImage;

@end

@implementation ScoreView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    self.transform = CGAffineTransformMakeRotation(-M_PI_4/2);
    
    self.backgroundColor = nil;
    _scoreLabel = [UILabel new];
    _scoreLabel.textColor = [UIColor colorWithRed:240 / 255.0 green:89 / 255.0 blue:93 / 255.0 alpha:1];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont fontWithName:@"Bradley Hand" size:48];
    [self addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.top.greaterThanOrEqualTo(self.mas_top);
    }];
    
    _scoreImage = [UIImageView new];
    _scoreImage.image = [UIImage imageNamed:@"redline"];
    [self addSubview:_scoreImage];
    [_scoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(81, 5));
        make.top.equalTo(_scoreLabel.mas_bottom);
        make.right.bottom.left.equalTo(self);
        make.centerX.equalTo(_scoreLabel);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
