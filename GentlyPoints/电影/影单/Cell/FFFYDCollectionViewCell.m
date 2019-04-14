//
//  FFFYDCollectionViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYDCollectionViewCell.h"

@implementation FFFYDCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.poster = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(5, 5,(SCREENWIDTH - 100)/3 - 10, (SCREENWIDTH - 100)/2 -10 - 20)];
        self.poster.contentMode = UIViewContentModeScaleAspectFill;
        self.poster.layer.masksToBounds = YES;
        [self.contentView addSubview:self.poster];
        self.layer.masksToBounds = YES;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.poster), MaxY(self.poster), WIDTH(self.poster), 20)];
        self.nameLabel.textColor = [UIColor ztw_colorWithRGB:51];
        self.nameLabel.font = [UIFont ztw_regularFontSize:12];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return self;
}
@end
