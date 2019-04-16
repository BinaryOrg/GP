//
//  GPPostController.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^GPPostBlock)(NSString * _Nullable text, NSArray <UIImage *>* _Nullable images);


NS_ASSUME_NONNULL_BEGIN

@interface GPPostController : UIViewController

@property (nonatomic, copy) GPPostBlock block;

@end

NS_ASSUME_NONNULL_END
