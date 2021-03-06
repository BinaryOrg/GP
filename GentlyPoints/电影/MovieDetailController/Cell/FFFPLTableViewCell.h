//
//  FFFPLTableViewCell.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFPLTableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@end

NS_ASSUME_NONNULL_END
