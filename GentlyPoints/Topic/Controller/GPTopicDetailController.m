//
//  GPTopicDetailController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicDetailController.h"
#import "GPCommentModel.h"

#import "GPTopickDetailCellNode.h"
#import "ZDDCommentCellNode.h"

@interface GPTopicDetailController ()

@property (nonatomic, strong) NSMutableArray <GPCommentModel *>*dataArr;


@end

@implementation GPTopicDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTableNode];
    self.showRefrehHeader = YES;
    self.showRefrehFooter = YES;
}

- (void)setModel:(GPTopicModel *)model {
    _model = model;
    [self headerRefresh];
}

- (void)headerRefresh {
    
    
}

- (void)footerRefresh {
    
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
                ZDDCommentCellNode *node = [[ZDDCommentCellNode alloc] initWithModel:self.dataArr[indexPath.row]];
                node.bgvEdge = UIEdgeInsetsMake(-20, -10, -30, -10);
                node.backgroundColor = color(237, 237, 237, 0.5);
                return node;
            }
                break;
        }
    };
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSMutableArray <GPCommentModel *>*)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
