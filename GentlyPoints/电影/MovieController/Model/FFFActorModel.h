//
//  FFFActorModel.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFActorModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *avatar;
/*
 "name": "大卫·F·桑德伯格",
 "role": "导演",
 "avatar": "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1455853108.97.webp"
 */
@end

NS_ASSUME_NONNULL_END
