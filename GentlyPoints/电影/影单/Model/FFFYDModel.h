//
//  FFFYDModel.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "FFFMovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FFFYDModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSArray<FFFMovieModel *> *movie_list;
@end

NS_ASSUME_NONNULL_END
