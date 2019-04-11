//
//  FFFMovieModel.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "FFFActorModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface FFFMovieModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSArray<NSString *> *type;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *release_info;
@property (nonatomic, strong) NSArray<FFFActorModel *> *actor_list;
@property (nonatomic, strong) NSArray<NSString *> *stills;
@end

/*
 {
 "resultCode": "0",
 "message": "查询成功",
 "data": [
 {
 "id": "movie-d3f579f6-5ab4-11e9-b4eb-97b2402c4246",
 "name": "雷霆沙赞！",
 "poster": "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551249211.webp",
 "region": "美国",
 "duration": "132分钟",
 "type": [
 "动作",
 "奇幻",
 "冒险"
 ],
 "release_info": "2019-04-05(美国/中国大陆)",
 "score": "6.6",
 "introduction": "每个人身体里都潜藏着一位超级英雄，只需要一点魔力便能将其释放。14岁的街头小混混比利·巴特森(亚瑟·安其饰)通过大喊“沙赞”这个词，就可以变身为成年超级英雄沙赞(扎克瑞·莱维饰)，这是一种来自于古老巫师的恩惠。如神一般的肌肉身体里，仍存有一颗孩子心，他开心地与超能力为伴。他能飞吗？他能X光透视吗？他能从手中射出闪电吗？他能不用再考试了吗？沙赞以孩子般轻率又鲁莽的方式，开始测试他的能力极限。但他需要尽快掌握这些力量，以对抗塞迪斯·希瓦纳博士控制的邪恶势力。",
 "actor_list": [
 {
 "name": "大卫·F·桑德伯格",
 "role": "导演",
 "avatar": "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1455853108.97.webp"
 },
 {
 "name": "扎克瑞·莱维",
 "role": "饰 沙赞 / 比利·巴特森 Shazam",
 "avatar": "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1392178173.13.webp"
 },
 {
 "name": "马克·斯特朗",
 "role": "饰 赛迪斯·希瓦纳博士 Dr. Thaddeus Sivana",
 "avatar": "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1457350889.15.webp"
 },
 {
 "name": "亚瑟·安其",
 "role": "饰 比利·巴特森 Billy Batson",
 "avatar": "https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1541231928.29.webp"
 },
 {
 "name": "杰克·迪伦·格雷泽",
 "role": "饰 弗莱迪·弗里曼 Freddy Freeman",
 "avatar": "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p1526985587.91.webp"
 },
 {
 "name": "杰曼·翰苏",
 "role": "饰 巫师 The Wizard",
 "avatar": "https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p10385.webp"
 }
 ],
 "stills": [
 "https://img3.doubanio.com/view/photo/sqxs/public/p2527705970.webp",
 "https://img3.doubanio.com/view/photo/sqxs/public/p2551584142.webp",
 "https://img3.doubanio.com/view/photo/sqxs/public/p2551667570.webp",
 "https://img3.doubanio.com/view/photo/sqxs/public/p2551584006.webp"
 ],
 "state": "is_playing",
 "create_date": 1554806831
 }
 ]
 }
 */


NS_ASSUME_NONNULL_END
