//
//  UIFont+ZTWFont.m
//  ZhiYun
//
//  Created by 张冬冬 on 2019/2/27.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import "UIFont+ZTWFont.h"

@implementation UIFont (ZTWFont)

+ (UIFont *)ztw_regularFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)ztw_mediumFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)ztw_semiboldFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

+ (UIFont *)ztw_lightFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Light" size:size];
}

@end
