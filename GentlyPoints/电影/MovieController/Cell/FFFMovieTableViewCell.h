//
//  FFFMovieTableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import <YYImage/YYImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFMovieTableViewCell : UITableViewCell
@property (nonatomic, strong) YYAnimatedImageView *poster;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UILabel *actorLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end

NS_ASSUME_NONNULL_END
