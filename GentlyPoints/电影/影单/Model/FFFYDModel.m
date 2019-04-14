//
//  FFFYDModel.m
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYDModel.h"

@implementation FFFYDModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"movie_list" : [FFFMovieModel class]
             };
}
@end
