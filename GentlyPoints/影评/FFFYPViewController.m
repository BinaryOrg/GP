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
#import "FFFCommentViewController.h"

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
        if (self.isMineVCPush) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavBarHeight) style:UITableViewStylePlain];
        }else {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - NavBarHeight - SafeTabBarHeight - 45) style:UITableViewStylePlain];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
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
    NSString *url = @"http://120.78.124.36:10020/WP/FilmReview/ListRecommendFilmReview";
    if (self.isMineVCPush) {
        url = @"FilmReview/ListFilmReviewByUserId";
    };
    
    [MFNETWROK post:url
             params:@{@"userId": [GODUserTool isLogin] ? [GODUserTool shared].user.user_id : @"", @"category": self.type.length ? self.type : @""}
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
        [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.name.text = yp.user.user_name;
        [cell.contentLabel setQmui_height:yp.content_height];
        [cell.dotButton addTarget:self action:@selector(dotClick) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }else if (count <= 2) {
        FFFYP1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp1_cell"];
        if (!cell) {
            cell = [[FFFYP1TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp1_cell"];
        }
        [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.name.text = yp.user.user_name;
        [cell.leftImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture.firstObject] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.titleLabel.text = yp.title;
        cell.contentLabel.text = yp.content;
        [cell.dotButton addTarget:self action:@selector(dotClick) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }else {
        FFFYP2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp2_cell"];
        if (!cell) {
            cell = [[FFFYP2TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp2_cell"];
        }
        [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        cell.name.text = yp.user.user_name;
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
        [cell.dotButton addTarget:self action:@selector(dotClick) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFPLModel *yp = self.pls[indexPath.row];
    NSInteger count = yp.picture.count;
    if (!count) {
        return yp.content_height + 100;
    }else if (count <= 2) {
        return 200;
    }
    return yp.content_height + 110 + (SCREENWIDTH - 80)/3;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFPLModel *yp = self.pls[indexPath.row];
    FFFCommentViewController *detail = [FFFCommentViewController new];
    detail.yp = yp;
    [self.naviController pushViewController:detail animated:YES];
}


- (void)dotClick {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"拉黑该用户" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MFHUDManager showLoading:@"loading"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MFHUDManager showSuccess:@"拉黑成功，正在审核"];
            });
        });
    }];
    
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self showAlert];
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [sheet addAction:a1];
    [sheet addAction:a2];
    [sheet addAction:a3];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"举报" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"填写举报内容";
    }];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (!alert.textFields[0].text.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showError:@"请填写举报内容"];
                return;
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showLoading:@"loading"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MFHUDManager showSuccess:@"举报成功，正在审核"];
                });
            });
        }
    }];
    
    
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:a1];
    [alert addAction:a3];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}


@end
