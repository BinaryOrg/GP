//
//  UIFont+ZTWFont.h
//  ZhiYun
//
//  Created by 张冬冬 on 2019/2/27.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZTWFont)
+ (UIFont *)ztw_regularFontSize:(CGFloat)size;
+ (UIFont *)ztw_mediumFontSize:(CGFloat)size;
+ (UIFont *)ztw_semiboldFontSize:(CGFloat)size;
+ (UIFont *)ztw_lightFontSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
