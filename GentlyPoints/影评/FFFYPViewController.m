//
//  FFFYPViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYPViewController.h"
#import <MFNetworkManager/MFNetworkManager.h>
#import "FFFPLModel.h"
#import "FFFYP0TableViewCell.h"
#import "FFFYP1TableViewCell.h"
#import "FFFYP2TableViewCell.h"

#import <QMUIKit/QMUIKit.h>

@interface FFFYPViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<FFFPLModel *> *pls;
@end
/*
 http://120.78.124.36:10020/WP/FilmReview/ListRecommendFilmReview
 */
@implementation FFFYPViewController

- (instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavBarHeight - SafeTabBarHeight - 45) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

- (NSMutableArray<FFFPLModel *> *)pls {
    if (!_pls) {
        _pls = @[].mutableCopy;
    }
    return _pls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self sendRequest];
    __weak __typeof(self)weakSelf = self;
    self.errorViewClickBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf sendRequest];
    };
}


- (void)sendRequest {
    [self showLoading];
    [self removeErrorView];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/FilmReview/ListRecommendFilmReview"
             params:@{@"userId": [GODUserTool isLogin] ? [GODUserTool shared].user.user_id : @"", @"category": self.type}
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", result);
                [self hideLoading];
                if (![result[@"resultCode"] integerValue]) {
                    
                    for (NSDictionary *dic in result[@"data"]) {
                        FFFPLModel *yp = [FFFPLModel yy_modelWithJSON:dic];
                        if (yp) {
                            [self.pls addObject:yp];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FFFPLModel *yp = self.pls[indexPath.row];
    NSInteger count = yp.picture.count;
    if (!count) {
        FFFYP0TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp_cell"];
        if (!cell) {
            cell = [[FFFYP0TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp_cell"];
        }
        cell.titleLabel.text = yp.title;
        cell.contentLabel.text = yp.content;
        [cell.contentLabel setQmui_height:yp.content_height];
        return cell;
    }else if (count <= 2) {
        FFFYP1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp1_cell"];
        if (!cell) {
            cell = [[FFFYP1TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp1_cell"];
        }
        [cell.leftImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture.firstObject] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.titleLabel.text = yp.title;
        cell.contentLabel.text = yp.content;
        return cell;
    }else {
        FFFYP2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp2_cell"];
        if (!cell) {
            cell = [[FFFYP2TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp2_cell"];
        }
        [cell.leftImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture.firstObject] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.centerImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture[1]] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.rightImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture[2]] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.titleLabel.text = yp.title;
        cell.contentLabel.text = yp.content;
        [cell.contentLabel setQmui_height:yp.content_height];
        CGFloat top = MaxY(cell.contentLabel) + 10;
        [cell.leftImageView setQmui_top:top];
        [cell.centerImageView setQmui_top:top];
        [cell.rightImageView setQmui_top:top];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFPLModel *yp = self.pls[indexPath.row];
    NSInteger count = yp.picture.count;
    if (!count) {
        return yp.content_height + 60;
    }else if (count <= 2) {
        return 160;
    }
    return yp.content_height + 70 + (SCREENWIDTH - 80)/3;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    FFFMovieModel *movie = self.movies[indexPath.section];
//    GGGMovieDetailViewController *detail = [GGGMovieDetailViewController new];
//    detail.movie = movie;
//    [self.naviController pushViewController:detail animated:YES];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}


@end
