//
//  FFFErrorFuckTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFErrorFuckTableViewCell.h"

@implementation FFFErrorFuckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.error = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 125)/2, 11, 125, 78)];
        self.error.image = [UIImage imageNamed:@"illustration_tutorial_network_error_250x156_"];
        [self.contentView addSubview:self.error];
    }
    return self;
}

@end
