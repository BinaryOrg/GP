//
//  GODUserModel.m
//  Blogger
//
//  Created by Maker on 2019/1/19.
//  Copyright © 2019 GodzzZZZ. All rights reserved.
//

#import "GODUserModel.h"

@implementation GODUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"user_name" : @[@"user_name", @"name"],
             @"user_id" : @[@"user_id", @"id"],
             @"avater" : @[@"avater", @"avatar"],
             @"create_date" : @[@"register_date", @"create_date"]
             };
}


@end
