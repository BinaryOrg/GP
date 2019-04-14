//
//  FFFYDTableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFMovieModel.h"
typedef void (^CollectionClick)(NSIndexPath *indexPath);
NS_ASSUME_NONNULL_BEGIN

@interface FFFYDTableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) NSMutableArray<FFFMovieModel *> *yd;
@property (nonatomic, copy) CollectionClick collectionClick;
@end

NS_ASSUME_NONNULL_END
