//
//  FFFMovieModel.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFMovieModel.h"
#import "FFFCalcHeight.h"
#import "UIFont+ZTWFont.h"

@implementation FFFMovieModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"actor_list" : [FFFActorModel class]
             };
}

- (void)setIntroduction:(NSString *)introduction {
    _introduction = introduction;
    self.content_height = [FFFCalcHeight heightWithString:introduction LabelFont:[UIFont ztw_regularFontSize:16] withLabelWidth:SCREENWIDTH - 80];
}
@end
