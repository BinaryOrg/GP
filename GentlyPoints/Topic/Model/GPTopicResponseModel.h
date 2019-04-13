//
//  GPCommentModel.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPTopicResponseModel : NSObject


@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *target_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger response_date;
@property (nonatomic, strong) GODUserModel *user;
@property (nonatomic, strong) NSArray *picture;
@property (nonatomic, strong) NSArray<GPTopicResponseModel *> *subcomments;
@property (nonatomic, assign) CGFloat content_height;
@property (nonatomic, assign) BOOL is_star;
@property (nonatomic, assign) NSInteger star_num;
@property (nonatomic, assign) NSInteger comment_num;


@end

NS_ASSUME_NONNULL_END
