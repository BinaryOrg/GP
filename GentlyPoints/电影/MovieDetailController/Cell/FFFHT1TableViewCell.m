//
//  FFFHT1TableViewCell.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFHT1TableViewCell.h"

@implementation FFFHT1TableViewCell

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
        
        self.bgImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(10, 10 + 60, (SCREENWIDTH - 30)/2, 100)];
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
        
        self.bgImageView1 = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.bgImageView) + 10, 10 + 60, (SCREENWIDTH - 30)/2, 100)];
        self.bgImageView1.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView1.layer.masksToBounds = YES;
        [self.contentView addSubview:self.bgImageView1];
        //        self.bgImageView1.layer.cornerRadius = 5;
        
        UIVisualEffectView *vis1 = [[UIVisualEffectView alloc] initWithEffect:blur];
        vis1.frame = self.bgImageView1.bounds;
        vis1.alpha = 0.7;
        [self.bgImageView1 addSubview:vis1];
        
        self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.bgImageView1), 0, WIDTH(self.bgImageView) - 20, 40)];
        self.titleLabel1.numberOfLines = 2;
        self.titleLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel1.font = [UIFont ztw_mediumFontSize:14];
        self.titleLabel1.textColor = [UIColor whiteColor];
        [self.bgImageView1 addSubview:self.titleLabel1];
        self.titleLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.bgImageView1), MaxY(self.titleLabel1), WIDTH(self.bgImageView1) - 20, 50)];
        self.contentLabel1.font = [UIFont ztw_mediumFontSize:13];
        self.contentLabel1.textColor = [UIColor whiteColor];
        [self.bgImageView1 addSubview:self.contentLabel1];
        self.contentLabel1.textAlignment = NSTextAlignmentRight;
        self.contentLabel1.numberOfLines = 0;
        self.contentLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = self.bgImageView.bounds;
        [self.bgImageView addSubview:b];
        self.bgImageView.userInteractionEnabled = YES;
        [b addTarget:self action:@selector(aClick) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        b1.frame = self.bgImageView1.bounds;
        [self.bgImageView1 addSubview:b1];
        self.bgImageView1.userInteractionEnabled = YES;
        [b1 addTarget:self action:@selector(a1Click) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)aClick {
    self.collectionClick(0);
}

- (void)a1Click {
    self.collectionClick(1);
}

@end
