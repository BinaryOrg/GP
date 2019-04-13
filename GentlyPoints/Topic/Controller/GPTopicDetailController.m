//
//  GPTopicDetailController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicDetailController.h"

#import "GPCommentDetailController.h"


#import "GPTopicResponseModel.h"

#import "GPTopickDetailCellNode.h"
#import "ZDDResponseCellNode.h"

@interface GPTopicDetailController ()

@property (nonatomic, strong) NSMutableArray <GPTopicResponseModel *>*dataArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIButton *joinBtn;

@end

@implementation GPTopicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableNode];
    
    [self.view addSubview:self.joinBtn];
    [self.joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableNode.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50 - SafeAreaBottomHeight);
    }];
//    self.showRefrehHeader = YES;
//    self.showRefrehFooter = YES;
}
//
- (void)setModel:(GPTopicModel *)model {
    _model = model;
    [self loadData:NO];
    self.title = model.title;
}
//
//- (void)headerRefresh {
//    self.page = 1;
//    [self loadData:NO];
//}
//
//- (void)footerRefresh {
//    [self loadData:YES];
//}

- (void)loadData:(BOOL)isAdd {
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"Response/ListResponseByTopicId" params:@{@"userId": [GODUserTool shared].user.user_id.length ? [GODUserTool shared].user.user_id : @"", @"topicId" : self.model.id} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self endHeaderRefresh];
        [self endFooterRefresh];
        if (statusCode == 200) {
            if (!isAdd) {
                [self.dataArr removeAllObjects];
            }
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:GPTopicResponseModel.class json:result[@"data"]];
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
        [self endFooterRefresh];
        [MFHUDManager showError:@"刷新失败请重试"];
    }];
}

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.model ? 1 : 0;
    }
    return self.dataArr.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ^ASCellNode *() {
        switch (indexPath.section) {
            case 0:
            {
                GPTopickDetailCellNode *node = [[GPTopickDetailCellNode alloc] initWithModel:self.model];
                return node;
            }
                break;
                
            default:
            {
                ZDDResponseCellNode *node = [[ZDDResponseCellNode alloc] initWithModel:self.dataArr[indexPath.row]];
                node.bgvEdge = UIEdgeInsetsMake(-20, -10, -30, -10);
                node.backgroundColor = color(237, 237, 237, 0.5);
                return node;
            }
                break;
        }
    };
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    GPCommentDetailController *vc = [GPCommentDetailController new];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickjoinBtn {
    
}

- (NSMutableArray <GPTopicResponseModel *>*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIButton *)joinBtn {
    if (!_joinBtn) {
        _joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _joinBtn.backgroundColor = GODColor(161, 101, 57);
        [_joinBtn setTitle:@"参与话题" forState:UIControlStateNormal];
        [_joinBtn addTarget:self action:@selector(clickjoinBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _joinBtn;
}
@end
