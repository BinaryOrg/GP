//
//  FFFYP0TableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYP0TableViewCell.h"

@implementation FFFYP0TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 30)];
        self.titleLabel.font = [UIFont ztw_mediumFontSize:17];
        self.titleLabel.textColor = [UIColor ztw_colorWithRGB:51];
        [self.contentView addSubview:self.titleLabel];
        
        self.avatar = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, MaxY(self.titleLabel) + 10, 30, 30)];
        self.avatar.layer.cornerRadius = 15;
        self.avatar.layer.masksToBounds = YES;
        self.avatar.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.avatar];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.avatar) + 10, MinY(self.avatar), 100, 30)];
        self.name.textColor = [UIColor ztw_colorWithRGB:153];
        self.name.font = [UIFont ztw_regularFontSize:13];
        [self.contentView addSubview:self.name];
        
        self.contentLabel = [[ZTWVerticallyAlignedLabel alloc] initWithFrame:CGRectMake(20, MaxY(self.avatar)+10, SCREENWIDTH - 40, 0)];
        self.contentLabel.textColor = [UIColor ztw_colorWithRGB:120];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font  = [UIFont ztw_regularFontSize:14];
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.contentLabel.verticalAlignment = ZTWVerticalAlignmentTop;
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

@end
