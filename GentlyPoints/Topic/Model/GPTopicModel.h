//
//  GPTopicModel.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTopicModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *create_date;
@property (nonatomic, strong) NSString *pv;


@end

NS_ASSUME_NONNULL_END
