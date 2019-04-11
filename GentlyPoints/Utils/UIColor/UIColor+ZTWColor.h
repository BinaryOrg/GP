//
//  UIColor+CustomColor.h
//  ZhiYun
//
//  Created by 张冬冬 on 2019/1/21.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZTWColor)

+ (UIColor *)ztw_colorWithRed:(NSUInteger)red
                    green:(NSUInteger)green
                     blue:(NSUInteger)blue;

+ (UIColor *)ztw_colorWithRed:(NSUInteger)red
                        green:(NSUInteger)green
                         blue:(NSUInteger)blue
                        alpha:(CGFloat)alpha;

+ (UIColor *)ztw_colorWithRGB:(NSInteger)rgb;

+ (UIColor *)ztw_colorWithRGB:(NSInteger)rgb
                        alpha:(CGFloat)alpha;

+ (UIColor *)ztw_colorWithHexRGB:(NSInteger)hexRGB;

+ (UIColor *)ztw_colorWithHexRGB:(NSInteger)hexRGB
                           alpha:(CGFloat)alpha;

// default custom color
+ (UIColor *)ztw_grayColor;
+ (UIColor *)ztw_redColor;
+ (UIColor *)ztw_yellowColor;
+ (UIColor *)ztw_greenColor;
+ (UIColor *)ztw_blueColor;
+ (UIColor *)ztw_purpleColor;

+ (UIColor *)ztw_debugColor;

//business custon color

@end

NS_ASSUME_NONNULL_END
