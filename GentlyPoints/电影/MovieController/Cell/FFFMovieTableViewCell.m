//
//  FFFMovieTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieTableViewCell.h"
#import "UIColor+ZTWColor.h"
#import "UIFont+ZTWFont.h"

@implementation FFFMovieTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.poster = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 100)];
        self.poster.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.poster];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.poster) + 20, 20, SCREENWIDTH - 160, 25)];
        self.nameLabel.font = [UIFont ztw_mediumFontSize:18];
        self.nameLabel.textColor = [UIColor ztw_colorWithRGB:51];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 70, 20, 50, 25)];
        self.scoreLabel.textColor = [UIColor ztw_redColor];
        self.scoreLabel.textAlignment = NSTextAlignmentRight;
        self.scoreLabel.font = [UIFont ztw_mediumFontSize:18];
        [self.contentView addSubview:self.scoreLabel];
        
        self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.nameLabel), MaxY(self.nameLabel) + 5, 200, 25)];
        self.introLabel.textColor = [UIColor ztw_grayColor];
        self.introLabel.font = [UIFont ztw_regularFontSize:15];
        self.introLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.introLabel];
        
        self.actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.nameLabel), MaxY(self.introLabel) + 5, 200, 20)];
        self.actorLabel.textColor = [UIColor ztw_colorWithRGB:153];
        self.actorLabel.font = [UIFont ztw_regularFontSize:14];
        self.actorLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.actorLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.nameLabel), MaxY(self.actorLabel) + 5, 200, 15)];
        self.dateLabel.textColor = [UIColor ztw_colorWithRGB:153];
        self.dateLabel.font = [UIFont ztw_regularFontSize:14];
        self.dateLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.dateLabel];
    }
    return self;
}

@end
