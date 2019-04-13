//
//  GPCommentModel.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicResponseModel.h"

@implementation GPTopicResponseModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subcomments" : [GPTopicResponseModel class]};
}

@end

