//
//  ZTWVerticallyAlignedLabel.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum ZTWVerticalAlignment {
    ZTWVerticalAlignmentTop,
    ZTWVerticalAlignmentMiddle,
    ZTWVerticalAlignmentBottom,
} ZTWVerticalAlignment;
NS_ASSUME_NONNULL_BEGIN

@interface ZTWVerticallyAlignedLabel : UILabel

@property (nonatomic, assign) ZTWVerticalAlignment verticalAlignment;
@end

NS_ASSUME_NONNULL_END
