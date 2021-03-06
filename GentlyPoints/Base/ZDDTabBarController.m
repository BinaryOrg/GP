//
//  ZDDTabBarController.m
//  Template
//
//  Created by 张冬冬 on 2019/2/19.
//  Copyright © 2019 KWCP. All rights reserved.
//

#import "ZDDTabBarController.h"
#import "ZDDThemeConfiguration.h"
#import "TEMPMacro.h"

#import "ZDDNavController.h"

#import "GPTopicListController.h"
#import "GPMineController.h"


#import "FFFMovieContainerViewController.h"
#import "FFFYPContainerViewController.h"

@interface ZDDTabBarController ()
<
UITabBarControllerDelegate
>
@property (nonatomic, assign) BOOL hasCenterButton;
@end

@implementation ZDDTabBarController

- (instancetype)initWithCenterButton:(BOOL)hasCenterButton {
    _hasCenterButton = hasCenterButton;
    self = [super init];
    if (self) {
//        ZDDThemeConfiguration *theme = [ZDDThemeConfiguration defaultConfiguration];
//        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: theme.selectTabColor} forState:UIControlStateSelected];
//        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: theme.normalTabColor} forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    self.delegate = self;
    self.hasCenterButton = NO;
    if (self.hasCenterButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tabBar addSubview:addButton];
        addButton.frame = CGRectMake((SCREENWIDTH - 45)/2.0, 5, 45, HEIGHT(self.tabBar) - 20);
        UIImage *image = [[UIImage imageNamed:@"tab_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [addButton setImage:image forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.adjustsImageWhenDisabled = NO;
        addButton.adjustsImageWhenHighlighted = NO;
        ZDDThemeConfiguration *theme = [ZDDThemeConfiguration defaultConfiguration];
        addButton.backgroundColor = theme.selectTabColor;
        addButton.tintColor = theme.addButtonColor;
    }
}

- (void)addButtonClick {
    NSLog(@"%@", @"fuck");
}

- (void)setupChildViewControllers {
    
//    ZDDFirstController *one = [[ZDDFirstController alloc] init];
//    [self addChileVcWithTitle:@"笑笑" vc:one imageName:@"lauth_unSelected" selImageName:@"lauth_selected"];
//    
//    YMHLVideoFlowViewController *second = [[YMHLVideoFlowViewController alloc] init];
//    [self addChileVcWithTitle:@"视频圈" vc:second imageName:@"video_unSelected" selImageName:@"video_selected"];
//    
//    ZDDSecondController *three = [[ZDDSecondController alloc] init];
//    [self addChileVcWithTitle:@"动态" vc:three imageName:@"dynamic_unSelected" selImageName:@"dynamic_selected"];
//    
//    
    
    FFFMovieContainerViewController *movie = [FFFMovieContainerViewController new];
    [self addChileVcWithTitle:@"影音" vc:movie imageName:@"ico_tab_friend_40x40_" selImageName:@"ico_tab_friend_pressed-white_40x40_"];
    
    FFFYPContainerViewController *yd = [FFFYPContainerViewController new];
    [self addChileVcWithTitle:@"影评" vc:yd imageName:@"ico_tab_diary_40x40_" selImageName:@"ico_tab_diary_pressed_40x40_"];
    
    GPTopicListController *topic = [GPTopicListController new];
    [self addChileVcWithTitle:@"话题" vc:topic imageName:@"ico_tab_timeline_40x40_" selImageName:@"ico_tab_timeline_pressed_40x40_"];
    
    GPMineController *four = [[GPMineController alloc] init];
    [self addChileVcWithTitle:@"我的" vc:four imageName:@"ico_tab_profile_pressed-black_40x40_" selImageName:@"ico_tab_profile_pressed-white_40x40_"];

}

- (void)addChileVcWithTitle:(NSString *)title vc:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName {
    [vc.tabBarItem setTitle:title];
    if (title.length) {
        vc.title = title;
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [vc.tabBarItem setImage:image];
        [vc.tabBarItem setSelectedImage:selectedImage];
    }
    ZDDNavController *navVc = [[ZDDNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVc];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //点击发布
//    if ([tabBarController.viewControllers objectAtIndex:2] == viewController) {
//        if (self.hasCenterButton) {
//            [self addButtonClick];
//            return NO;
//        }
//        return NO;
//    }
    return YES;
}

@end
