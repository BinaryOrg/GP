//
//  YMHLSubCommentsModel.m
//  HAHA
//
//  Created by ZDD on 2019/3/31.
//  Copyright © 2019 ZDD. All rights reserved.
//

#import "YMHLSubCommentsModel.h"
#import "NSString+YMHLAdditions.h"
@implementation YMHLSubCommentsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"src_user" : [GODUserModel class],
             @"tar_user" : [GODUserModel class]
             };
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.content_height = [content heightWithLabelFont:[UIFont systemFontOfSize:14] withLabelWidth:SCREENWIDTH - 100 - 40];
}
@end
