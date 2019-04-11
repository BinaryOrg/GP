//
//  FFFBaseViewController.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ErrorViewClickBlock)(void);
@interface FFFBaseViewController : UIViewController
- (void)addEmptyView;
- (void)addNetworkErrorView;
- (void)removeErrorView;

- (void)showLoading;
- (void)hideLoading;


@property (nonatomic, copy) ErrorViewClickBlock errorViewClickBlock;
@end

