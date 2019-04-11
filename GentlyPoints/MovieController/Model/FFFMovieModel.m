//
//  FFFMovieModel.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieModel.h"

@implementation FFFMovieModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"actor_list" : [FFFActorModel class]
             };
}
@end
