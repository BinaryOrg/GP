//
//  FFFYDTableViewCell.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/12.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFYDTableViewCell.h"
#import "FFFYDCollectionViewCell.h"

@interface FFFYDTableViewCell ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FFFYDTableViewCell

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake((SCREENWIDTH - 100)/3, (SCREENWIDTH - 100)/2);
        flow.estimatedItemSize = CGSizeMake((SCREENWIDTH - 100)/3, (SCREENWIDTH - 100)/2);
        flow.minimumLineSpacing = 20;
        flow.minimumInteritemSpacing = 20;
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SCREENWIDTH, (SCREENWIDTH - 100)/2) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[FFFYDCollectionViewCell class] forCellWithReuseIdentifier:@"yd_cell"];
        
    }
    return _collectionView;
}

- (NSMutableArray *)yd {
    if (!_yd) {
        _yd = @[].mutableCopy;
    }
    return _yd;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgImageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60 + (SCREENWIDTH - 100)/2)];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.bgImageView];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *vis = [[UIVisualEffectView alloc] initWithEffect:blur];
        vis.frame = self.bgImageView.bounds;
        [self.contentView addSubview:vis];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 40, 30)];
        self.titleLabel.font = [UIFont ztw_mediumFontSize:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.yd.count <= 5 ? self.yd.count : 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FFFYDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"yd_cell" forIndexPath:indexPath];
    if (self.yd.count <= 5) {
        cell.nameLabel.text = self.yd[indexPath.row].name;
        [cell.poster yy_setImageWithURL:[NSURL URLWithString:self.yd[indexPath.row].poster] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
    }else {
        if (indexPath.row <= 4) {
            cell.nameLabel.text = self.yd[indexPath.row].name;
            [cell.poster yy_setImageWithURL:[NSURL URLWithString:self.yd[indexPath.row].poster] placeholder:[UIImage imageNamed:@""] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        }else {
            cell.nameLabel.text = @"";
            [cell.poster yy_setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"illustration_guoguo_142x163_"] options:(YYWebImageOptionProgressiveBlur|YYWebImageOptionProgressive) completion:nil];
        }
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH - 100)/3, (SCREENWIDTH - 100)/2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 20, 5, 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionClick) {
        self.collectionClick(indexPath);
    }
}

@end
