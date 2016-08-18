//
//  TabBarViewController.m
//  MyOneDemo
//
//  Created by 蚊子 on 16/7/30.
//  Copyright © 2016年 wenzi. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "ReadViewController.h"
#import "MovieViewController.h"
#import "MusicViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        HomeViewController *homeViewController = [[HomeViewController alloc] init];
        UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
        
        ReadViewController *readViewController = [[ReadViewController alloc] init];
        UINavigationController *readNavigationController = [[UINavigationController alloc] initWithRootViewController:readViewController];
        
        MusicViewController *musicViewController = [[MusicViewController alloc] init];
        UINavigationController *musicNavigationController = [[UINavigationController alloc] initWithRootViewController:musicViewController];
        
        MovieViewController *movieViewController = [[MovieViewController alloc] init];
        UINavigationController *movieNavigationController = [[UINavigationController alloc] initWithRootViewController:movieViewController];
        
        self.viewControllers = @[homeNavigationController, readNavigationController, musicNavigationController, movieNavigationController];
        
        [self setUpTabBar];
        
    }
    
    return self;
}

- (void)setUpTabBar {
    NSArray *tabBarItemImageNames = [NSArray arrayWithObjects:@"tab_home", @"tab_read", @"tab_music", @"tab_movie", nil];
    NSArray *tabBarItemTitles = [NSArray arrayWithObjects:@"首页", @"阅读", @"音乐", @"电影", nil];
    NSUInteger index = 0;
    
    for (UIViewController *viewController in self.viewControllers) {
        NSString *normalImageName = [NSString stringWithFormat:@"%@_normal", [tabBarItemImageNames objectAtIndex:index]];
        NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected", [tabBarItemImageNames objectAtIndex:index]];
        NSString *tabBarTitle = [tabBarItemTitles objectAtIndex:index];
        viewController.tabBarItem.image = [UIImage imageNamed:normalImageName];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
        viewController.tabBarItem.title = tabBarTitle;
        
        index++;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
