//
//  FFFMovieDetailActorTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieDetailActorTableViewCell.h"

@implementation FFFMovieDetailActorTableViewCell

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
        l.text = @"影人信息";
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
        
        self.aName1 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor1), MaxY(self.actor1)+5, WIDTH(self.actor1), 15)];
        self.aName1.textAlignment = NSTextAlignmentCenter;
        self.aName1.font = [UIFont ztw_regularFontSize:12];
        self.aName1.textColor = [UIColor ztw_colorWithRGB:80];
        self.aName1.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.aName1];
        
        self.aName2 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor2), MaxY(self.actor2)+5, WIDTH(self.actor2), 15)];
        self.aName2.textAlignment = NSTextAlignmentCenter;
        self.aName2.font = [UIFont ztw_regularFontSize:12];
        self.aName2.textColor = [UIColor ztw_colorWithRGB:80];
        self.aName2.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.aName2];
        
        self.aName3 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor3), MaxY(self.actor3)+5, WIDTH(self.actor3), 15)];
        self.aName3.textAlignment = NSTextAlignmentCenter;
        self.aName3.font = [UIFont ztw_regularFontSize:12];
        self.aName3.textColor = [UIColor ztw_colorWithRGB:80];
        self.aName3.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.aName3];
        
        self.aName4 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor4), MaxY(self.actor4)+5, WIDTH(self.actor4), 15)];
        self.aName4.textAlignment = NSTextAlignmentCenter;
        self.aName4.font = [UIFont ztw_regularFontSize:12];
        self.aName4.textColor = [UIColor ztw_colorWithRGB:80];
        self.aName4.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.aName4];
        
        
        /*-------------------------------------*/
        
        self.jName1 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor1), MaxY(self.aName1)+5, WIDTH(self.actor1), 15)];
        self.jName1.textAlignment = NSTextAlignmentCenter;
        self.jName1.font = [UIFont ztw_regularFontSize:12];
        self.jName1.textColor = [UIColor ztw_colorWithRGB:80];
        self.jName1.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.jName1];
        
        self.jName2 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor2), MaxY(self.aName2)+5, WIDTH(self.actor2), 15)];
        self.jName2.textAlignment = NSTextAlignmentCenter;
        self.jName2.font = [UIFont ztw_regularFontSize:12];
        self.jName2.textColor = [UIColor ztw_colorWithRGB:80];
        self.jName2.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.jName2];
        
        self.jName3 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor3), MaxY(self.aName3)+5, WIDTH(self.actor3), 15)];
        self.jName3.textAlignment = NSTextAlignmentCenter;
        self.jName3.font = [UIFont ztw_regularFontSize:12];
        self.jName3.textColor = [UIColor ztw_colorWithRGB:80];
        self.jName3.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.jName3];
        
        self.jName4 = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.actor4), MaxY(self.aName4)+5, WIDTH(self.actor4), 15)];
        self.jName4.textAlignment = NSTextAlignmentCenter;
        self.jName4.font = [UIFont ztw_regularFontSize:12];
        self.jName4.textColor = [UIColor ztw_colorWithRGB:80];
        self.jName4.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.contentView addSubview:self.jName4];
    }
    return self;
}

@end
