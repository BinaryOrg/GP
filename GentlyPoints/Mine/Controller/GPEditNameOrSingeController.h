//
//  GPEditNameOrSingeController.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/15.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ZDDBaseViewController.h"

typedef void(^GPEditNameBlock)(NSString * _Nullable text);


NS_ASSUME_NONNULL_BEGIN

@interface GPEditNameOrSingeController : ZDDBaseViewController

/** <#class#> */
@property (nonatomic, copy) GPEditNameBlock block;

@end

NS_ASSUME_NONNULL_END
