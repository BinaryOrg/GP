//
//  FFFCommonEmptyTableViewCell.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFCommonEmptyTableViewCell.h"

@implementation FFFCommonEmptyTableViewCell

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 5)];;
        bg.backgroundColor = [UIColor ztw_colorWithRGB:245];
        [self.contentView addSubview:bg];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
        l.textColor = [UIColor ztw_colorWithRGB:51];
        l.font = [UIFont ztw_regularFontSize:18];
        l.text = title;
        [self.contentView addSubview:l];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 78)];
        iv.image = [UIImage imageNamed:@"illustration_tutorial_network_error_250x156_"];
        iv.center = CGPointMake(SCREENWIDTH/2, 50 + 60);
        [self.contentView addSubview:iv];
    }
    return self;
}

@end
