//
//  FFFIntroTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFIntroTableViewCell.h"

@implementation FFFIntroTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        l.textColor = [UIColor ztw_colorWithRGB:51];
        l.font = [UIFont ztw_regularFontSize:18];
        l.text = @"影片简介";
        [self.contentView addSubview:l];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10 + MaxY(l), SCREENWIDTH - 80, 0)];
        self.introLabel.textColor = [UIColor ztw_colorWithRGB:130];
        self.introLabel.font = [UIFont ztw_regularFontSize:16];
        [self.contentView addSubview:self.introLabel];
        self.introLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.introLabel.numberOfLines = 0;
    }
    return self;
}

@end
