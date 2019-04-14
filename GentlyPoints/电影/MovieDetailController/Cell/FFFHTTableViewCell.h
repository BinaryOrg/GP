//
//  FFFHTTableViewCell.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFHTModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^CollectionClick)(NSInteger index);
@interface FFFHTTableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, copy) CollectionClick collectionClick;
@end

NS_ASSUME_NONNULL_END
