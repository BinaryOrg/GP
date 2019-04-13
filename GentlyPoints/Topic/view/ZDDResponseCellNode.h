//
//  ZDDCommentCellNode.h
//  HAHA
//
//  Created by Maker on 2019/3/30.
//  Copyright © 2019 ZDD. All rights reserved.
//

#import "GPTopicResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDDResponseCellNode : ASCellNode

- (instancetype)initWithModel:(GPTopicResponseModel *)model;

@property (nonatomic, assign) UIEdgeInsets bgvEdge;

@end

NS_ASSUME_NONNULL_END
