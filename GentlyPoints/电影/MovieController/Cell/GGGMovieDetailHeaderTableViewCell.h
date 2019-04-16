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
@property (nonatomic, strong) YYAnimatedImageView *posterImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *regionLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *durationLabel;

@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) UIButton *pop;

@property (nonatomic, strong) UIButton *like;
@property (nonatomic, strong) UIButton *want;
@property (nonatomic, strong) UIButton *seen;
@end

NS_ASSUME_NONNULL_END
