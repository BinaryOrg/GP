//
//  GPTopicDetailController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicDetailController.h"

#import "GPCommentDetailController.h"
#import "GPPostController.h"
#import "FFFLoginViewController.h"


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
    
    if (![GODUserTool isLogin]) {
        FFFLoginViewController *vc = [FFFLoginViewController new];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    __weak typeof(self)weaSlef = self;
    GPPostController *vc = [GPPostController new];
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(NSString *text, NSArray<UIImage *> *images) {
        [weaSlef joinWithContent:text imag:images];
    };
}

- (void)joinWithContent:(NSString *)text imag:(NSArray *)images {
    [MFHUDManager showLoading:@"参与中.."];
    [MFNETWROK upload:@"Response/Creat"
               params:@{
                        @"userId": [GODUserTool shared].user.user_id,
                        @"content": text.length ? text : @"",
                        @"targetId" : self.model.id
                        }
                 name:@"pictures"
               images:images
           imageScale:0.1
            imageType:MFImageTypePNG
             progress:nil
              success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                  NSLog(@"%@", result);
                  if ([result[@"resultCode"] isEqualToString:@"0"]) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [MFHUDManager dismiss];
                          GPTopicResponseModel *model = [GPTopicResponseModel yy_modelWithJSON:result[@"response"]];
                          if (model) {
                              [self.dataArr insertObject:model atIndex:0];
                              [self.tableNode reloadData];
                          }
                      });

                  }else {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [MFHUDManager showError:@"发布失败！"];
                      });
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          [MFHUDManager dismiss];
                      });
                  }
              }
              failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                  NSLog(@"%@", error.userInfo);
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [MFHUDManager showError:@"发布失败！"];
                  });
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                      [MFHUDManager dismiss];
                  });
              }];
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
