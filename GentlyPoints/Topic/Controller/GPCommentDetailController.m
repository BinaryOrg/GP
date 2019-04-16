//
//  GPCommentDetailController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPCommentDetailController.h"
#import "GPCommentModel.h"
#import "GPCommentCellNode.h"
#import "ZDDResponseCellNode.h"
#import "ZDDInputView.h"

@interface GPCommentDetailController ()
@property (nonatomic, strong) NSMutableArray <GPCommentModel *>*dataArr;
@property (nonatomic, strong) UIButton *writeBtn;
@property (nonatomic, strong) ZDDInputView *inputView;

@end

@implementation GPCommentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"参与详情";
    [self addTableNode];
    [self.view addSubview:self.writeBtn];
    [self.writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.right.mas_equalTo(-20.0f);
        make.bottom.mas_equalTo(-(SafeAreaBottomHeight + 60.0f));
    }];

}

- (void)setModel:(GPTopicResponseModel *)model {
    _model = model;
    [self loadData:NO];
}

- (void)loadData:(BOOL)isAdd {
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"Comment/ListCommentByTargetid" params:@{@"targetId" : self.model.id} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [self endHeaderRefresh];
        [self endFooterRefresh];
        if (statusCode == 200) {
            if (!isAdd) {
                [self.dataArr removeAllObjects];
            }
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:GPCommentModel.class json:result[@"data"]];
            if (tempArr.count) {
                [self.dataArr addObjectsFromArray:tempArr];
                [self.tableNode reloadData];
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
                ZDDResponseCellNode *node = [[ZDDResponseCellNode alloc] initWithModel:self.model];
                return node;
            }
                break;
                
            default:
            {
                GPCommentCellNode *node = [[GPCommentCellNode alloc] initWithModel:self.dataArr[indexPath.row]];
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
}


- (void)clickwriteBtn {
    [self.inputView show];
    __weak typeof(self)weakSelf = self;
    self.inputView.inputViewBlock = ^{
        [weakSelf addComment];
    };
}

- (void)addComment {
    if (self.inputView.textView.text.length == 0) {
        return;
    }
    [MFHUDManager showLoading:@"评论一下..."];
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"Comment/Create" params:@{@"userId" : [GODUserTool shared].user.user_id.length ? [GODUserTool shared].user.user_id : @"", @"targetId" : self.model.id, @"content" : self.inputView.textView.text} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        if (statusCode == 200) {
            GPCommentModel *addModel = [GPCommentModel yy_modelWithJSON:result[@"comment"]];
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.dataArr];
            [tempArr insertObject:addModel atIndex:0];
            self.dataArr = tempArr.copy;
            self.model.comment_num += 1;
            [self.tableNode reloadData];
        }else {
            [MFHUDManager showError:@"评论失败请重试"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager dismiss];
        [MFHUDManager showError:@"评论失败请重试"];
    }];
}

- (NSMutableArray <GPCommentModel *>*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

-(UIButton *)writeBtn {
    if (!_writeBtn) {
        _writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeBtn.backgroundColor = [UIColor whiteColor];
        _writeBtn.layer.cornerRadius = 30;
        _writeBtn.layer.shadowColor = [UIColor qmui_colorWithHexString:@"433C33"].CGColor;
        _writeBtn.layer.shadowOffset = CGSizeMake(.0f, 1.0f);
        _writeBtn.layer.shadowOpacity = .12f;
        _writeBtn.layer.shadowRadius = 4.0f;
        [_writeBtn setImage:[UIImage imageNamed:@"btn_postings"] forState:UIControlStateNormal];
        [_writeBtn addTarget:self action:@selector(clickwriteBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _writeBtn;
}

- (ZDDInputView *)inputView {
    if (!_inputView) {
        _inputView = [[ZDDInputView alloc] init];
    }
    return _inputView;
}
@end
