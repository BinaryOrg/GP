//
//  GGGMovieDetailViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GGGMovieDetailViewController.h"

@interface GGGMovieDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GGGMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addEmptyView];
}

@end
