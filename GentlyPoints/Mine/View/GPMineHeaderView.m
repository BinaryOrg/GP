//
//  GPMineHeaderView.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/13.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPMineHeaderView.h"

@interface GPMineHeaderView ()

@property (nonatomic, strong) UIImageView *bgv;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UIView *whiteIV;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UIButton *editBtn;

@end

@implementation GPMineHeaderView


- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

//点击编辑
- (void)clickEditBtn {
    
    
}

- (void)setModel:(GODUserModel *)model {
    _model = model;
    self.nameLb.text = model.user_name;
    self.timeLb.text = [self formatFromTS:model.create_date];
    [self.iconIV yy_setImageWithURL:[NSURL URLWithString:model.avater] placeholder:[UIImage imageNamed:@"cover"]];
    [self.bgv yy_setImageWithURL:[NSURL URLWithString:model.avater] placeholder:[UIImage imageNamed:@"cover"]];

}
- (NSString *)formatFromTS:(NSInteger)ts {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *str = [NSString stringWithFormat:@"%@",
                     [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:ts]]];
    return str;
}
- (void)setupUI {
    
    [self addSubview:self.bgv];
    [self.bgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    [self addSubview:self.whiteIV];
    [self.whiteIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(110);
    }];
    
    [self.whiteIV addSubview:self.iconIV];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.height.width.mas_equalTo(60);
    }];
    
    [self.whiteIV addSubview:self.nameLb];
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(self.iconIV.mas_right).mas_equalTo(10);
    }];
    
    [self.whiteIV addSubview:self.timeLb];
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLb.mas_bottom).mas_equalTo((20));
        make.left.mas_equalTo(self.iconIV.mas_right).mas_equalTo(10);
    }];
    
    [self.whiteIV addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
}

- (UIImageView *)bgv {
    if (!_bgv) {
        _bgv = [UIImageView new];
        _bgv.backgroundColor = GODColor(23, 30, 37);
        _bgv.contentMode = UIViewContentModeScaleAspectFill;
        _bgv.layer.masksToBounds = YES;
    }
    return _bgv;
}

- (UIView *)whiteIV {
    if (!_whiteIV) {
        _whiteIV = [UIView new];
        _whiteIV.backgroundColor = [UIColor whiteColor];
        _whiteIV.layer.shadowColor = [UIColor blackColor].CGColor;
        _whiteIV.layer.shadowOffset = CGSizeMake(1.0f, 1.0);
        _whiteIV.layer.cornerRadius = 8;
        _whiteIV.layer.shadowOpacity = 0.2f;
    }
    return _whiteIV;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

- (UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 30;
    }
    return _iconIV;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _nameLb.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLb;
}

- (UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
        _timeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLb;
}

-(UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitleColor:GODColor(215, 171, 112) forState:UIControlStateNormal];
        [_editBtn setShowsTouchWhenHighlighted:NO];
        [_editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(clickEditBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

@end
