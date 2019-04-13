//
//  GPCommentModel.h
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GPSubCommentModel;
@interface GPCommentModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *target_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger create_date;
@property (nonatomic, assign) BOOL is_star;
@property (nonatomic, strong) GODUserModel *user;
@property (nonatomic, strong) NSArray <GPSubCommentModel *>*subcomments;


@end

@interface GPSubCommentModel :NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger create_date;
@property (nonatomic, strong) GODUserModel *src_user;
@property (nonatomic, strong) GODUserModel *tar_user;
@property (nonatomic, strong) NSString *parent_id;

@end
