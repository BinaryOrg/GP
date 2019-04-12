//
//  FFFYDDetailViewController.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFBaseViewController.h"
#import "FFFMovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFFYDDetailViewController : FFFBaseViewController
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *headerUrl;
@property (nonatomic, strong) NSMutableArray<FFFMovieModel *> *movies;
@end

NS_ASSUME_NONNULL_END
