//
//  FFFPL2TableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFPL2TableViewCell.h"

@implementation FFFPL2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 5)];;
        bg.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [self.contentView addSubview:bg];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        l.textColor = [UIColor ztw_colorWithRGB:51];
        l.font = [UIFont ztw_regularFontSize:18];
        l.text = @"相关影评";
        [self.contentView addSubview:l];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, MaxY(l) + 10, 47, 20)];
        iv.image = [UIImage imageNamed:@"ic_comment_popular_47x20_"];
        [self.contentView addSubview:iv];
        
        self.avatar  = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, MaxY(iv) + 10, 30, 30)];
        self.avatar.layer.cornerRadius = 15;
        self.avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatar];
        self.avatar.contentMode = UIViewContentModeScaleAspectFill;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.avatar) + 10, MinY(self.avatar), 150, 30)];
        self.nameLabel.textColor = [UIColor ztw_colorWithRGB:51];
        self.nameLabel.font = [UIFont ztw_regularFontSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(self.avatar) + 10, SCREENWIDTH - 40, 30)];
        self.title.textColor = [UIColor ztw_colorWithRGB:51];
        self.title.font = [UIFont ztw_mediumFontSize:17];
        [self.contentView addSubview:self.title];
        self.title.lineBreakMode = NSLineBreakByTruncatingTail;
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(self.title) + 10, SCREENWIDTH - 130, 80)];
        self.content.textColor = [UIColor ztw_colorWithRGB:151];
        self.content.font = [UIFont ztw_regularFontSize:15];
        self.content.numberOfLines = 0;
        self.content.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.content];
        
        self.poster = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.content) + 10, MinY(self.content), 80, 80)];
        self.poster.contentMode = UIViewContentModeScaleAspectFill;
        self.poster.layer.masksToBounds = YES;
        [self.contentView addSubview:self.poster];
    }
    return self;
}

@end
