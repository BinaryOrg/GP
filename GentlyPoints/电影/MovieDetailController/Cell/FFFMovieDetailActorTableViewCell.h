//
//  FFFMovieDetailActorTableViewCell.h
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FFFMovieDetailActorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) YYAnimatedImageView *actor1;
@property (nonatomic, strong) YYAnimatedImageView *actor2;
@property (nonatomic, strong) YYAnimatedImageView *actor3;
@property (nonatomic, strong) YYAnimatedImageView *actor4;

@property (nonatomic, strong) UILabel *aName1;
@property (nonatomic, strong) UILabel *aName2;
@property (nonatomic, strong) UILabel *aName3;
@property (nonatomic, strong) UILabel *aName4;

@property (nonatomic, strong) UILabel *jName1;
@property (nonatomic, strong) UILabel *jName2;
@property (nonatomic, strong) UILabel *jName3;
@property (nonatomic, strong) UILabel *jName4;
@end

NS_ASSUME_NONNULL_END
