//
//  GPTopicListCellNode.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopicListCellNode.h"

@interface GPTopicListCellNode ()

@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *descNode;
@property (nonatomic, strong) ASTextNode *countNode;
@property (nonatomic, strong) ASNetworkImageNode *coverImgNode;
@property (nonatomic, strong) ASDisplayNode *lineNode;
@property (nonatomic, strong) ASDisplayNode *bgNode;

@end

@implementation GPTopicListCellNode

- (instancetype)initWithModel:(GPTopicModel *)model {
    if (self = [super init]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addBgNode];
        [self addTitleNode];
        [self addDescNode];
        [self addCoverImgNodee];
        [self addLineNode];
        [self addCountNode];
        self.titleNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.title attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:18]);
        }];
        
        self.descNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.content attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:15]);
        }];
        
        self.countNode.attributedText = [NSMutableAttributedString lh_makeAttributedString:model.pv attributes:^(NSMutableDictionary *make) {
            NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
            style.alignment = NSTextAlignmentCenter;
            make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:12]).lh_paraStyle(style).lh_color([UIColor whiteColor]);
        }];
        
        self.coverImgNode.URL = [NSURL URLWithString:model.picture];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *titileSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    titileSpec.children = @[self.titleNode, self.lineNode];
    titileSpec.spacing = 12.0f;
    
    
    ASInsetLayoutSpec *countInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, 0, 0, 0) child:self.countNode];
    ASOverlayLayoutSpec *countSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:self.coverImgNode overlay:countInset];
    ASStackLayoutSpec *imgSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    imgSpec.children = @[countSpec, self.descNode];
    imgSpec.spacing = 12.0f;
    
    ASStackLayoutSpec *allSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    allSpec.children = @[titileSpec, imgSpec];
    allSpec.spacing = 15.0f;
    
    ASInsetLayoutSpec *bgInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(-10, -10, -10, -10) child:self.bgNode];
    ASOverlayLayoutSpec *bgSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:allSpec overlay:bgInset];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(20, 20, 20, 20) child:bgSpec];
}

- (void)addTitleNode {
    self.titleNode = [ASTextNode new];
    [self addSubnode:self.titleNode];
}

- (void)addDescNode {
    self.descNode = [ASTextNode new];
    self.descNode.maximumNumberOfLines = 4.0f;
    self.descNode.style.maxWidth = ASDimensionMake(ScreenWidth - 155.0f);
    [self addSubnode:self.descNode];
}

- (void)addCountNode {
    self.countNode = [ASTextNode new];
    self.countNode.maximumNumberOfLines = 1.0f;
    self.countNode.style.preferredSize = CGSizeMake(100, 20);
    [self addSubnode:self.countNode];
}

- (void)addCoverImgNodee {
    self.coverImgNode = [ASNetworkImageNode new];
    self.coverImgNode.style.preferredSize = CGSizeMake(100, 100);
    self.coverImgNode.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImgNode.cornerRadius = 4.0f;
    [self addSubnode:self.coverImgNode];
}

- (void)addLineNode {
    _lineNode = [ASDisplayNode new];
    _lineNode.backgroundColor = GODColor(238, 238, 238);
    [_lineNode setLayerBacked:YES];
    _lineNode.style.preferredSize = CGSizeMake(ScreenWidth - 40, 1);
    [self addSubnode:_lineNode];
}

- (void)addBgNode {
    _bgNode = [ASDisplayNode new];
    [_bgNode setLayerBacked:YES];
    _bgNode.shadowColor = [UIColor blackColor].CGColor;
    _bgNode.shadowOffset = CGSizeMake(1.0f, 1.0);
    _bgNode.cornerRadius = 8;
    _bgNode.shadowOpacity = 0.2f;
    _bgNode.backgroundColor =  [UIColor whiteColor];// GODColor(253, 235, 28);
    [self addSubnode:_bgNode];
}

@end
