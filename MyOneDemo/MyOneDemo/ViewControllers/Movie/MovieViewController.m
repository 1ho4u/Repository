//
//  MovieViewController.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/7/30.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieListItemCell.h"
#import "HTTPRequester.h"
#import "MovieItem.h"
#import <Masonry/Masonry.h>

@interface MovieViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MovieViewController {
    NSMutableArray *dataSource;
}

#pragma mark - UIView LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"电影";
    [self addNavigationBarLeftSearchItem];
    [self addNavigationBarRightMeItem];
    
    [self requestMovieListWithOffset:0];
    [self initDatas];
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)initDatas {
    dataSource = [NSMutableArray arrayWithCapacity:1];
}

- (void)setUpViews {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //会调用MovieListItemCell类中的initWithFrame方法
    [_collectionView registerClass:[MovieListItemCell class] forCellWithReuseIdentifier:kMovieListItemCellID];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma makr - Reuqest Network

- (void)requestMovieListWithOffset:(NSUInteger)offset {
    [HTTPRequester requestMovieListWithOffset:offset success:^(id responseData) {
        NSError *error;
        NSDictionary *movieData =[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        if (error) {
            NSLog(@"解析数据错误，错误原因：%@", error.localizedDescription);
        }else {
            if ([[movieData valueForKey:@"res"] integerValue] == 0) {
                [[movieData valueForKey:@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MovieItem *item = [MovieItem movieItemWithDict:obj];
                    [dataSource addObject:item];
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_collectionView reloadData];
                });
            } else {
                NSLog(@"无数据");
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error.localizedDescription);
    }];
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(MovieListItemCell *)cell configureCellWithItem:[dataSource objectAtIndex:indexPath.row] atIndexPath:indexPath];
}

#pragma make - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMovieListItemCellID forIndexPath:indexPath];

    return cell;
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
