//
//  FFFYDListViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYDListViewController.h"
#import "FFFYDModel.h"
#import "FFFMovieModel.h"
#import "FFFYDTableViewCell.h"
#import "FFFYDDetailViewController.h"
#import "GGGMovieDetailViewController.h"

@interface FFFYDListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *yd;
@end

@implementation FFFYDListViewController

- (NSMutableArray *)yd {
    if (!_yd) {
        _yd = @[].mutableCopy;
    }
    return _yd;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavBarHeight - SafeTabBarHeight - 45) style:UITableViewStyleGrouped];
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
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendRequest];
    __weak __typeof(self)weakSelf = self;
    self.errorViewClickBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf sendRequest];
    };
}

- (void)sendRequest {
    //影评和话题
    [self showLoading];
    [self removeErrorView];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Movie/ListRecommendFilmList"
             params:@{}
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", result);
                [self hideLoading];
                if (![result[@"resultCode"] integerValue]) {
                    for (NSDictionary *dic in result[@"data"]) {
                        FFFYDModel *yd = [FFFYDModel yy_modelWithJSON:dic];
                        if (yd) {
                            [self.yd addObject:yd];
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
    return self.yd.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFYDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yd_list_cell"];
    if (!cell) {
        cell = [[FFFYDTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yd_list_cell"];
    }
//    cell.bgImageView.image = [UIImage imageNamed:@"illustration_open_notification_210x80_"];
    FFFYDModel *yd = self.yd[indexPath.section];
    [cell.bgImageView yy_setImageWithURL:[NSURL URLWithString:yd.picture] placeholder:[UIImage imageNamed:@"illustration_open_notification_210x80_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
    cell.titleLabel.text = yd.title;
    cell.yd = [yd.movie_list copy];
    cell.countLabel.text = [NSString stringWithFormat:@"共%@部", @(yd.movie_list.count)];
    __weak __typeof(self)weakSelf = self;
    cell.collectionClick = ^(NSIndexPath *indexPath) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (yd.movie_list.count > 5 && indexPath.row == 5) {
            FFFYDDetailViewController *detail = [FFFYDDetailViewController new];
            detail.movies = [yd.movie_list copy];
            detail.ydTitle = yd.title;
            detail.headerUrl = yd.picture;
            [strongSelf.naviController pushViewController:detail animated:YES];
        }else {
            GGGMovieDetailViewController *detail = [GGGMovieDetailViewController new];
            detail.movie = yd.movie_list[indexPath.row];
            [strongSelf.naviController pushViewController:detail animated:YES];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 + (SCREENWIDTH - 100)/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.yd.count - 1) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return nil;
    }
    return [UIView new];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
