//
//  GGGMovieDetailViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GGGMovieDetailViewController.h"
#import "GGGMovieDetailHeaderTableViewCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "FFFIntroTableViewCell.h"
#import <QMUIKit/QMUIKit.h>
#import "FFFMovieDetailActorTableViewCell.h"
#import "FFFMovieDetailStillTableViewCell.h"
#import "FFFPictureCollectionViewCell.h"

@interface GGGMovieDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) QMUIModalPresentationViewController
*picturesModalViewController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *pictures;
@end

@implementation GGGMovieDetailViewController

- (NSMutableArray *)pictures {
    if (!_pictures) {
        _pictures = @[].mutableCopy;
    }
    return _pictures;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake((SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8);
        flow.estimatedItemSize = CGSizeMake((SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8);
        flow.minimumLineSpacing = 20;
        flow.minimumInteritemSpacing = 20;
        [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66, SCREENWIDTH, 260) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册cell
        [_collectionView registerClass:[FFFPictureCollectionViewCell class] forCellWithReuseIdentifier:@"picture_cell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (QMUIModalPresentationViewController *)picturesModalViewController {
    if (!_picturesModalViewController) {
        CGFloat height = 368;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
        contentView.backgroundColor = UIColorWhite;
        contentView.layer.cornerRadius = 2;
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREENWIDTH, 1)];
        line.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [contentView addSubview:line];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, SCREENWIDTH, 25)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor ztw_colorWithRGB:51];
        titleLabel.text = @"更多照片";
        titleLabel.font = [UIFont ztw_regularFontSize:18];
        [contentView addSubview:titleLabel];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT(contentView) - 50, SCREENWIDTH, 1)];
        line2.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [contentView addSubview:line2];
        
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(0, MaxY(line2), SCREENWIDTH, 50);
        [cancel setTitle:@"关闭" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor ztw_blueColor] forState:UIControlStateNormal];
        cancel.adjustsImageWhenHighlighted = YES;
        cancel.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:cancel];
        [cancel addTarget:self action:@selector(hideEvent) forControlEvents:UIControlEventTouchUpInside];
        cancel.titleLabel.font = [UIFont ztw_regularFontSize:18];
        
        [contentView addSubview:self.collectionView];
        
        _picturesModalViewController = [[QMUIModalPresentationViewController alloc] init];
        _picturesModalViewController.contentView = contentView;
        _picturesModalViewController.layoutBlock = ^(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame) {
            contentView.frame = CGRectSetXY(contentView.frame, CGFloatGetCenter(CGRectGetWidth(containerBounds), CGRectGetWidth(contentView.frame)), CGRectGetHeight(containerBounds) - CGRectGetHeight(contentView.frame));
        };
        _picturesModalViewController.showingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished)) {
            contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
            dimmingView.alpha = 0;
            [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
                dimmingView.alpha = 1;
                contentView.frame = contentViewFrame;
            } completion:^(BOOL finished) {
                // 记住一定要在适当的时机调用completion()
                if (completion) {
                    completion(finished);
                }
            }];
        };
        _picturesModalViewController.hidingAnimation = ^(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished)) {
            [UIView animateWithDuration:.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
                dimmingView.alpha = 0.0;
                contentView.frame = CGRectSetY(contentView.frame, CGRectGetHeight(containerBounds));
            } completion:^(BOOL finished) {
                // 记住一定要在适当的时机调用completion()
                if (completion) {
                    completion(finished);
                }
            }];
        };
    }
    return _picturesModalViewController;
}

- (void)hideEvent {
    [self.picturesModalViewController hideWithAnimated:YES completion:nil];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
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
    self.fd_prefersNavigationBarHidden = YES;
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
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Movie/GetMovieDetailInfoByMovieId"
             params:@{@"movieId": self.movie.id}
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", result);
                [self hideLoading];
                if (![result[@"resultCode"] integerValue]) {
                    
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        GGGMovieDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movie_cell"];
        if (!cell) {
            cell = [[GGGMovieDetailHeaderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"movie_cell"];
        }
        FFFMovieModel *movie = self.movie;
        [cell.bgImageView yy_setImageWithURL:[NSURL URLWithString:movie.poster] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.posterImageView yy_setImageWithURL:[NSURL URLWithString:movie.poster] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        
        cell.titleLabel.text = movie.name;
        cell.dateLabel.text = [movie.release_info substringToIndex:10];
        cell.typeLabel.text = [movie.type componentsJoinedByString:@" | "];
        cell.durationLabel.text = [NSString stringWithFormat:@"片长:%@", movie.duration];
        cell.scoreLabel.text = [movie.score isEqualToString:@"暂无评分"] || [movie.score isEqualToString:@"0"] ? @"暂无": movie.score;
        return cell;
    }else if (indexPath.row == 1) {
        FFFIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"intro_cell"];
        if (!cell) {
            cell = [[FFFIntroTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"intro_cell"];
        }
        cell.introLabel.text = self.movie.introduction;
        [cell.introLabel setQmui_height:self.movie.content_height];
        return cell;
    }else if (indexPath.row == 2) {
        FFFMovieDetailActorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"actor_cell"];
        if (!cell) {
            cell = [[FFFMovieDetailActorTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"actor_cell"];
        }
        [cell.actor1 yy_setImageWithURL:[NSURL URLWithString:self.movie.actor_list.count?self.movie.actor_list.firstObject.avatar: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor2 yy_setImageWithURL:[NSURL URLWithString:self.movie.actor_list.count>=2?self.movie.actor_list[1].avatar: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor3 yy_setImageWithURL:[NSURL URLWithString:self.movie.actor_list.count>=3?self.movie.actor_list[2].avatar: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor4 yy_setImageWithURL:[NSURL URLWithString:self.movie.actor_list.count>=4?self.movie.actor_list[3].avatar: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        
        cell.aName1.text = self.movie.actor_list.count?self.movie.actor_list.firstObject.name: nil;
        cell.aName2.text = self.movie.actor_list.count>=2?self.movie.actor_list[1].name: nil;
        cell.aName3.text = self.movie.actor_list.count>=3?self.movie.actor_list[2].name: nil;
        cell.aName4.text = self.movie.actor_list.count>=4?self.movie.actor_list[3].name: nil;
        
        cell.jName1.text = self.movie.actor_list.count?self.movie.actor_list.firstObject.role: nil;
        cell.jName2.text = self.movie.actor_list.count>=2?self.movie.actor_list[1].role: nil;
        cell.jName3.text = self.movie.actor_list.count>=3?self.movie.actor_list[2].role: nil;
        cell.jName4.text = self.movie.actor_list.count>=4?self.movie.actor_list[3].role: nil;
        
        [cell.moreButton addTarget:self action:@selector(handleActorMoreEvent) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.row == 3) {
        FFFMovieDetailStillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"still_cell"];
        if (!cell) {
            cell = [[FFFMovieDetailStillTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"still_cell"];
        }
        [cell.actor1 yy_setImageWithURL:[NSURL URLWithString:self.movie.stills.count?self.movie.stills.firstObject: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor2 yy_setImageWithURL:[NSURL URLWithString:self.movie.stills.count>=2?self.movie.stills[1]: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor3 yy_setImageWithURL:[NSURL URLWithString:self.movie.stills.count>=3?self.movie.stills[2]: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.actor4 yy_setImageWithURL:[NSURL URLWithString:self.movie.stills.count>=4?self.movie.stills[3]: nil] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        [cell.moreButton addTarget:self action:@selector(handleStillMoreEvent) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        return 350;
    }else if (indexPath.row == 1) {
        return self.movie.content_height+60;
    }else if (indexPath.row == 2) {
        return (SCREENWIDTH - 100)*3/8 + 120;
    }else if (indexPath.row == 3) {
        return (SCREENWIDTH - 100)*3/8 + 100;
    }
    return 0;
}

- (void)handleActorMoreEvent {
    [self.pictures removeAllObjects];
    for (FFFActorModel *actor in self.movie.actor_list) {
        [self.pictures addObject:actor.avatar];
    }
    [self.collectionView reloadData];
    [self.picturesModalViewController showWithAnimated:YES completion:nil];
}

- (void)handleStillMoreEvent {
    [self.pictures removeAllObjects];
    self.pictures = self.movie.stills.mutableCopy;
    [self.collectionView reloadData];
    [self.picturesModalViewController showWithAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FFFPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"picture_cell" forIndexPath:indexPath];
    NSString *pic_url = self.pictures[indexPath.row];
    [self configCell:cell withUrl:pic_url];
    return cell;
}

- (void)configCell:(FFFPictureCollectionViewCell *)cell withUrl:(NSString *)url {
    [cell.poster yy_setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
