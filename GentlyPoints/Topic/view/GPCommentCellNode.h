//
//  GPResponseCellNode.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPCommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GPCommentCellNode : ASCellNode
@property (nonatomic, assign) UIEdgeInsets bgvEdge;

- (instancetype)initWithModel:(GPCommentModel *)model;
@end

NS_ASSUME_NONNULL_END
