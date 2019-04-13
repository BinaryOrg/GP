//
//  GPCommentModel.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPCommentModel.h"

@implementation GPCommentModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subcomments" : [GPCommentModel class]};
}

@end
