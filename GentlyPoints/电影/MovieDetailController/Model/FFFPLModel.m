//
//  FFFPLModel.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFPLModel.h"
#import "NSString+YMHLAdditions.h"
@implementation FFFPLModel
- (void)setContent:(NSString *)content {
    _content = content;
    CGFloat height = [content heightWithLabelFont:[UIFont ztw_regularFontSize:14] withLabelWidth:SCREENWIDTH - 40];
    self.content_height = height > 80 ? 80 : height;
    self.full_content_height = height;
    
    CGFloat h1 = [content heightWithLabelFont:[UIFont ztw_regularFontSize:15] withLabelWidth:SCREENWIDTH - 40];
    self.c1_height = h1 > 80 ? 80 : h1;
    CGFloat h2 = [content heightWithLabelFont:[UIFont ztw_regularFontSize:15] withLabelWidth:SCREENWIDTH - 110];
    self.c2_height = h2 > 80 ? 80 : h2;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"user": [GODUserModel class]
             };
}
@end
