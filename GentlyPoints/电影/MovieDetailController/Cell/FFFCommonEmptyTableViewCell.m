//
//  FFFCommonEmptyTableViewCell.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFCommonEmptyTableViewCell.h"

@implementation FFFCommonEmptyTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 78)];
        iv.image = [UIImage imageNamed:@"illustration_tutorial_network_error_250x156_"];
        iv.center = CGPointMake(SCREENWIDTH/2, 50 + 60);
        [self.contentView addSubview:iv];
    }
    return self;
}

@end
