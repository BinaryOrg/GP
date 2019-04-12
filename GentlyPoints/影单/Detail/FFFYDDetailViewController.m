//
//  FFFYDDetailViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYDDetailViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import "FFFMovieModel.h"
#import <MJRefresh/MJRefresh.h>
#import "FFFMovieTableViewCell.h"
#import "GGGMovieDetailViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface FFFYDDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FFFYDDetailViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, SCREENWIDTH, SCREENHEIGHT - 180) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        //        __weak typeof(self) weakSelf = self;
        //        MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //            [weakSelf refreshPage];
        //        }];
        //
        //        NSMutableArray *idleImages = [NSMutableArray array];
        //        for (NSUInteger i = 0; i <= 78; i++) {
        //            NSString *imgName = [NSString stringWithFormat:@"iCityLoading2_000%02ld_74x50_", (unsigned long)i];
        //            UIImage *image = [UIImage imageNamed:imgName];
        //            if (image) {
        //                [idleImages addObject:image];
        //            }
        //        }
        //
        //        [gifHeader setImages:idleImages forState:MJRefreshStateIdle];
        //
        //        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        //        NSMutableArray *refreshingImages = [NSMutableArray array];
        //        for (NSUInteger i = 4; i <= 78; i++) {
        //            NSString *imgName = [NSString stringWithFormat:@"iCityLoading2_000%02ld_74x50_", (unsigned long)i];
        //            UIImage *image = [UIImage imageNamed:imgName];
        //            if (image) {
        //                [refreshingImages addObject:image];
        //            }
        //        }
        //        [gifHeader setImages:refreshingImages forState:MJRefreshStatePulling];
        //
        //        // 设置正在刷新状态的动画图片
        //        [gifHeader setImages:refreshingImages forState:MJRefreshStateRefreshing];
        //
        //        //隐藏时间
        //        gifHeader.lastUpdatedTimeLabel.hidden = YES;
        //        //隐藏状态
        //        gifHeader.stateLabel.hidden = YES;
        //        _tableView.mj_header = gifHeader;
        
        //        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray<FFFMovieModel *> *)movies {
    if (!_movies) {
        _movies = @[].mutableCopy;
    }
    return _movies;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.fd_prefersNavigationBarHidden = YES;
    [self setHeader];
    [self.view addSubview:self.tableView];
}

- (void)setHeader {
    YYAnimatedImageView *bg = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.layer.masksToBounds = YES;
    [self.view addSubview:bg];
    [bg yy_setImageWithURL:[NSURL URLWithString:self.headerUrl] placeholder:[UIImage imageNamed:@"illustration_open_notification_210x80_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *vis = [[UIVisualEffectView alloc] initWithEffect:blur];
//    vis.alpha = 0.6;
    vis.frame = bg.bounds;
    [bg addSubview:vis];
    
    UILabel *title = [[UILabel alloc] initWithFrame:bg.bounds];
    title.font = [UIFont ztw_mediumFontSize:25];
    title.textColor = [UIColor whiteColor];
    title.text = self.title;
    [bg addSubview:title];
    title.textAlignment = NSTextAlignmentCenter;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.movies.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movie_cell"];
    if (!cell) {
        cell = [[FFFMovieTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"movie_cell"];
    }
    FFFMovieModel *movie = self.movies[indexPath.section];
    [cell.poster yy_setImageWithURL:[NSURL URLWithString:movie.poster] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
    
    cell.nameLabel.text = movie.name;
    cell.introLabel.text = [NSString stringWithFormat:@"%@ | %@", movie.region, movie.duration];
    cell.dateLabel.text = movie.release_info;
    cell.actorLabel.text = [movie.type componentsJoinedByString:@" | "];
    cell.scoreLabel.text = [movie.score isEqualToString:@"暂无评分"] || [movie.score isEqualToString:@"0"] ? @"暂无": movie.score;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.movies.count - 1) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.movies.count - 1) {
        return nil;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFMovieModel *movie = self.movies[indexPath.section];
    GGGMovieDetailViewController *detail = [GGGMovieDetailViewController new];
    detail.movie = movie;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
