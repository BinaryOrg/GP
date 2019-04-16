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
    
    GODUserModel *model = [GODUserModel new];
    model.user_name = @"Maker";
    model.create_date = 1653723817;
    model.avater = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1555222909107&di=b7c55a4d0f3b20ccf59b6bf64eb96314&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180810%2Fe59af0ebf1ce443abc083a2c3e9321d2.jpeg";
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.model = model;
    self.model = model;
    
}

- (void)clickSetBtn {
    GPSettingController *vc = [GPSettingController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickEditUserInfo {
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
    if (indexPath.row == 0) {
        
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        
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
