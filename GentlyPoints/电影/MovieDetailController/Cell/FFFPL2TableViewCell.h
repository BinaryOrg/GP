//
//  FFFPL2TableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFPL2TableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) YYAnimatedImageView *poster;
@end

NS_ASSUME_NONNULL_END
