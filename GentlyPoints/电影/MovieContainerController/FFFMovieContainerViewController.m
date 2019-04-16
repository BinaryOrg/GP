//
//  FFFMovieContainerViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieContainerViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "UIColor+ZTWColor.h"
#import "UIFont+ZTWFont.h"
#import "FFFMovieViewController.h"
#import "FFFYDListViewController.h"
#import "FFFSearchViewController.h"
#import "FFFLoginViewController.h"

@interface FFFMovieContainerViewController ()
<
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate
>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView  *listContainerView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<NSString *> *categories;
@end

@implementation FFFMovieContainerViewController

- (NSMutableArray<NSString *> *)titles {
    if (!_titles) {
        _titles = @[
                    @"影院热映",
                    @"即将上映",
                    @"人气榜单",
                    @"热门影单"
                    ].mutableCopy;
    }
    return _titles;
}

- (NSMutableArray<NSString *> *)categories {
    if (!_categories) {
        _categories = @[
                        @"is_playing",
                        @"will_playing",
                        @"popular_list",
                        ].mutableCopy;
    }
    return _categories;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
        _categoryView.delegate = self;
        _categoryView.titleColor = [UIColor ztw_grayColor];
        _categoryView.titleSelectedColor = [UIColor ztw_yellowColor];
        _categoryView.contentEdgeInsetLeft = 20;
        _categoryView.contentEdgeInsetRight = 20;
//        _categoryView.cellSpacing = ZTWAutoLayoutValue(32);
//        _categoryView.cellWidth = ZTWAutoLayoutValue(28);
        _categoryView.titleFont = [UIFont ztw_regularFontSize:14];
        _categoryView.titleSelectedFont =  [UIFont ztw_mediumFontSize:16];
        _categoryView.titleColorGradientEnabled = NO;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineViewColor = [UIColor ztw_yellowColor];
        lineView.indicatorLineWidth = 32;
        lineView.indicatorLineViewHeight = 3;
        _categoryView.indicators = @[lineView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
        self.categoryView.contentScrollView = _listContainerView.scrollView;
        _listContainerView.backgroundColor = [UIColor whiteColor];
    }
    return _listContainerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.categoryView.titles = self.titles;
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)setNaviTitle {
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 30, SCREENWIDTH - 40, 30)];
    
    container.backgroundColor = [UIColor ztw_colorWithRGB:245];
    container.layer.cornerRadius = 4;
    container.layer.masksToBounds = YES;
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:@"请输入搜索内容" forState:(UIControlStateNormal)];
    [b setTitleColor:[UIColor ztw_colorWithRGB:153] forState:(UIControlStateNormal)];
    b.frame = CGRectMake(0, 5, WIDTH(container), 20);
    [container addSubview:b];
    [b addTarget:self action:@selector(search) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = container;
}

- (void)search {
//    FFFLoginViewController *login = [FFFLoginViewController new];
//    [self presentViewController:login animated:YES completion:nil];
    FFFSearchViewController *search = [FFFSearchViewController new];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.categoryView.frame = CGRectMake(0, 0, WIDTH(self.view), 44);
    self.listContainerView.frame = CGRectMake(0, 45, WIDTH(self.view), HEIGHT(self.view) - 45);
}

#pragma mark - JXCategoryListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 3) {
        FFFYDListViewController *yd = [[FFFYDListViewController alloc] init];
        yd.naviController = self.navigationController;
        return yd;
    }
    FFFMovieViewController *movie = [[FFFMovieViewController alloc] initWithMovieId:self.categories[index]];
    movie.naviController = self.navigationController;
    return movie;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

@end
