//
//  GPMineController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPMineController.h"
#import "GPMineHeaderView.h"

@interface GPMineController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
/** <#class#> */
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
}

- (void)clickSetBtn {
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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
            cell.textLabel.text = @"我参与的话题";
            cell.imageView.image = [UIImage imageNamed:@"like"];
            break;
        case 1:
            cell.textLabel.text = @"我参与的话题";
            cell.imageView.image = [UIImage imageNamed:@"like"];
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
    }
    return _headerView;
}
@end
