//
//  FFFHTTableViewCell.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFHTTableViewCell.h"

@implementation FFFHTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 5)];;
        bg.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [self.contentView addSubview:bg];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        l.textColor = [UIColor ztw_colorWithRGB:51];
        l.font = [UIFont ztw_regularFontSize:18];
        l.text = @"相关话题";
        [self.contentView addSubview:l];
        
        self.bgImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(10, 10 + MaxY(l), (SCREENWIDTH - 30)/2, 100)];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.bgImageView];
        //        self.bgImageView.layer.cornerRadius = 5;
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *vis = [[UIVisualEffectView alloc] initWithEffect:blur];
        vis.frame = self.bgImageView.bounds;
        vis.alpha = 0.7;
        [self.bgImageView addSubview:vis];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH(self.bgImageView) - 20, 40)];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.font = [UIFont ztw_mediumFontSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:self.titleLabel];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, MaxY(self.titleLabel), WIDTH(self.bgImageView) - 20, 50)];
        self.contentLabel.font = [UIFont ztw_mediumFontSize:13];
        self.contentLabel.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:self.contentLabel];
        self.contentLabel.textAlignment = NSTextAlignmentRight;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = self.bgImageView.bounds;
        [self.bgImageView addSubview:b];
        self.bgImageView.userInteractionEnabled = YES;
        [b addTarget:self action:@selector(aClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)aClick {
    self.collectionClick(0);
}

@end
