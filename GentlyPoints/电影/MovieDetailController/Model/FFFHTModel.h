//
//  FFFHTModel.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface FFFHTModel : NSObject
/*
 "id": "topic-cfebc7e0-5d30-11e9-bd69-97f65e927d98",
 "title": "你为什么喜欢电影？",
 "content": "一句话被说好几遍，“电影延长人的三倍生命”。所以你为什么喜欢电影？为什么喜欢这样的自处方式？ \r\n也可以提供故事啊哈～",
 "picture": "http://120.78.124.36:10020/topic/topic-cfebc7e0-5d30-11e9-bd69-97f65e927d98/timg4.jpg",
 "create_date": 1555081770,
 "response_num": 0,
 "pv": 208
 */
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger PV;//热度

@end

NS_ASSUME_NONNULL_END
