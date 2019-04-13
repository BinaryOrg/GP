//
//  GPTopickDetailHeaderView.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/11.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPTopickDetailCellNode.h"

@interface GPTopickDetailCellNode ()

@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *descNode;
@property (nonatomic, strong) ASTextNode *countNode;
@property (nonatomic, strong) ASNetworkImageNode *coverImgNode;
@property (nonatomic, strong) ASDisplayNode *lineNode;
@property (nonatomic, strong) ASDisplayNode *bgNode;

@end

@implementation GPTopickDetailCellNode

- (instancetype)initWithModel:(GPTopicModel *)model {
    if (self = [super init]) {
        
        self.backgroundColor = GODColor(237, 237, 237);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addBgNode];
        [self addTitleNode];
        [self addDescNode];
        [self addCoverImgNodee];
        [self addLineNode];
        [self addCountNode];
        
        NSMutableAttributedString *titleAtt = [NSMutableAttributedString lh_makeAttributedString:model.title attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Medium" size:18]);
        }];
        
        NSMutableAttributedString *pvAtt = [NSMutableAttributedString lh_makeAttributedString:[NSString stringWithFormat:@"       热度%@", model.pv] attributes:^(NSMutableDictionary *make) {
            make.lh_font([UIFont fontWithName:@"PingFangSC-Light" size:15]).lh_color([UIColor lightGrayColor]);
        }];
        
        [titleAtt appendAttributedString:pvAtt];
        
        self.titleNode.attributedText = titleAtt;
        
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
    
    
    ASInsetLayoutSpec *countInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(INFINITY, INFINITY, -10, -10) child:self.countNode];
    ASOverlayLayoutSpec *countSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:self.coverImgNode overlay:countInset];
    
    ASStackLayoutSpec *imgSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    imgSpec.children = @[countSpec, self.titleNode];
    imgSpec.spacing = 12.0f;
    
    
    ASStackLayoutSpec *titileSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    titileSpec.children = @[imgSpec, self.lineNode];
    titileSpec.spacing = 10.0f;
    
    ASStackLayoutSpec *allSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    allSpec.children = @[titileSpec, self.descNode];
    allSpec.spacing = 15.0f;
    
    ASInsetLayoutSpec *bgInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, -10, 0) child:self.bgNode];
    ASOverlayLayoutSpec *bgSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:allSpec overlay:bgInset];
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 30, 0) child:bgSpec];
}

- (void)addTitleNode {
    self.titleNode = [ASTextNode new];
    self.titleNode.textContainerInset = UIEdgeInsetsMake(0, 20, 5, 20);
    [self addSubnode:self.titleNode];
}

- (void)addDescNode {
    self.descNode = [ASTextNode new];
    self.descNode.maximumNumberOfLines = 4.0f;
    self.descNode.textContainerInset = UIEdgeInsetsMake(0, 20, 15, 20);
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
    self.coverImgNode.style.preferredSize = CGSizeMake(ScreenWidth, 220);
    self.coverImgNode.contentMode = UIViewContentModeScaleAspectFill;
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
//    _bgNode.cornerRadius = 8;
    _bgNode.shadowOpacity = 0.2f;
    _bgNode.backgroundColor =  [UIColor whiteColor];// GODColor(253, 235, 28);
    [self addSubnode:_bgNode];
}
@end
