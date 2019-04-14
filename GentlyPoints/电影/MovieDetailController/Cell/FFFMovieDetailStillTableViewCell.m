//
//  FFFMovieDetailStillTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieDetailStillTableViewCell.h"

@implementation FFFMovieDetailStillTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 5)];;
        bg.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [self.contentView addSubview:bg];
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
        l.textColor = [UIColor ztw_colorWithRGB:51];
        l.font = [UIFont ztw_regularFontSize:18];
        l.text = @"剧照信息";
        [self.contentView addSubview:l];
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreButton setTitle:@"查看更多" forState:(UIControlStateNormal)];
        [self.moreButton setTitleColor:[UIColor ztw_colorWithRGB:151] forState:(UIControlStateNormal)];
        self.moreButton.titleLabel.font = [UIFont ztw_regularFontSize:13];
        self.moreButton.frame = CGRectMake(SCREENWIDTH - 100, 25, 80, 30);
        [self.contentView addSubview:self.moreButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.actor1 = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, 20 + MaxY(l), (SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8)];
        self.actor1.contentMode = UIViewContentModeScaleAspectFill;
        self.actor1.layer.masksToBounds = YES;
        [self.contentView addSubview:self.actor1];
        
        self.actor2 = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.actor1)+20, 20 + MaxY(l), (SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8)];
        self.actor2.contentMode = UIViewContentModeScaleAspectFill;
        self.actor2.layer.masksToBounds = YES;
        [self.contentView addSubview:self.actor2];
        
        self.actor3 = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.actor2)+20, 20 + MaxY(l), (SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8)];
        self.actor3.contentMode = UIViewContentModeScaleAspectFill;
        self.actor3.layer.masksToBounds = YES;
        [self.contentView addSubview:self.actor3];
        
        self.actor4 = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.actor3)+20, 20 + MaxY(l), (SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8)];
        self.actor4.contentMode = UIViewContentModeScaleAspectFill;
        self.actor4.layer.masksToBounds = YES;
        [self.contentView addSubview:self.actor4];
        
    }
    return self;
}


@end
