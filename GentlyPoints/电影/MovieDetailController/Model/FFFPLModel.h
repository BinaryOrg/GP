//
//  FFFPLModel.h
//  GentlyPoints
//
//  Created by ZDD on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "GODUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FFFPLModel : NSObject
/*
 "id": "film-review-cfebc7e0-5d30-11e9-bd69-97f65e927d98",
 "title": "在乎你",
 "content": "在乎你",
 "picture": [
 "http://120.78.124.36:10020/film-review/film-review-cfebc7e0-5d30-11e9-bd69-97f65e927d98/upload_477233f7c392b8f7af45956f90fb372b.jpg"
 ],
 "create_date": 1555079984,
 "star_num": 1,
 "comment_num": 1,
 "pv": 4,
 "is_star": true,
 "user": {
 "name": "CaryCCCCC",
 "id": "user-00e5ae20-5d2b-11e9-b049-1dc8d6e40b9b",
 "avatar": "http://120.78.124.36:10020/user/user-00e5ae20-5d2b-11e9-b049-1dc8d6e40b9b/upload_aa2b2ec54b81c52244c067024dfe36e9.jpg"
 }
 */
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSString *> *picture;
@property (nonatomic, assign) NSInteger star_num;
@property (nonatomic, assign) NSInteger comment_num;
@property (nonatomic, assign) NSInteger pv;
@property (nonatomic, assign) BOOL is_star;
@property (nonatomic, strong) GODUserModel *user;
@property (nonatomic, assign) CGFloat content_height;
@property (nonatomic, assign) CGFloat full_content_height;
@end

NS_ASSUME_NONNULL_END
