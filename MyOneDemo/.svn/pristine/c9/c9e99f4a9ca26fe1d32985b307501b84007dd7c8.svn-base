//
//  HomeView.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/8/1.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "HomeView.h"
#import "HomeItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kHomeViewID = @"HomeViewID";

@interface HomeView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *volLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *localtionLabel;
@property (nonatomic, strong) UIImageView *weatherView;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *diaryButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

#pragma mark - initiallization
@implementation HomeView {
    CGFloat contentTextHeight;
}

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

#pragma mark - setUpViews

- (void)setUpViews
{
    
    //底层滚动视图
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
//    _scrollView.scrollsToTop
    //取消自身约束
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_scrollView];
    [self addScrollViewConstraints];
    
    
    //diaryButton
    _diaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_diaryButton addTarget:self action:@selector(diaryButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _diaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_diaryButton];
    [self addDiaryButtonConstraints];
    
    //moreButton
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_moreButton];
    [self addMoreBUttonConstraints];
    
    //likeNumLabel
    _likeNumLabel = [UILabel new];
    _likeNumLabel.font = [UIFont systemFontOfSize:11];
    _likeNumLabel.textColor = [UIColor colorWithWhite:173 / 255.0 alpha:1];
    _likeNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_likeNumLabel];
    [self addLikeNumLabelConstraints];
    
    //likeButton
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton addTarget:self action:@selector(likeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView addSubview:_likeButton];
    [self addLikeButtonConstraints];
    
    //内容视图中的底层视图
    _contentView = [[UIView alloc] init];
    _contentView.layer.shadowColor = [[UIColor colorWithWhite:102 / 255.0 alpha:1] CGColor];
    //设置shadow在x,y轴延伸的大小
    _contentView.layer.shadowOffset = CGSizeZero;
    //渐变距离，由外围往里渐变
    _contentView.layer.shadowRadius = 2;
    //设置shadow的透明效果
    _contentView.layer.shadowOpacity = 0.5;
    //设置UIView的圆角
    _contentView.layer.cornerRadius = 5;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
    [self addContentViewConstraints];
    
    //图片视图
    _coverView = [[UIImageView alloc] init];
    _coverView.backgroundColor = [UIColor whiteColor];
    //自适应内容大小保持长宽比，剩余区域为透明的
    _coverView.contentMode = UIViewContentModeScaleAspectFit;
    //子视图的显示范围，当为YES时，剪裁超过父视图范围子视图的部分
    _coverView.clipsToBounds = YES;
    //防止子视图遮挡点击事件，正常响应事件
    _coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTapAction)];
    _coverView.translatesAutoresizingMaskIntoConstraints = NO;
    [_coverView addGestureRecognizer:tap];
    [_contentView addSubview:_coverView];
    [self addCoverViewConstraints];
    
    _volLabel = [[UILabel alloc] init];
    _volLabel.backgroundColor = [UIColor whiteColor];
    _volLabel.textColor = [UIColor colorWithWhite:198 / 255.0 alpha:1];
    _volLabel.font = [UIFont systemFontOfSize:11];
    _volLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_volLabel];
    [self addVolLabelConstraints];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = [UIColor colorWithWhite:177 / 255.0 alpha:1];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.font = [UIFont systemFontOfSize:10];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_titleLabel];
    [self addTitleLabelConstraints];
    
    _contentTextView = [[UITextView alloc] init];
    _contentTextView.textColor = [UIColor colorWithWhite:90 / 255.0 alpha:1];
    _contentTextView.backgroundColor = [UIColor whiteColor];
    _contentTextView.font = [UIFont systemFontOfSize:14];
    _contentTextView.editable = NO;
    _contentTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_contentTextView];
    [self addContentTextViewConstraints];
    
    _dateLabel = [UILabel new];
    _dateLabel.textColor = [UIColor colorWithWhite:173 / 255.0 alpha:1];
    _dateLabel.backgroundColor = [UIColor whiteColor];
    _dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _dateLabel.font = [UIFont systemFontOfSize:12];
    [_contentView addSubview:_dateLabel];
    [self addDateLabelConstraints];
    
    _localtionLabel = [UILabel new];
    _localtionLabel.textColor = [UIColor colorWithWhite:173 / 255.0 alpha:1];
    _localtionLabel.backgroundColor = [UIColor whiteColor];
    _localtionLabel.font = [UIFont systemFontOfSize:12];
    _localtionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_localtionLabel];
    [self addLocaltionLabelConstraints];
    
    _temperatureLabel = [UILabel new];
    _temperatureLabel.textColor = [UIColor colorWithWhite:173 / 255.0 alpha:1];
    _temperatureLabel.backgroundColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont systemFontOfSize:12];
    _temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_temperatureLabel];
    [self addTemperatureLabelConstraints];
    
    _weatherView = [UIImageView new];
    _weatherView.backgroundColor = [UIColor whiteColor];
    _weatherView.translatesAutoresizingMaskIntoConstraints = NO;
    [_contentView addSubview:_weatherView];
    [self addWeatherViewConstraints];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = _coverView.center;
    [self addSubview:_indicator];
    
}

#pragma makr - Setter Method

- (void)setCoverView:(UIImageView *)coverView {
    _coverView = coverView;
    [_indicator stopAnimating];
}

#pragma mark - Public Method

- (void)configureViewWithHomeItem:(HomeItem *)homeItem atIndex:(NSInteger)index inViewController:(UIViewController *)viewController {
//    NSLog(@"准备设置界面");
    _coverView.image = nil;
    __block NSError *error;
    __block NSData *imageData;
    [_indicator startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:homeItem.imageURL] options:NSDataReadingMappedIfSafe error:&error];
        if (error) {
            NSLog(@"加载图片出错，错误原因：%@", error.localizedDescription);
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.coverView.image = [UIImage imageWithData:imageData];
            });
        }
    });
    [_coverView sd_setImageWithURL:[NSURL URLWithString:homeItem.imageURL]];
    _volLabel.text = homeItem.title;
    _titleLabel.text = homeItem.author;
//    _likeNumLabel.text = [@(homeItem.praisenum) stringValue];
    contentTextHeight = _contentTextView.contentSize.height;
//    NSLog(@"contentTextHeight:%lf", _contentTextView.contentSize.height);
    _contentTextView.text = homeItem.content;
    
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"EEE dd MMM.yyyy"];
    NSDate *date = [formatter dateFromString:homeItem.makeTime];
    NSString *makeDateTime = [dateFormatter stringFromDate:date];
    _dateLabel.text = makeDateTime;
    
    //数据写死，后续更改
    _weatherView.image = [UIImage imageNamed:@"light_rain"];
    _localtionLabel.text = @"广州";
    _temperatureLabel.text = @"28ºC";
}

#pragma mark - Action Method

- (void)coverTapAction {
    NSLog(@"你点我了");
}

- (void)diaryButtonClicked {
    NSLog(@"你点我了");
}

- (void)moreButtonClicked {
    NSLog(@"你点我了");
}

- (void)likeButtonClicked {
    NSLog(@"你点我了");
}

#pragma mark - Control Constraint
- (void)addScrollViewConstraints {
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_scrollView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_scrollView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.0
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_scrollView
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                         constant:0],
                           [NSLayoutConstraint constraintWithItem:_scrollView
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.0
                                                         constant:0],
                           
                           ]
     ];
}

- (void)addContentViewConstraints {
    NSArray *constraints = @[
                             [NSLayoutConstraint constraintWithItem:_contentView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-12.0],
                             [NSLayoutConstraint constraintWithItem:_contentView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-184.0],
                             [NSLayoutConstraint constraintWithItem:_contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:kNilOptions
                                                         multiplier:1.0
                                                           constant:[UIScreen mainScreen].bounds.size.width - 24],
                             ];
    //设置此约束的优先级
    [[constraints firstObject] setPriority:UILayoutPriorityDefaultHigh];
    [[constraints lastObject] setPriority:UILayoutPriorityDefaultHigh];
    [constraints[1] setPriority:UILayoutPriorityDefaultHigh];
    //约束自身宽高，无参照物，需将约束添加到自身上
    [_contentView addConstraint:[constraints lastObject]];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1.0
                                                         constant:76.0],
                           [constraints firstObject],
                           constraints[1],
                           [NSLayoutConstraint constraintWithItem:_contentView
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1.0
                                                         constant:12.0],
                           
                           ]
     ];

}

- (void)addCoverViewConstraints {
//    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_coverView
//                                                                  attribute:NSLayoutAttributeRight
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:_contentView
//                                                                  attribute:NSLayoutAttributeRight
//                                                                 multiplier:1.0
//                                                                   constant:-6.0];
//    [constraint setPriority:UILayoutPriorityDefaultHigh];
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_coverView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:6.0],
                                   [NSLayoutConstraint constraintWithItem:_coverView
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:6.0],
                                   [NSLayoutConstraint constraintWithItem:_coverView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:-6.0],
                                   [NSLayoutConstraint constraintWithItem:_coverView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeWidth
                                                               multiplier:0.75
                                                                 constant:0],
                                   ]
     ];
}

- (void)addVolLabelConstraints {
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_volLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:10],
                                   [NSLayoutConstraint constraintWithItem:_volLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:0],
                                   
                                   ]
     ];
}

- (void)addTitleLabelConstraints {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:_volLabel
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.0
                                                                   constant:4];
    [constraint setPriority:UILayoutPriorityDefaultHigh];
    [_contentView addConstraints:@[
                                   constraint,
                                   [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:8],
                                   [NSLayoutConstraint constraintWithItem:_titleLabel
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:0],
                                   ]
     ];
}

- (void)addContentTextViewConstraints {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_contentTextView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:_volLabel
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:15];
    [constraint setPriority:UILayoutPriorityDefaultHigh];
//    [_contentTextView addConstraint:[NSLayoutConstraint constraintWithItem:_contentTextView
//                                                                 attribute:NSLayoutAttributeHeight
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:nil
//                                                                 attribute:kNilOptions
//                                                                multiplier:1.0
//                                                                  constant:contentTextHeight]
//     ];
    [_contentView addConstraints:@[
                                   constraint,
                                   [NSLayoutConstraint constraintWithItem:_contentTextView
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:0],
                                   [NSLayoutConstraint constraintWithItem:_contentTextView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:0],
                                   ]
     ];
}

- (void)addDateLabelConstraints {
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_dateLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentTextView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:10],
                                   [NSLayoutConstraint constraintWithItem:_dateLabel
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:-12],
                                   [NSLayoutConstraint constraintWithItem:_dateLabel
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_coverView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0
                                                                 constant:0],
                                   ]
     ];
}

- (void)addTemperatureLabelConstraints {
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_temperatureLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_dateLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0],
                                   [NSLayoutConstraint constraintWithItem:_temperatureLabel
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_localtionLabel
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:-2],
                                   ]
     ];
}

- (void)addWeatherViewConstraints {
    [_weatherView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_weatherView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:kNilOptions
                                                               multiplier:1.0
                                                                 constant:24],
                                   [NSLayoutConstraint constraintWithItem:_weatherView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:kNilOptions
                                                               multiplier:1.0
                                                                 constant:24],
                                   
                                   ]
     ];
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_weatherView
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_dateLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0],
                                   [NSLayoutConstraint constraintWithItem:_weatherView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_temperatureLabel
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:-5],
                                   
                                   ]
     
     ];

}

- (void)addLocaltionLabelConstraints {
    [_contentView addConstraints:@[
                                   [NSLayoutConstraint constraintWithItem:_localtionLabel
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_dateLabel
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.0
                                                                 constant:-10],
                                   [NSLayoutConstraint constraintWithItem:_localtionLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_dateLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0],
                                   ]
     ];
}

- (void)addMoreBUttonConstraints {
    [_moreButton addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:_moreButton
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:kNilOptions
                                                              multiplier:1.0
                                                                constant:44],
                                  [NSLayoutConstraint constraintWithItem:_moreButton
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:kNilOptions
                                                              multiplier:1.0
                                                                constant:44],
                                  ]
     ];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_moreButton
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1.0
                                                         constant:-8],
                           [NSLayoutConstraint constraintWithItem:_moreButton
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:_diaryButton
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1.0
                                                         constant:0],
                           ]
     ];

}

- (void)addLikeButtonConstraints {
    [_likeButton addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:_likeButton
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:kNilOptions
                                                              multiplier:1.0
                                                                constant:44],
                                  [NSLayoutConstraint constraintWithItem:_likeButton
                                                               attribute:NSLayoutAttributeWidth
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:kNilOptions
                                                              multiplier:1.0
                                                                constant:44],
                                  
                                  ]
     ];
    [_scrollView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:_likeButton
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_likeNumLabel
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0],
                                  [NSLayoutConstraint constraintWithItem:_likeButton
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_diaryButton
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0],
                                  ]];
}

- (void)addLikeNumLabelConstraints {
    [_likeNumLabel addConstraints:@[
                                    [NSLayoutConstraint constraintWithItem:_likeNumLabel
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:kNilOptions
                                                                multiplier:1.0
                                                                  constant:44],
                                    [NSLayoutConstraint constraintWithItem:_likeNumLabel
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:kNilOptions
                                                                multiplier:1.0
                                                                  constant:44],
                                    ]
     ];
    [_scrollView addConstraints:@[
                                  [NSLayoutConstraint constraintWithItem:_likeNumLabel
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_moreButton
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0],
                                  
                                  [NSLayoutConstraint constraintWithItem:_likeNumLabel
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_diaryButton
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0],
                                  ]
     ];
}

- (void)addDiaryButtonConstraints {
    [_diaryButton addConstraints:@[
                                   [NSLayoutConstraint  constraintWithItem:_diaryButton
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:kNilOptions
                                                                multiplier:1.0
                                                                  constant:44],
                                   [NSLayoutConstraint  constraintWithItem:_diaryButton
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:kNilOptions
                                                                multiplier:1.0
                                                                  constant:44],
                                   ]
     ];
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:_diaryButton
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:8]
     ];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_diaryButton
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:-73]
     ];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
