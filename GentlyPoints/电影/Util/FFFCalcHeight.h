//
//  FFFCalcHeight.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFCalcHeight : NSObject
+ (CGFloat)heightWithString:(NSString *)string LabelFont:(UIFont *)font withLabelWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
