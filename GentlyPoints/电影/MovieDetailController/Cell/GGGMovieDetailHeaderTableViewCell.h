//
//  GGGMovieDetailHeaderTableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYImage/YYAnimatedImageView.h>
NS_ASSUME_NONNULL_BEGIN

@interface GGGMovieDetailHeaderTableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *bgImageView;
@property (nonatomic, strong) YYAnimatedImageView *coverImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *regionLabel;
@property (nonatomic, strong) UILabel *durationLabel;

@end

NS_ASSUME_NONNULL_END
