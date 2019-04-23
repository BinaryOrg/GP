//
//  ZDDCommentCellNode.m
//  HAHA
//
//  Created by Maker on 2019/3/30.
//  Copyright © 2019 ZDD. All rights reserved.
//

#import "ZDDResponseCellNode.h"
#import <YYCGUtilities.h>
#import "ASButtonNode+LHExtension.h"
#import "ZDDPhotoBrowseView.h"

@interface ZDDResponseCellNode ()

@property (nonatomic, strong) ASLayoutSpec *picturesLayout;
@property (nonatomic, strong) NSMutableArray *picturesNodes;
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASNetworkImageNode *iconNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASTextNode *timeNode;
@property (nonatomic, strong) ASDisplayNode *bgvNode;

@property (nonatomic, strong) ASButtonNode *reportNode;
@property (nonatomic, strong) ASButtonNode *thumbNode;
@property (nonatomic, strong) ASButtonNode *commentNode;

@property (nonatomic, strong) GPTopicResponseModel *model;


@end

@implementation ZDDResponseCellNode

- (instancetype)initWithModel:(GPTopicResponseModel *)model {
    if (self = [super init]) {
        
        self.model = model;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addBgvNode];
        [self addNameNode];
        [self addContentNode];
        [self addTimeNode];
        [self addIconNode];
        [self addPicturesNodesWithModel:model];
        
        self.iconNode.defaultImage = [UIImage imageNamed:@"bg"];
        self.iconNode.URL = [NSURL URLWithString:model.user.avater];
        
        self.nameNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.user.user_name attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:15]).lh_color([UIColor blackColor]);
        }];
        
        self.contentNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.content attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:16]).lh_color(color(53, 64, 72, 1));
        }];
        
        self.timeNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:[self formatFromTS:model.response_date] attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Regular" size:12]).lh_color(color(137, 137, 137, 1));
        }];
        
        void(^attributes)(NSMutableDictionary *make) = ^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:12.0f]).lh_color([UIColor qmui_colorWithHexString:@"354048"]);
        };
        _thumbNode = [[ASButtonNode alloc] init];
        [_thumbNode lh_setEnlargeEdgeWithTop:10.0f right:15.0f bottom:10.0f left:15.0f];
        [_thumbNode setAttributedTitle:[NSMutableAttributedString lh_makeAttributedString:[NSString stringWithFormat:@"%ld", model.star_num] attributes:attributes] forState:UIControlStateNormal];
        [_thumbNode setImage:[UIImage imageNamed:@"disLike"] forState:UIControlStateNormal];
        [_thumbNode setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
        [_thumbNode addTarget:self action:@selector(onTouchThumbNode) forControlEvents:ASControlNodeEventTouchUpInside];
        _thumbNode.selected = model.is_star;
        
        NSString *commentCount = [NSString stringWithFormat:@"%zd", model.comment_num];
        
        _commentNode = [[ASButtonNode alloc] init];
        [_thumbNode lh_setEnlargeEdgeWithTop:10.0f right:15.0f bottom:10.0f left:15.0f];
        [_commentNode setAttributedTitle:[NSMutableAttributedString lh_makeAttributedString:commentCount attributes:attributes] forState:UIControlStateNormal];
        [_commentNode setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        
        _reportNode = [[ASButtonNode alloc] init];
        [_reportNode setImage:[UIImage imageNamed:@"fav_edit_22x22_"] forState:UIControlStateNormal];
        [_reportNode addTarget:self action:@selector(onTouchReportBtn) forControlEvents:ASControlNodeEventTouchUpInside];

        [self addSubnode:_thumbNode];
        [self addSubnode:_commentNode];
        [self addSubnode:_reportNode];

        [model addObserver:self forKeyPath:@"star_num" options:NSKeyValueObservingOptionNew context:nil];
        [model addObserver:self forKeyPath:@"comment_num" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    _thumbNode.selected =  self.model.is_star;
    void(^attributes)(NSMutableDictionary *make) = ^(NSMutableDictionary *make) {
        make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:12.0f]).lh_color([UIColor qmui_colorWithHexString:@"354048"]);
    };
    [_thumbNode setAttributedTitle:[NSMutableAttributedString lh_makeAttributedString:[NSString stringWithFormat:@"%ld", self.model.star_num] attributes:attributes] forState:UIControlStateNormal];
    
    NSString *commentCount = [NSString stringWithFormat:@"%zd", self.model.comment_num];
    
    [_commentNode setAttributedTitle:[NSMutableAttributedString lh_makeAttributedString:commentCount attributes:attributes] forState:UIControlStateNormal];
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"star_num"];
    [self.model removeObserver:self forKeyPath:@"comment_num"];
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec *iconAdnNameSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    iconAdnNameSpec.spacing = 12.0f;
    iconAdnNameSpec.alignItems = ASStackLayoutAlignItemsCenter;
    iconAdnNameSpec.children = @[self.iconNode, self.nameNode];
    
    ASStackLayoutSpec *commentSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    commentSpec.spacing = 12;
    commentSpec.alignItems = ASStackLayoutAlignItemsCenter;
    commentSpec.children = @[self.reportNode, self.commentNode, self.thumbNode];
    
    ASStackLayoutSpec *topSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    topSpec.spacing = 6;
//    topSpec.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
//    topSpec.alignItems = ASStackLayoutAlignItemsEnd;
    topSpec.justifyContent = ASStackLayoutJustifyContentStart;
    topSpec.alignItems = ASStackLayoutAlignItemsCenter;
    topSpec.children = @[iconAdnNameSpec, commentSpec];
    
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    contentSpec.spacing = 15;
    if (self.picturesNodes.count) {
        contentSpec.children = @[topSpec, self.contentNode, self.picturesLayout];
    }else {
        contentSpec.children = @[topSpec, self.contentNode];
    }
    
    ASStackLayoutSpec *timeSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    timeSpec.spacing = 20;
    timeSpec.children = @[contentSpec, self.timeNode];
    
    ASInsetLayoutSpec *bgvSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:(self.bgvEdge.top != 0)?self.bgvEdge:UIEdgeInsetsMake(-20, -20, -20, -20) child:self.bgvNode];
    ASOverlayLayoutSpec *overLay = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:timeSpec overlay:bgvSpec];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(30, 20, 40, 20) child:overLay];
}

- (void)setBgvEdge:(UIEdgeInsets)bgvEdge {
    _bgvEdge = bgvEdge;
}


- (NSString *)formatFromTS:(NSInteger)ts {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MMM dd HH:ss"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *str = [NSString stringWithFormat:@"%@",
                     [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:ts]]];
    return str;
}

- (void)addNameNode {
    self.nameNode = [ASTextNode new];
    self.nameNode.style.preferredSize = CGSizeMake(ScreenWidth - 35 - 64 - 24 - 100, 20);
    [self addSubnode:self.nameNode];
}

- (void)addContentNode {
    self.contentNode = [ASTextNode new];
    self.contentNode.style.maxWidth = ASDimensionMake(ScreenWidth - 80);
    [self addSubnode:self.contentNode];
}

- (void)addTimeNode {
    self.timeNode = [ASTextNode new];
    [self addSubnode:self.timeNode];
}

- (void)addIconNode {
    self.iconNode = [ASNetworkImageNode new];
    self.iconNode.style.preferredSize = CGSizeMake(35, 35);
    self.iconNode.cornerRadius = 17.5;
    self.iconNode.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubnode:self.iconNode];
}

- (void)addBgvNode {
    self.bgvNode = [ASDisplayNode new];
    self.bgvNode.backgroundColor = [UIColor whiteColor];
    self.bgvNode.cornerRadius = 6;
    [self addSubnode:self.bgvNode];
}

- (void)addPicturesNodesWithModel:(GPTopicResponseModel *)model {
    CGSize itemSize = [self pictureSizeWithCount:model.picture.count imageSize:CGSizeMake(ScreenWidth/3.0, ScreenWidth/3.0)];
    
    [model.picture enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ASNetworkImageNode *pictureNode = [ASNetworkImageNode new];
        pictureNode.style.preferredSize = itemSize;
        pictureNode.cornerRadius = 6;
        pictureNode.contentMode = UIViewContentModeScaleAspectFit;
        pictureNode.backgroundColor = [UIColor qmui_colorWithHexString:@"F8F8F8"];
        pictureNode.defaultImage = [self placeholderImage];
        pictureNode.contentMode = UIViewContentModeScaleAspectFill;
        pictureNode.URL = [NSURL URLWithString:obj];
        [pictureNode addTarget:self action:@selector(onTouchPictureNode:) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addSubnode:pictureNode];
        [self.picturesNodes addObject:pictureNode];
    }];
}

- (CGSize)pictureSizeWithCount:(NSInteger)count imageSize:(CGSize)imageSize {
    CGSize itemSize = CGSizeZero;
    CGFloat len1_3 = (ScreenWidth - 50.0f) / 3;
    len1_3 = CGFloatPixelRound(len1_3);
    switch (count) {
        case 1: {
            CGFloat imageW = imageSize.width;
            CGFloat imageH = imageSize.height;
            CGFloat maxWH = (ScreenWidth - 96.0f) / 3 * 2;
            CGFloat minWH = AUTO_FIT(130.0f);
            if (imageW == imageH) {
                itemSize = CGSizeMake(maxWH, maxWH);
            } else if (imageH > imageW) {
                itemSize = CGSizeMake(minWH, maxWH);
            } else {
                itemSize = CGSizeMake(maxWH, minWH);
            }
            break;
        }
        default: {
            itemSize = CGSizeMake(len1_3, len1_3);
            break;
        }
    }
    return itemSize;
}



#pragma mark - 点击事件
- (void)onTouchPictureNode:(ASNetworkImageNode *)imgNode {
    
    __block NSInteger currentIndex = 0;
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.picturesNodes.count];
    [self.picturesNodes enumerateObjectsUsingBlock:^(ASNetworkImageNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LHPhotoGroupItem *item = [[LHPhotoGroupItem alloc]init];
        YYAnimatedImageView * animatedIV = [[YYAnimatedImageView alloc] init];
        animatedIV.image = obj.image;
        item.thumbView = animatedIV;
        item.largeImageURL = obj.URL;
        [tempArr addObject:item];
        if (obj == imgNode) {
            currentIndex = idx;
        }
    }];
    
    UIView *fromView = [imgNode view];
    
    
    ZDDPhotoBrowseView *photoGroupView = [[ZDDPhotoBrowseView alloc] initWithGroupItems:tempArr.copy];
    [photoGroupView.pager removeFromSuperview];
    photoGroupView.fromItemIndex = currentIndex;
    photoGroupView.backtrack = YES;
    [photoGroupView presentFromImageView:fromView
                             toContainer:[UIApplication sharedApplication].keyWindow
                                animated:YES
                              completion:nil];
}

- (void)onTouchThumbNode {
    
    if ([GODUserTool shared].user.user_id.length == 0) {
        [MFHUDManager showError:@"请先登录"];
        return;
    }
    self.model.is_star = !self.model.is_star;
    if (self.model.is_star) {
        self.model.star_num += 1;
    }else {
        self.model.star_num -= 1;
    }
    
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;
    [MFNETWROK post:@"Star/AddOrCancel" params:@{@"targetId" : self.model.id, @"userId" : [GODUserTool shared].user.user_id} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        
    }];
}

- (void)onTouchReportBtn {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"拉黑该用户" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MFHUDManager showLoading:@"loading"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MFHUDManager showSuccess:@"拉黑成功，正在审核"];
            });
        });
    }];
    
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self showAlert];
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
//    [sheet addAction:a1];
    [sheet addAction:a2];
    [sheet addAction:a3];
    [self.closestViewController presentViewController:sheet animated:YES completion:nil];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"举报" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"填写举报内容";
    }];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (!alert.textFields[0].text.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showError:@"请填写举报内容"];
                return;
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showLoading:@"loading"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MFHUDManager showSuccess:@"举报成功，正在审核"];
                });
            });
        }
    }];
    
    
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:a1];
    [alert addAction:a3];
    [self.closestViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 懒加载

- (ASLayoutSpec *)picturesLayout {
    if (_picturesLayout) {
        return _picturesLayout;
    }
    ASLayoutSpec *layout = nil;
    switch (self.picturesNodes.count) {
        case 1:
        case 2:
        case 3: {
            layout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:[self.picturesNodes copy]];
            break;
        }
        case 4: {
            NSMutableArray *node1 = [NSMutableArray arrayWithCapacity:2];
            NSMutableArray *node2 = [NSMutableArray arrayWithCapacity:2];
            [self.picturesNodes enumerateObjectsUsingBlock:^(ASNetworkImageNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < 2) {
                    [node1 addObject:obj];
                    return ;
                }
                [node2 addObject:obj];
            }];
            NSMutableArray *tempChildren = @[].mutableCopy;
            [@[node1, node2] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ASStackLayoutSpec *imgSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:obj];
                [tempChildren addObject:imgSpec];
            }];
            
            layout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:tempChildren.copy];
            break;
        }
        case 5:
        case 6: {
            NSMutableArray *node1 = [NSMutableArray arrayWithCapacity:3];
            NSMutableArray *node2 = [NSMutableArray array];
            [self.picturesNodes enumerateObjectsUsingBlock:^(ASNetworkImageNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < 3) {
                    [node1 addObject:obj];
                    return ;
                }
                [node2 addObject:obj];
            }];
            ASStackLayoutSpec *imgSpec1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:node1];
            
            ASStackLayoutSpec *imgSpec2 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:node2];
            
            layout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[imgSpec1, imgSpec2]];
            break;
        }
        case 7:
        case 8:
        case 9: {
            NSMutableArray *node1 = [NSMutableArray arrayWithCapacity:3];
            NSMutableArray *node2 = [NSMutableArray arrayWithCapacity:3];
            NSMutableArray *node3 = [NSMutableArray array];
            [self.picturesNodes enumerateObjectsUsingBlock:^(ASNetworkImageNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < 3) {
                    [node1 addObject:obj];
                    return ;
                } else if (idx < 6) {
                    [node2 addObject:obj];
                    return;
                }
                [node3 addObject:obj];
            }];
            ASStackLayoutSpec *imgSpec1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:node1];
            
            ASStackLayoutSpec *imgSpec2 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:node2];
            
            ASStackLayoutSpec *imgSpec3 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:node3];
            
            layout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5.0f justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[imgSpec1, imgSpec2, imgSpec3]];
            break;
        }
        default:
            break;
    }
    _picturesLayout = layout;
    return layout;
}


- (NSMutableArray *)picturesNodes {
    if (_picturesNodes) {
        return _picturesNodes;
    }
    _picturesNodes = @[].mutableCopy;
    return _picturesNodes;
}
@end
