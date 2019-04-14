//
//  FFFHT1TableViewCell.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CollectionClick)(NSInteger index);
NS_ASSUME_NONNULL_BEGIN

@interface FFFHT1TableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) YYAnimatedImageView *bgImageView1;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UILabel *contentLabel1;
@property (nonatomic, copy) CollectionClick collectionClick;
@end

NS_ASSUME_NONNULL_END
