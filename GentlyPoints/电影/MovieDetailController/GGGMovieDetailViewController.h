//
//  GGGMovieDetailViewController.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFMovieModel.h"
typedef void(^LikeBlock) (void);
typedef void(^WantBlock) (void);
typedef void(^SeenBlock) (void);
NS_ASSUME_NONNULL_BEGIN

@interface GGGMovieDetailViewController : FFFBaseViewController
@property (nonatomic, strong) FFFMovieModel *movie;
@property (nonatomic, copy) LikeBlock likeBlock;
@property (nonatomic, copy) WantBlock wantBlock;
@property (nonatomic, copy) SeenBlock seenBlock;
@end

NS_ASSUME_NONNULL_END
