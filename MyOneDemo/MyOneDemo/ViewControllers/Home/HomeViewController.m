//
//  HomeViewController.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/7/30.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeItem.h"
#import "HTTPRequester.h"
#import <GMCPagingScrollView/GMCPagingScrollView.h>
#import <CoreLocation/CoreLocation.h>
//#import <Masonry/Masonry.h>

@interface HomeViewController () <GMCPagingScrollViewDataSource, GMCPagingScrollViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) GMCPagingScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *diaryButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation HomeViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_home_title"]];
    [self addNavigationBarLeftSearchItem];
    [self addNavigationBarRightMeItem];
    
    
    [self initDatas];
    [self setUpViews];
//    [self startLocation];
//    [self loadCache];
    [self requestHomeMore];
    [_indicator startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setUp View

- (void)setUpViews {
    self.view.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:252 / 255.0 blue:255 / 255.0 alpha:1];
    _pagingScrollView = [GMCPagingScrollView new];
    _pagingScrollView.backgroundColor = [UIColor colorWithRed:250 / 255.0 green:252 / 255.0 blue:255 / 255.0 alpha:1];
    [_pagingScrollView registerClass:[HomeView class] forReuseIdentifier:kHomeViewID];
    _pagingScrollView.dataSource = self;
    _pagingScrollView.delegate = self;
    _pagingScrollView.pageInsets = UIEdgeInsetsZero;
    _pagingScrollView.interpageSpacing = 0;
    
    [self.view addSubview:_pagingScrollView];
    _pagingScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addPagingScrollViewConstraint];
    _pagingScrollView.hidden = YES;
    
    _diaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_diaryButton setImage:[UIImage imageNamed:@"diary_normal"] forState:UIControlStateNormal];
    _diaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_pagingScrollView insertSubview:_diaryButton atIndex:0];
    [self addDiaryButtonConstraints];
    
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton setImage:[UIImage imageNamed:@"share_image"] forState:UIControlStateNormal];
    [_pagingScrollView insertSubview:_moreButton atIndex:1];
    _moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addMoreButtonConstraints];

    _likeNumLabel = [[UILabel alloc] init];
    _likeNumLabel.font = [UIFont systemFontOfSize:11];
    _likeNumLabel.textColor = [UIColor colorWithWhite:173 / 255.0 alpha:1];
    [_pagingScrollView insertSubview:_likeNumLabel atIndex:2];
    _likeNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addLikeNumLabelConstraints];
    
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_likeButton setImage:[UIImage imageNamed:@"like_normal"] forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"like_selected"] forState:UIControlStateSelected];
    [_pagingScrollView insertSubview:_likeButton atIndex:3];
    _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addLikeButtonConstraints];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
}

- (void)loadCache {
    NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getHomeItemCacheFilePath]];
    if (items.count) {
        self.dataSource = items;
    }else {
        NSLog(@"items is null");
    }
}

#pragma mark - Setter Method

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_indicator stopAnimating];
        _pagingScrollView.hidden = NO;
        [_pagingScrollView reloadData];
    });
    if (dataSource.count > 0) {
        [self updateLikeNumLabeTextWithItemIndex:0];
    }
}

#pragma mark - Private Method

- (void)initDatas {
    _dataSource = [NSArray array];
}

- (HomeItem *)homeItemAtIndex:(NSUInteger)index {
    return _dataSource[index];
}

- (void)updateLikeNumLabeTextWithItemIndex:(NSUInteger)index {
    HomeItem *item = [_dataSource objectAtIndex:index];
    _likeNumLabel.text = [@(item.praisenum) stringValue];
}

- (NSString *)getHomeItemCacheFilePath {
    NSFileManager *fm;
    NSString *filePath;
    NSString *path;
    NSString *directoryPath;
    
    fm = [NSFileManager defaultManager];
    path = [NSString stringWithFormat:@"%@/CacheFiles/CacheHomeItem", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    
    directoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"CacheFiles"];
    [fm createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    filePath = [directoryPath stringByAppendingPathComponent:@"CacheHomeItem"];
    
    return filePath;
}

#pragma mark - Network Request

- (void)requestHomeMore {
    [HTTPRequester requestHomeMoreWithSuccess:^(id responseData) {
        NSMutableArray *items = [NSMutableArray array];
//        NSString *filePath;
       NSError *error;
//        filePath = [self getHomeItemCacheFilePath];
        NSDictionary *homeData = [NSJSONSerialization JSONObjectWithData:(NSData *)responseData options:kNilOptions error:&error];
        if (!error) {
            if ([homeData[@"res"] integerValue] == 0) {
                [homeData[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    HomeItem *homeItem = [HomeItem homeItemWithDict:obj];
                    [items addObject:homeItem];
                }];
                self.dataSource = items;
                
            }else {
                NSLog(@"无数据");
            }
        }else {
            NSLog(@"解析数据错误，错误原因：%@", error.localizedDescription);
        }
        
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //不知道为什么这里dataSource是空的
//            NSLog(@"dataSource:%@",self.dataSource);
//            if ([NSKeyedArchiver archiveRootObject:_dataSource toFile:filePath] == YES) {
//            }
//        });
    } fail:^(NSError *error) {
        NSLog(@"error:%@", [error localizedDescription]);
    }];
}

#pragma mark - GMCPagingScrollViewDataSource Method

- (NSUInteger)numberOfPagesInPagingScrollView:(GMCPagingScrollView *)pagingScrollView {
    return _dataSource.count;
}

- (UIView *)pagingScrollView:(GMCPagingScrollView *)pagingScrollView pageForIndex:(NSUInteger)index {
    HomeView *view = [pagingScrollView dequeueReusablePageWithIdentifier:kHomeViewID];
//    NSLog(@"当前视图下标为:%li", index);
    [view configureViewWithHomeItem:[self homeItemAtIndex:index] atIndex:index inViewController:self];
    return view;
}

-(void)pagingScrollView:(GMCPagingScrollView *)pagingScrollView didScrollToPageAtIndex:(NSUInteger)index {
    [self updateLikeNumLabeTextWithItemIndex:index];
}

#pragma mark - GMCPagingScrollViewDelegate Method

- (void)pagingScrollViewDidScroll:(GMCPagingScrollView *)pagingScrollView {
//    NSLog(@"%f",pagingScrollView.scrollView.contentOffset.x);
}

#pragma mark - Location Server

- (void)startLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //控制精度，精度越高耗电量越大
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"拒绝访问");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations firstObject];
    
    //获取城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度方向地理编译出地理信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count>0) {
            CLPlacemark *placemart = [placemarks objectAtIndex:0];
            NSString *city = placemart.locality;
            //直辖市需通过省份信息获取，locality获取不到直辖市信息
            if (!city) {
                city = placemart.administrativeArea;
            }
            NSLog(@"city = %@", city);
        }else if(!error && placemarks.count == 0) {
            NSLog(@"no result were returned.");
        }else if(error){
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
}

#pragma mark - UIView Constraint

- (void) addPagingScrollViewConstraint {
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:_pagingScrollView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:_pagingScrollView
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeLeft
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:_pagingScrollView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:_pagingScrollView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
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
    [_pagingScrollView addConstraints:@[
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
    [_pagingScrollView addConstraint:
     [NSLayoutConstraint constraintWithItem:_diaryButton
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:_pagingScrollView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1.0
                                   constant:8]
     ];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_diaryButton
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:-73]
     ];

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
    [_pagingScrollView addConstraints:@[
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

- (void)addMoreButtonConstraints {
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
    [self.view addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:_moreButton
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
*/
@end

