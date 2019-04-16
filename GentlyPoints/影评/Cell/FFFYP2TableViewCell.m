//
//  FFFYP2TableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYP2TableViewCell.h"

@implementation FFFYP2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 30)];
        self.titleLabel.font = [UIFont ztw_mediumFontSize:17];
        self.titleLabel.textColor = [UIColor ztw_colorWithRGB:51];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[ZTWVerticallyAlignedLabel alloc] initWithFrame:CGRectMake(20, MinY(self.titleLabel), SCREENWIDTH - 40, 0)];
        self.contentLabel.textColor = [UIColor ztw_colorWithRGB:120];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font  = [UIFont ztw_regularFontSize:14];
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.contentLabel.verticalAlignment = ZTWVerticalAlignmentTop;
        [self.contentView addSubview:self.contentLabel];
        
        self.leftImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, MaxY(self.contentLabel)+10, (SCREENWIDTH - 80)/3, (SCREENWIDTH - 80)/3)];
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.leftImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.leftImageView];
        
        self.centerImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.leftImageView)+20, MaxY(self.contentLabel)+10, (SCREENWIDTH - 80)/3, (SCREENWIDTH - 80)/3)];
        self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.centerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.centerImageView];
        
        self.rightImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(MaxX(self.centerImageView)+20, MaxY(self.contentLabel)+10, (SCREENWIDTH - 80)/3, (SCREENWIDTH - 80)/3)];
        self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.rightImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.rightImageView];
    }
    return self;
}

@end
