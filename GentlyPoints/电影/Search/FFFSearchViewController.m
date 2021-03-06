//
//  FFFSearchViewController.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFSearchViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import "FFFMovieModel.h"
#import <MJRefresh/MJRefresh.h>
#import "FFFMovieTableViewCell.h"
#import "GGGMovieDetailViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface FFFSearchViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (nonatomic, strong) NSString *movieId;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *b;
@property (nonatomic, strong) NSMutableArray<FFFMovieModel *> *movies;
@end

@implementation FFFSearchViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavBarHeight) style:UITableViewStyleGrouped];
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

- (instancetype)initWithMovieId:(NSString *)movieId
{
    self = [super init];
    if (self) {
        _movieId = movieId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.fd_interactivePopDisabled = YES;
    [self addEmptyView];
    [self.b becomeFirstResponder];
}

- (void)sendRequest {
    [self showLoading];
    [self removeErrorView];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    NSLog(@"%@", self.movieId);
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Movie/SearchMovies"
             params:@{@"userId": [GODUserTool isLogin] ? [GODUserTool shared].user.user_id : @"",@"name": self.b.text}
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", result);
                [self hideLoading];
                if (![result[@"resultCode"] integerValue]) {
                    [self.movies removeAllObjects];
                    for (NSDictionary *dic in result[@"data"]) {
                        FFFMovieModel *movie = [FFFMovieModel yy_modelWithJSON:dic];
                        if (movie) {
                            [self.movies addObject:movie];
                        }
                    }
                    [self.view addSubview:self.tableView];
                    [self.tableView reloadData];
                }else {
                    [self addEmptyView];
                }
            }
            failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", error.userInfo);
                [self hideLoading];
                [self addEmptyView];
            }];
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


- (void)setNaviTitle {
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 30, SCREENWIDTH - 80, 30)];
    
    container.backgroundColor = [UIColor ztw_colorWithRGB:245];
    container.layer.cornerRadius = 4;
    container.layer.masksToBounds = YES;
    self.b = [[UITextField alloc] init];
    self.b.frame = CGRectMake(0, 5, WIDTH(container), 20);
    [container addSubview:self.b];
    self.b.placeholder = @"请输入搜索内容";
    self.b.returnKeyType = UIReturnKeySearch;
    self.navigationItem.titleView = container;
    self.b.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    [self sendRequest];
    return YES;
}

@end
