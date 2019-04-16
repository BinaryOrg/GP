//
//  GPMineController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPMineController.h"
#import "GPMineHeaderView.h"
#import "GPEditUserInfoController.h"
#import "GPSettingController.h"
#import "FFFLoginViewController.h"
#import "GPJoinedTpickController.h"
#import "FFFYDListViewController.h"
#import "FFFYPViewController.h"

@interface GPMineController ()
<
UITableViewDelegate,
UITableViewDataSource,
GPMineHeaderViewDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GODUserModel *model;
@property (nonatomic, strong) GPMineHeaderView *headerView;
@end

@implementation GPMineController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
    [setBtn setShowsTouchWhenHighlighted:NO];
    [setBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(clickSetBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setBtn];
    
    self.tableView.tableHeaderView = self.headerView;
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![GODUserTool isLogin]) {
        self.headerView.isLoged = NO;
        return;
    };
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"User/GetUserInfo" params:@{@"userId": [GODUserTool shared].user.user_id} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if (statusCode == 200) {
            GODUserModel *model = [GODUserModel yy_modelWithJSON:result[@"user"]];
            self.headerView.model = model;
            self.model = model;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
    }];
}

- (void)jumpToLog {
    FFFLoginViewController *vc = [FFFLoginViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickSetBtn {
    GPSettingController *vc = [GPSettingController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickEditUserInfo {
    if (![GODUserTool isLogin]) {
        [self jumpToLog];
        return;
    }
    GPEditUserInfoController *vc = [GPEditUserInfoController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            if ([self.model.user_id isEqualToString:[GODUserTool shared].user.user_id]) {
                cell.textLabel.text = @"我参与的话题";
            }else {
                cell.textLabel.text = @"Ta参与的话题";
            }
            cell.imageView.image = [UIImage imageNamed:@"mine_topic"];
            break;
        case 1:
            if ([self.model.user_id isEqualToString:[GODUserTool shared].user.user_id]) {
                cell.textLabel.text = @"我的影单";
            }else {
                cell.textLabel.text = @"Ta的影单";
            }
            cell.imageView.image = [UIImage imageNamed:@"mine_list"];
            break;
        default:
            if ([self.model.user_id isEqualToString:[GODUserTool shared].user.user_id]) {
                cell.textLabel.text = @"我发布的影评";
            }else {
                cell.textLabel.text = @"Ta发布的影评";
            }
            cell.imageView.image = [UIImage imageNamed:@"mine_point"];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![GODUserTool isLogin]) {
        [self jumpToLog];
        return;
    }
    
    if (indexPath.row == 0) {
        GPJoinedTpickController *vc = [GPJoinedTpickController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        
    }else if (indexPath.row == 2) {
        FFFYPViewController *vc = [[FFFYPViewController alloc] init];
        vc.isMineVCPush = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (GPMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GPMineHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, ScreenWidth, 250);
        _headerView.delegate = self;
    }
    return _headerView;
}
@end
