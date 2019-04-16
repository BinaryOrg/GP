//
//  GPJoinedTpickController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPJoinedTpickController.h"
#import "GPTopicListCellNode.h"
#import "GPTopicDetailController.h"

@interface GPJoinedTpickController ()

@property (nonatomic, strong) NSMutableArray <GPTopicModel *>*dataArr;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GPJoinedTpickController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我参与的话题";
    [self addTableNode];
    self.showRefrehHeader = YES;
    [self headerRefresh];
}

- (void)headerRefresh {
    self.page = 1;
    [self loadData:NO];
}

- (void)loadData:(BOOL)isAdd {
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"Topic/ListAttendedTopic" params:@{@"userId" : [GODUserTool shared].user.user_id} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self endHeaderRefresh];
        if (statusCode == 200) {
            if (!isAdd) {
                [self.dataArr removeAllObjects];
            }
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:GPTopicModel.class json:result[@"data"]];
            if (tempArr.count) {
                [self.dataArr addObjectsFromArray:tempArr];
                [self.tableNode reloadData];
                self.page++;
            }
        }else {
            [MFHUDManager showError:@"刷新失败请重试"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self endHeaderRefresh];
        [MFHUDManager showError:@"刷新失败请重试"];
    }];
}


- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode *() {
        GPTopicListCellNode *node = [[GPTopicListCellNode alloc] initWithModel:self.dataArr[indexPath.row]];
        return node;
    };
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GPTopicDetailController *vc = [GPTopicDetailController new];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray <GPTopicModel *>*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
