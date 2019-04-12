//
//  FFFPictureCollectionViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFPictureCollectionViewCell.h"

@implementation FFFPictureCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.poster = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0,(SCREENWIDTH - 100)/4, (SCREENWIDTH - 100)*3/8)];
        self.poster.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.poster];
        self.layer.masksToBounds = YES;
    }
    return self;
}
@end
