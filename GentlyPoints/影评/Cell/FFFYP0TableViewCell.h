//
//  FFFYP0TableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFYP0TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZTWVerticallyAlignedLabel *contentLabel;
@property (nonatomic, strong) UILabel *pvLabel;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) YYAnimatedImageView *avatar;
@property (nonatomic, strong) UILabel *name;

@end

NS_ASSUME_NONNULL_END
