//
//  FFFCommentViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFCommentViewController.h"
#import "YMHLCommentTableViewCell.h"
#import "YMHLSubcommentTableViewCell.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import "ZDDCommentModel.h"
#import <QMUIKit/QMUIKit.h>

#import "FFFYP0TableViewCell.h"
#import "FFFYP1TableViewCell.h"
#import "FFFYP2TableViewCell.h"
#import "FFFErrorFuckTableViewCell.h"

@interface FFFCommentViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<ZDDCommentModel *> *list;
@property (nonatomic, strong) UIView *refreshView;
@end

@implementation FFFCommentViewController

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH - 60, SCREENHEIGHT - STATUSBARANDNAVIGATIONBARHEIGHT - 60, 40, 40)];
        _refreshView.layer.cornerRadius = 15;
        _refreshView.layer.masksToBounds = YES;
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = _refreshView.bounds;
        [b setImage:[UIImage imageNamed:@"btn_postings"] forState:UIControlStateNormal];
        [b setImage:[UIImage imageNamed:@"btn_postings"] forState:UIControlStateHighlighted];
        [b addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
        [_refreshView addSubview:b];
        _refreshView.backgroundColor = [UIColor whiteColor];
    }
    return _refreshView;
}


- (NSMutableArray *)list {
    if (!_list) {
        _list = @[].mutableCopy;
    }
    return _list;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - STATUSBARANDNAVIGATIONBARHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendRequest];
    __weak __typeof(self)weakSelf = self;
    self.errorViewClickBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf sendRequest];
    };
}

- (void)comment {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入评论内容" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入评论内容";
    }];__weak __typeof(self)weakSelf = self;
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD show];
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [MFNETWROK post:@"http://120.78.124.36:10020/WP/Comment/Create"
                 params:@{
                          @"userId": [GODUserTool shared].user.user_id.length ? [GODUserTool shared].user.user_id : @"",
                          @"targetId": strongSelf.yp.id,
                          @"content": alert.textFields[0].text
                          }
                success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                    
                    if ([result[@"resultCode"] isEqualToString:@"0"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                        });
                        [strongSelf sendRequest];
                    }else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showErrorWithStatus:@"评论失败"];
                        });
                    }
                }
                failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showSuccessWithStatus:@"评论失败"];
                    });
                }];
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:a1];
    [alert addAction:a2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sendRequest {
    [self removeErrorView];
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Comment/ListCommentByTargetid"
             params:@{
                      @"targetId": self.yp.id,
                      @"userId": [GODUserTool shared].user.user_id.length ? [GODUserTool shared].user.user_id : @"",
                      }
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                NSLog(@"%@", result);
                if ([result[@"resultCode"] isEqualToString:@"0"]) {
                    [self.list removeAllObjects];
                    for (NSDictionary *dic in result[@"data"]) {
                        ZDDCommentModel *comment = [ZDDCommentModel yy_modelWithJSON:dic];
                        if (comment) {
                            [self.list addObject:comment];
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view addSubview:self.tableView];
                        [self.tableView reloadData];
                        [self.view addSubview:self.refreshView];
                    });
                }else {
                    [self addEmptyView];
                }
            }
            failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", error.userInfo);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                [self addEmptyView];
            }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.list.count ? self.list.count + 1 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!section) {
        return 1;
    }
    return self.list.count ? self.list[section-1].subcomments.count + 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        FFFPLModel *yp = self.yp;
        NSInteger count = yp.picture.count;
        if (!count) {
            FFFYP0TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp_cell"];
            if (!cell) {
                cell = [[FFFYP0TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp_cell"];
            }
            cell.titleLabel.text = yp.title;
            cell.contentLabel.text = yp.content;
            [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            cell.name.text = yp.user.user_name;
            [cell.contentLabel setQmui_height:yp.full_content_height];
            return cell;
        }else if (count <= 2) {
            FFFYP1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp1_cell"];
            if (!cell) {
                cell = [[FFFYP1TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp1_cell"];
            }
            [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            cell.name.text = yp.user.user_name;
            [cell.leftImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture.firstObject] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            cell.titleLabel.text = yp.title;
            cell.contentLabel.text = yp.content;
            return cell;
        }else {
            FFFYP2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yp2_cell"];
            if (!cell) {
                cell = [[FFFYP2TableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"yp2_cell"];
            }
            [cell.avatar yy_setImageWithURL:[NSURL URLWithString:yp.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            cell.name.text = yp.user.user_name;
            [cell.leftImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture.firstObject] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            [cell.centerImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture[1]] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            [cell.rightImageView yy_setImageWithURL:[NSURL URLWithString:yp.picture[2]] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
            cell.titleLabel.text = yp.title;
            cell.contentLabel.text = yp.content;
            [cell.contentLabel setQmui_height:yp.full_content_height];
            CGFloat top = MaxY(cell.contentLabel) + 10;
            [cell.leftImageView setQmui_top:top];
            [cell.centerImageView setQmui_top:top];
            [cell.rightImageView setQmui_top:top];
            return cell;
        }
    }else {
        if (self.list.count) {
            ZDDCommentModel *comment = self.list[indexPath.section-1];
            if (!indexPath.row) {
                YMHLCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment_cell"];
                if (!cell) {
                    cell = [[YMHLCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment_cell"];
                }
                
                [cell.avatar yy_setImageWithURL:[NSURL URLWithString:comment.user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
                [cell.avatarButton addTarget:self action:@selector(avatarClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.nickLabel.text = comment.user.user_name;
                cell.commentLabel.text = comment.content;
                [cell.commentLabel setQmui_height:comment.content_height];
                [cell.dateLabel setQmui_top:MaxY(cell.commentLabel)+5];
                cell.dateLabel.text = [self formatFromTS:comment.create_date];
                [cell.commentButton setQmui_top:MaxY(cell.commentLabel)+5];
                [cell.commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.starButton setQmui_top:MaxY(cell.commentLabel)+5];
                [cell.starButton addTarget:self action:@selector(starButtonClick:)
                          forControlEvents:UIControlEventTouchUpInside];
                [cell.line setQmui_top:MaxY(cell.starButton) + 20];
                if (comment.is_star) {
                    cell.starButton.tintColor = [UIColor zdd_redColor];
                }else {
                    cell.starButton.tintColor = [UIColor zdd_colorWithRed:120 green:120 blue:120];
                }
                //        cell.line.alpha = 1;
                return cell;
            }else {
                YMHLSubCommentsModel *subcomment = comment.subcomments[indexPath.row-1];
                YMHLSubcommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sub_comment_cell"];
                if (!cell) {
                    cell = [[YMHLSubcommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sub_comment_cell"];
                }
                
                [cell.avatar yy_setImageWithURL:[NSURL URLWithString:subcomment.src_user.avater] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
                [cell.avatarButton addTarget:self action:@selector(avatarClick2:) forControlEvents:UIControlEventTouchUpInside];
                cell.src_nickLabel.text = subcomment.src_user.user_name;
                cell.tar_nickLabel.text = subcomment.tar_user.user_name;
                cell.commentLabel.text = subcomment.content;
                [cell.commentLabel setQmui_height:subcomment.content_height];
                [cell.dateLabel setQmui_top:MaxY(cell.commentLabel)+5];
                cell.dateLabel.text = [self formatFromTS:subcomment.create_date];
                [cell.commentButton setQmui_top:MaxY(cell.commentLabel)+5];
                [cell.commentButton addTarget:self action:@selector(subcommentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.line setQmui_top:MaxY(cell.commentButton) + 20];
                //        if (indexPath.row == comment.subcomments.count + 1) {
                //            cell.line.alpha = 0;
                //        }else {
                //            cell.line.alpha = 1;
                //        }
                return cell;
            }
        }else {
            FFFErrorFuckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"error_cell"];
            if (!cell) {
                cell = [[FFFErrorFuckTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"error_cell"];
            }
            return cell;
        }
    }
}

- (void)avatarClick:(UIButton *)sender {
//    YMHLCommentTableViewCell *cell = (YMHLCommentTableViewCell *)sender.superview.superview.superview;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    ZDDCommentModel *comment = self.list[indexPath.section];
//    ZDDThridController *t = [ZDDThridController new];
//    t.type = 1;
//    t.user_id = comment.user.user_id;
//    [self.navigationController pushViewController:t animated:YES];
}

- (void)avatarClick2:(UIButton *)sender {
//    YMHLSubcommentTableViewCell *cell = (YMHLSubcommentTableViewCell *)sender.superview.superview.superview;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    ZDDCommentModel *comment = self.list[indexPath.section];
//    YMHLSubCommentsModel *subcomment = comment.subcomments[indexPath.row - 1];
//    ZDDThridController *t = [ZDDThridController new];
//    t.type = 1;
//    t.user_id = subcomment.src_user.user_id;
//    [self.navigationController pushViewController:t animated:YES];
    
}

- (void)starButtonClick:(UIButton *)sender {
    YMHLCommentTableViewCell *cell = (YMHLCommentTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ZDDCommentModel *comment = self.list[indexPath.section-1];
    comment.is_star = !comment.is_star;
    if (comment.is_star) {
        sender.tintColor = [UIColor zdd_redColor];
    }else {
        sender.tintColor = [UIColor zdd_colorWithRed:120 green:120 blue:120];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Star/AddOrCancel"
             params:@{
                      @"userId": [GODUserTool isLogin] ? [GODUserTool shared].user.user_id : @"",
                      @"targetId": comment.id
                      }
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", result);
            }
            failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                NSLog(@"%@", error);
            }];
}

- (void)subcommentButtonClick:(UIButton *)sender {
    YMHLSubcommentTableViewCell *cell = (YMHLSubcommentTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ZDDCommentModel *comment = self.list[indexPath.section-1];
    YMHLSubCommentsModel *subcomment = comment.subcomments[indexPath.row - 1];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入评论内容" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入评论内容";
    }];__weak __typeof(self)weakSelf = self;
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf commentTargetId:subcomment.src_user.user_id commentId:comment.id content:alert.textFields[0].text];
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:a1];
    [alert addAction:a2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)commentButtonClick:(UIButton *)sender {
    YMHLCommentTableViewCell *cell = (YMHLCommentTableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ZDDCommentModel *comment = self.list[indexPath.section-1];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入评论内容" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入评论内容";
    }];__weak __typeof(self)weakSelf = self;
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf commentTargetId:comment.user.user_id commentId:comment.id content:alert.textFields[0].text];
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:a1];
    [alert addAction:a2];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)commentTargetId:(NSString *)targetId commentId:(NSString *)parentId content:(NSString *)content {
    [SVProgressHUD show];
    [MFNETWROK post:@"http://120.78.124.36:10020/WP/Comment/CreateSubcomment"
             params:@{
                      @"parentId":parentId,
                      @"srcId": [GODUserTool shared].user.user_id.length ? [GODUserTool shared].user.user_id : @"",
                      @"tarId":targetId,
                      @"content": content
                      }
            success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                if ([result[@"resultCode"] isEqualToString:@"0"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self sendRequest];
                    });
                }else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showErrorWithStatus:@"评论失败"];
                    });
                }
            }
            failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showErrorWithStatus:@"评论失败"];
                });
            }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        NSInteger count = self.yp.picture.count;
        if (!count) {
            return self.yp.full_content_height + 100;
        }else if (count <= 2) {
            return 200;
        }
        return self.yp.full_content_height + 110 + (SCREENWIDTH - 80)/3;
    }else {
        if (!self.list.count) {
            return 100;
        }
        ZDDCommentModel *comment = self.list[indexPath.section-1];
        if (!indexPath.row) {
            return comment.content_height + 20 + 20 + 5 + 5 + 20 + 20;
        }
        YMHLSubCommentsModel *subcomment = comment.subcomments[indexPath.row - 1];
        return subcomment.content_height + 20 + 20 + 5 + 5 + 20 + 20;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 30;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
        container.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        label.text = @"评论";
        label.textColor = [UIColor ztw_colorWithRGB:51];
        label.font = [UIFont ztw_regularFontSize:15];
        [container addSubview:label];
        return container;
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (NSString *)formatFromTS:(NSInteger)ts {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy HH:mm"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *str = [NSString stringWithFormat:@"%@",
                     [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:ts]]];
    return str;
}
@end
