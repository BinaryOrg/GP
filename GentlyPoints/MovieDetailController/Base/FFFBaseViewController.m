//
//  FFFBaseViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/10.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFBaseViewController.h"

@interface FFFBaseViewController ()
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIView *netErrorView;
@property (nonatomic, strong) NSMutableArray *loadings;
@property (nonatomic, strong) UIImageView *loadingImageView;
@end

@implementation FFFBaseViewController

- (NSMutableArray *)loadings {
    if (!_loadings) {
        _loadings = @[].mutableCopy;
        //list_loading_001
        for (NSInteger i = 1; i < 22; i++) {
            NSString *loading = [NSString stringWithFormat:@"list_loading_0%02ld", (long)i];
            NSLog(@"-------%@", loading);
            UIImage *image = [UIImage imageNamed:loading];
            if (image) {
                [_loadings addObject:image];
            }
        }
    }
    return _loadings;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
        _emptyView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 156)];
        imageView.image = [UIImage imageNamed:@"illustration_tutorial_network_error_250x156_"];
        imageView.center = CGPointMake(SCREENWIDTH/2, (SCREENHEIGHT-STATUSBARANDNAVIGATIONBARHEIGHT)/2);
        [_emptyView addSubview:imageView];
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = _emptyView.bounds;
        [b addTarget:self action:@selector(errorClick) forControlEvents:UIControlEventTouchUpInside];
        [_emptyView addSubview:b];
    }
    return _emptyView;
}

- (UIView *)netErrorView {
    if (!_netErrorView) {
        _netErrorView = [[UIView alloc] initWithFrame:self.view.bounds];
        _netErrorView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 156)];
        imageView.image = [UIImage imageNamed:@"illustration_tutorial_network_error_250x156_"];
        imageView.center = CGPointMake(SCREENWIDTH/2, (SCREENHEIGHT-STATUSBARANDNAVIGATIONBARHEIGHT)/2);
        [_netErrorView addSubview:imageView];
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = _netErrorView.bounds;
        [b addTarget:self action:@selector(errorClick) forControlEvents:UIControlEventTouchUpInside];
        [_netErrorView addSubview:b];
    }
    return _netErrorView;
}

- (void)errorClick {
    if (self.errorViewClickBlock) {
        self.errorViewClickBlock();
    }
}

- (void)addEmptyView {
    [self.view addSubview:self.emptyView];
}
- (void)addNetworkErrorView {
    [self.view addSubview:self.netErrorView];
}

- (void)removeErrorView {
    [self.emptyView removeFromSuperview];
    [self.netErrorView removeFromSuperview];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    self.loadingImageView.center = CGPointMake(SCREENWIDTH/2, (SCREENHEIGHT-STATUSBARANDNAVIGATIONBARHEIGHT)/2);
    self.loadingImageView.animationImages = self.loadings;
    self.loadingImageView.animationDuration = 1.;
    [self.loadingImageView startAnimating];
    [self.view addSubview:self.loadingImageView];
}

@end
