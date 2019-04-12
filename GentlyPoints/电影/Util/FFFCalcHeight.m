//
//  FFFCalcHeight.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFCalcHeight.h"

@implementation FFFCalcHeight
#pragma mark - 计算文本高度
+ (CGFloat)heightWithString:(NSString *)string LabelFont:(UIFont *)font withLabelWidth:(CGFloat)width {
    CGFloat height = 0;
    if (string.length == 0) {
        height = 0;
    } else {
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            attribute = @{NSFontAttributeName: font};
        }
        // 尺寸
        CGSize retSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                              options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                           attributes:attribute
                                              context:nil].size;
        height = retSize.height;
    }
    return height;
}
@end
