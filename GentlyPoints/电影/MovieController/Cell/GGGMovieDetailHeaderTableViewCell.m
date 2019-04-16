//
//  GGGMovieDetailHeaderTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GGGMovieDetailHeaderTableViewCell.h"
#import "UIColor+ZTWColor.h"
#import "UIFont+ZTWFont.h"

@implementation GGGMovieDetailHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ztw_colorWithRGB:245];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 300)];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.bgImageView];
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.userInteractionEnabled = YES;
        
        self.pop = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.pop setImage:[UIImage imageNamed:@"dailycard_cancel_32x32_"] forState:(UIControlStateNormal)];
        self.pop.frame = CGRectMake(10, 20, 30, 30);
        
        
//        UIView *alphaView = [[UIView alloc] initWithFrame:self.bgImageView.bounds];
//        alphaView.backgroundColor = [UIColor colorWithWhite:0. alpha:0.7];
//        [self.bgImageView addSubview:alphaView];

        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *vis = [[UIVisualEffectView alloc] initWithEffect:blur];
        vis.frame = self.bgImageView.bounds;
        [self.bgImageView addSubview:vis];
        [self.bgImageView addSubview:self.pop];
        self.posterImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 100)/2, 40, 100, 150)];
        self.posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.posterImageView];
        self.posterImageView.layer.masksToBounds = YES;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.posterImageView) + 10, SCREENWIDTH, 20)];
        self.titleLabel.textColor = [UIColor ztw_colorWithRGB:245];
        self.titleLabel.font = [UIFont ztw_mediumFontSize:15];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.titleLabel) + 5, SCREENWIDTH, 20)];
        self.typeLabel.textColor = [UIColor ztw_colorWithRGB:245];
        self.typeLabel.font = [UIFont ztw_regularFontSize:15];
        [self.contentView addSubview:self.typeLabel];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(self.typeLabel) + 5, SCREENWIDTH/2 - 20, 20)];
        self.dateLabel.textColor = [UIColor ztw_colorWithRGB:245];
        self.dateLabel.font = [UIFont ztw_regularFontSize:14];
        [self.contentView addSubview:self.dateLabel];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        
        self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH/2 + 20, MaxY(self.typeLabel) + 5, SCREENWIDTH/2 - 20, 20)];
        self.durationLabel.textColor = [UIColor ztw_colorWithRGB:245];
        self.durationLabel.font = [UIFont ztw_regularFontSize:14];
        [self.contentView addSubview:self.durationLabel];
        
        UIView *scoreView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 150)/2, MaxY(self.durationLabel) + 10, 150, 50)];
        scoreView.backgroundColor = [UIColor whiteColor];
        scoreView.layer.cornerRadius = 3;
        scoreView.layer.masksToBounds = YES;
        [self.contentView addSubview:scoreView];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:scoreView.bounds];
        iv.image = [UIImage imageNamed:@"ZHLive_qulification_topViewbg"];
        [scoreView addSubview:iv];
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, WIDTH(scoreView), 10)];
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        l.font = [UIFont ztw_lightFontSize:12];
        [scoreView addSubview:l];
        l.text = @"综合评价";
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MaxY(l), WIDTH(l), 35)];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreLabel.textColor = [UIColor whiteColor];
        self.scoreLabel.font = [UIFont ztw_mediumFontSize:22];
        [scoreView addSubview:self.scoreLabel];
        
        self.like = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.like.frame = CGRectMake((SCREENWIDTH - 180)/4, MaxY(scoreView) + 10, 60, 30);
        [self.contentView addSubview:self.like];
        self.like.layer.cornerRadius = 5;
        self.like.layer.masksToBounds = YES;
        [self.like setTitle:@"喜欢" forState:(UIControlStateNormal)];
        
        self.want = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.want.frame = CGRectMake((SCREENWIDTH - 180)*2/4 + 60, MaxY(scoreView) + 10, 60, 30);
        [self.contentView addSubview:self.want];
        self.want.layer.cornerRadius = 5;
        self.want.layer.masksToBounds = YES;
        [self.want setTitle:@"想看" forState:(UIControlStateNormal)];
        
        self.seen = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.seen.frame = CGRectMake((SCREENWIDTH - 180)*3/4 + 60*2, MaxY(scoreView) + 10, 60, 30);
        [self.contentView addSubview:self.seen];
        self.seen.layer.cornerRadius = 5;
        self.seen.layer.masksToBounds = YES;
        [self.seen setTitle:@"看过" forState:(UIControlStateNormal)];
        
    }
    return self;
}

@end
