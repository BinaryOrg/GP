//
//  GPTopicListController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicListController.h"
#import "GPTopicListCellNode.h"
#import "GPTopicDetailController.h"

@interface GPTopicListController ()

@property (nonatomic, strong) NSMutableArray <GPTopicModel *>*dataArr;

@end

@implementation GPTopicListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableNode];
    self.showRefrehHeader = YES;
    self.showRefrehFooter = YES;
    [self headerRefresh];
}

- (void)headerRefresh {
    
    GPTopicModel *model = [GPTopicModel new];
    model.title = @"# 如何评价王宝强在《树先生》的演技 卡死发链接法拉利是发射机按实际拉发生纠纷 #";
    model.content = @"很多人都说这是他的演技巅峰，无可挑剔，无可超越，影帝级的表演，大家也觉得他付出了很多的努力，觉得他的成功并非出于偶然";
    model.picture = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2484739555,3750702520&fm=26&gp=0.jpg";
    model.create_date = @"2019-04-11";
    model.pv = @"热度 13W";
    
    GPTopicModel *model1 = [GPTopicModel new];
    model1.title = @"# 蔡徐坤是校队的你有意见吗 #";
    model1.content = @"我叶问第一个不服";
    model1.picture = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554988665283&di=1ca566a3a7e9b6620fc7b5ada7aa4edb&imgtype=0&src=http%3A%2F%2Fi3.sinaimg.cn%2Fgm%2F2013%2F0722%2FU4511P115DT20130722103612.jpg";
    model1.create_date = @"2019-04-11";
    model1.pv = @"热度 20000W";
    
    [self.dataArr addObject:model];
    [self.dataArr addObject:model1];

    [self.tableNode reloadData];
}

- (void)footerRefresh {
    
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
