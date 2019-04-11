//
//  UIColor+CustomColor.m
//  ZhiYun
//
//  Created by 张冬冬 on 2019/1/21.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import "UIColor+ZTWColor.h"

@implementation UIColor (ZTWColor)

+ (UIColor *)ztw_grayColor {
    return [self ztw_colorWithRed:84 green:84 blue:84];
}

+ (UIColor *)ztw_redColor {
    return [self ztw_colorWithRed:228 green:114 blue:77];
}

+ (UIColor *)ztw_yellowColor {
    return [self ztw_colorWithRed:247 green:202 blue:68];
}

+ (UIColor *)ztw_greenColor {
    return [self ztw_colorWithRed:46 green:204 blue:113];
}

+ (UIColor *)ztw_blueColor {
    return [self ztw_colorWithRed:52 green:152 blue:219];
}

+ (UIColor *)ztw_purpleColor {
    return [self ztw_colorWithRed:68 green:87 blue:169];
}

+ (UIColor *)ztw_debugColor {
    return [self ztw_colorWithRed:82 green:162 blue:158];
}

#pragma mark - init Method

+ (UIColor *)ztw_colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue {
    
    return [self ztw_colorWithRed:red green:green blue:blue alpha:1.f];
}

+ (UIColor *)ztw_colorWithRGB:(NSInteger)rgb {
    return [self ztw_colorWithRed:rgb green:rgb blue:rgb];
}

+ (UIColor *)ztw_colorWithRed:(NSUInteger)red
                       green:(NSUInteger)green
                        blue:(NSUInteger)blue
                       alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:(float)(red/255.f)
                           green:(float)(green/255.f)
                            blue:(float)(blue/255.f)
                           alpha:alpha];
}

+ (UIColor *)ztw_colorWithRGB:(NSInteger)rgb
                        alpha:(CGFloat)alpha {
    return [self ztw_colorWithRed:rgb green:rgb blue:rgb alpha:alpha];
}

+ (UIColor *)ztw_colorWithHexRGB:(NSInteger)hexRGB {
    return [UIColor ztw_colorWithRed:(hexRGB & 0xFF0000) >> 16 green:(hexRGB & 0xFF00) >> 8 blue:hexRGB & 0xFF];
}

+ (UIColor *)ztw_colorWithHexRGB:(NSInteger)hexRGB alpha:(CGFloat)alpha {
    return [UIColor ztw_colorWithRed:(hexRGB & 0xFF0000) >> 16 green:(hexRGB & 0xFF00) >> 8 blue:hexRGB & 0xFF alpha:alpha];
}

@end
