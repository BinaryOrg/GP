//
//  ZDDCommentCellNode.m
//  HAHA
//
//  Created by Maker on 2019/3/30.
//  Copyright © 2019 ZDD. All rights reserved.
//

#import "ZDDCommentCellNode.h"
#import <YYCGUtilities.h>

@interface ZDDCommentCellNode ()

@property (nonatomic, strong) ASLayoutSpec *picturesLayout;
@property (nonatomic, strong) NSMutableArray *picturesNodes;
@property (nonatomic, strong) ASTextNode *nameNode;
@property (nonatomic, strong) ASNetworkImageNode *iconNode;
@property (nonatomic, strong) ASTextNode *contentNode;
@property (nonatomic, strong) ASTextNode *timeNode;
@property (nonatomic, strong) ASDisplayNode *bgvNode;

@end

@implementation ZDDCommentCellNode

- (instancetype)initWithModel:(GPCommentModel *)model {
    if (self = [super init]) {
        
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
            make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:13]).lh_color([UIColor blackColor]);
        }];
        
        self.contentNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.content attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:16]).lh_color(color(53, 64, 72, 1));
        }];
        
        self.timeNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:[self formatFromTS:model.response_date] attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Regular" size:12]).lh_color(color(137, 137, 137, 1));
        }];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec *iconAdnNameSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    iconAdnNameSpec.spacing = 15;
    iconAdnNameSpec.alignItems = ASStackLayoutAlignItemsCenter;
    iconAdnNameSpec.children = @[self.iconNode, self.nameNode];
    
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    contentSpec.spacing = 15;
    contentSpec.children = @[iconAdnNameSpec, self.contentNode];
    
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
    [formatter setDateFormat:@"dd MMM yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *str = [NSString stringWithFormat:@"%@",
                     [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:ts]]];
    return str;
}

- (void)addNameNode {
    self.nameNode = [ASTextNode new];
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
    self.iconNode.style.preferredSize = CGSizeMake(25, 25);
    self.iconNode.cornerRadius = 12.5;
    [self addSubnode:self.iconNode];
}

- (void)addBgvNode {
    self.bgvNode = [ASDisplayNode new];
    self.bgvNode.backgroundColor = [UIColor whiteColor];
    self.bgvNode.cornerRadius = 6;
    [self addSubnode:self.bgvNode];
}

- (void)addPicturesNodesWithModel:(GPCommentModel *)model {
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



#pragma mark - 懒点击事件
- (void)onTouchPictureNode:(ASNetworkImageNode *)imgNode {
    
    
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
