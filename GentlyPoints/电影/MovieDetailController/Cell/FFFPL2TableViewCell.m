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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 23.5, 10)];
        iv.image = [UIImage imageNamed:@"ic_comment_popular_47x20_"];
        [self.contentView addSubview:iv];
        
        self.avatar  = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(iv) + 5, 10, 30, 30)];
        self.avatar.layer.cornerRadius = 15;
        self.avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatar];
        self.avatar.contentMode = UIViewContentModeScaleAspectFill;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.avatar) + 10, MinY(self.avatar), 80, 30)];
        self.nameLabel.textColor = [UIColor ztw_colorWithRGB:51];
        self.nameLabel.font = [UIFont ztw_regularFontSize:14];
        [self.contentView addSubview:self.nameLabel];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(self.avatar) + 10, SCREENWIDTH - 40, 30)];
        self.title.textColor = [UIColor ztw_colorWithRGB:51];
        self.title.font = [UIFont ztw_mediumFontSize:17];
        [self.contentView addSubview:self.title];
        self.title.lineBreakMode = NSLineBreakByTruncatingTail;
        self.content = [[UILabel alloc] initWithFrame:CGRectMake(20, MaxY(self.title) + 10, SCREENWIDTH - 100, 50)];
        self.content.textColor = [UIColor ztw_colorWithRGB:151];
        self.content.font = [UIFont ztw_regularFontSize:15];
        self.content.numberOfLines = 0;
        self.content.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.content];
        
        self.poster = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.content) + 10, MinY(self.content), 50, 50)];
        self.poster.contentMode = UIViewContentModeScaleAspectFill;
        self.poster.layer.masksToBounds = YES;
        [self.contentView addSubview:self.poster];
    }
    return self;
}

@end
