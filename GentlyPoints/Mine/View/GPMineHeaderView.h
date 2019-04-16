//
//  GPMineHeaderView.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GPMineHeaderViewDelegate <NSObject>

- (void)clickEditUserInfo;

@end

NS_ASSUME_NONNULL_BEGIN

@interface GPMineHeaderView : UIView

/** <#class#> */
@property (nonatomic, weak) id<GPMineHeaderViewDelegate> delegate;
@property (nonatomic, strong) GODUserModel *model;

@end

NS_ASSUME_NONNULL_END
