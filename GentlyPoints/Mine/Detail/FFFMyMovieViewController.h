//
//  FFFMyMovieViewController.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFBaseViewController.h"
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFMyMovieViewController : FFFBaseViewController
<
JXCategoryListContentViewDelegate
>
@property (nonatomic, strong) UINavigationController *naviController;
- (instancetype)initWithType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
