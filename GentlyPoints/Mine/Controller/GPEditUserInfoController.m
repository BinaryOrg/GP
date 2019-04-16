//
//  GPEditUserInfoController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/14.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPEditUserInfoController.h"
#import <QMUIKit/QMUIKit.h>
#import "GPEditNameOrSingeController.h"

@interface GPEditUserInfoController ()
<
UITableViewDelegate,
UITableViewDataSource,
QMUIAlbumViewControllerDelegate,
QMUIImagePickerViewControllerDelegate
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GPEditUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改资料";
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改头像";
            break;
        case 1:
            cell.textLabel.text = @"修改名称";
            break;
        default:
            cell.textLabel.text = @"修改签名";
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self presentAlbumViewControllerWithTitle:@"请选择头像"];
    }else if (indexPath.row == 1) {
        GPEditNameOrSingeController *vc = [GPEditNameOrSingeController new];
        vc.title = @"修改名称";
        [self.navigationController pushViewController:vc animated:YES];
        __weak typeof(self)weakSelf = self;
        vc.block = ^(NSString * _Nullable text) {
            [weakSelf changeNamer:text];
        };
    }else {
        GPEditNameOrSingeController *vc = [GPEditNameOrSingeController new];
        vc.title = @"修改个性签名";
        [self.navigationController pushViewController:vc animated:YES];
        __weak typeof(self)weakSelf = self;
        vc.block = ^(NSString * _Nullable text) {
            [weakSelf chaneSigne:text];
        };
    }
}

- (void)changeNamer:(NSString *)newName {
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"User/ChangeUserName" params:@{@"userId": [GODUserTool shared].user.user_name, @"userName" : newName} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if (statusCode == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MFHUDManager showError:@"修改失败请重试"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager showError:@"修改失败请重试"];
    }];
}

- (void)chaneSigne:(NSString *)newSigne {
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"User/ChangeUserSign" params:@{@"userId": [GODUserTool shared].user.user_name, @"sign" : newSigne} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if (statusCode == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [MFHUDManager showError:@"修改失败请重试"];
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager showError:@"修改失败请重试"];
    }];
}

#pragma makr - 修改头像
- (void)presentAlbumViewControllerWithTitle:(NSString *)title {
    
    // 创建一个 QMUIAlbumViewController 实例用于呈现相簿列表
    QMUIAlbumViewController *albumViewController = [[QMUIAlbumViewController alloc] init];
    albumViewController.albumViewControllerDelegate = self;
    albumViewController.contentType = QMUIAlbumContentTypeOnlyPhoto;
    albumViewController.title = title;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:albumViewController];
    
    // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
    [albumViewController pickLastAlbumGroupDirectlyIfCan];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}

- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.maximumSelectImageCount = 1;
    imagePickerViewController.allowsMultipleSelection = NO;
    return imagePickerViewController;
}

#pragma mark - <QMUIImagePickerViewControllerDelegate>
- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset afterImagePickerPreviewViewControllerUpdate:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController {
    [imagePickerViewController dismissViewControllerAnimated:YES completion:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showLoading];
    });
    [MFNETWROK upload:@"User/ChangeUserAvatar" params:@{@"userId": [GODUserTool shared].user.user_id} name:@"pictures" images:@[imageAsset.previewImage] imageScale:0.1 imageType:MFImageTypePNG progress:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if ([result[@"resultCode"] isEqualToString:@"0"]) {
            GODUserModel *user = [GODUserModel yy_modelWithJSON:result[@"user"]];
            [GODUserTool shared].user = user;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideLoading];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showError:@"上传失败！"];
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hideLoading];
            });
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MFHUDManager showError:@"上传失败！"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideLoading];
        });
    }];
   
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

@end
