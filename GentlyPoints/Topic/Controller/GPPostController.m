//
//  GPPostController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPPostController.h"
#import "HXPhotoPicker.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#define kPhotoViewMargin 12.0f

@interface GPPostController ()

//@property (nonatomic, strong) UILabel *tipsLb;
@property (nonatomic, strong) UITextView *contentTextView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation GPPostController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPhotoView];
}

- (void)addPhotoView {
    
    self.contentTextView = [[UITextView alloc] init];
    self.contentTextView.font = [UIFont systemFontOfSize:18];
    self.contentTextView.frame = CGRectMake(kPhotoViewMargin, 20, ScreenWidth - kPhotoViewMargin * 2, 150);
    self.contentTextView.placeholder = @"总觉得应该说点什么~";
    
    [self.view addSubview:self.contentTextView];
    
    self.title = @"发布动态";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 200)];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin, width - kPhotoViewMargin * 2, 0);
    photoView.outerCamera = YES;
    photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
    photoView.previewShowDeleteButton = YES;
    photoView.showAddCell = YES;
    [photoView.collectionView reloadData];
    photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    
//    [self.view addSubview:self.tipsLb];
//    [self.tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.bottom.mas_equalTo(-SafeAreaBottomHeight - 30);
//    }];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [nextButton setTitleColor:[UIColor qmui_colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [nextButton setTitle:@"发布" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(clickPostDyBtn) forControlEvents:UIControlEventTouchUpInside];
    [nextButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    
    [self.contentTextView becomeFirstResponder];
}

- (void)clickPostDyBtn {
    
    if (self.contentTextView.text.length == 0 && self.manager.afterSelectedArray.count == 0) {
        [MFHUDManager showError:@"请输入内容"];
        return;
    }
    if (self.manager.afterSelectedArray.count) {
        __weak typeof(self)weakSelf = self;
        NSMutableArray *tempArr = [NSMutableArray array];
        [self.manager.afterSelectedArray enumerateObjectsUsingBlock:^(HXPhotoModel *selectedModel, NSUInteger idx, BOOL * _Nonnull stop) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (selectedModel.asset) {
                PHImageRequestOptions*options = [[PHImageRequestOptions alloc]init];
                options.deliveryMode=PHImageRequestOptionsDeliveryModeHighQualityFormat;
                [[PHImageManager defaultManager] requestImageDataForAsset:selectedModel.asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (imageData) {
                            [tempArr addObject:[UIImage imageWithData:imageData]];
                            if (tempArr.count == strongSelf.manager.afterSelectedArray.count) {
                                [strongSelf postWithImages:tempArr];
                            }
                        }
                    });
                }];
            }else {
                if (selectedModel.previewPhoto) {
                    [tempArr addObject:selectedModel.previewPhoto];
                }else {
                    [tempArr addObject:selectedModel.thumbPhoto];
                }
                if (tempArr.count == self.manager.afterSelectedArray.count) {
                    [strongSelf postWithImages:tempArr];
                }
            }
        }];
    }else {
        [self postWithImages:@[]];
    }
   
    
    
    
}

- (void)postWithImages:(NSArray *)images {
    
    if (self.block) {
        self.block(self.contentTextView.text, images);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.openCamera = NO;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 9;
        _manager.configuration.videoMaximumSelectDuration = 15;
        _manager.configuration.videoMinimumSelectDuration = 0;
        _manager.configuration.videoMaximumDuration = 15.f;
        _manager.configuration.creationDateSort = NO;
        _manager.configuration.saveSystemAblum = YES;
        _manager.configuration.showOriginalBytes = YES;
        _manager.configuration.selectTogether = NO;
        
    }
    return _manager;
}

//- (UILabel *)tipsLb {
//    if (!_tipsLb) {
//        _tipsLb = [[UILabel alloc] init];
//        _tipsLb.font = [UIFont systemFontOfSize:15];
//        _tipsLb.textColor = GODColor(137, 137, 137);
//        _tipsLb.text = @"有趣的动态展示有趣的你~";
//    }
//    return _tipsLb;
//}

@end
