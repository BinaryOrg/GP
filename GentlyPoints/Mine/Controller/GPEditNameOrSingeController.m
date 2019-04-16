//
//  GPEditNameOrSingeController.m
//  GentlyPoints
//
//  Created by Maker on 2019/4/15.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GPEditNameOrSingeController.h"

@interface GPEditNameOrSingeController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation GPEditNameOrSingeController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [nextButton setTitleColor:[UIColor qmui_colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [nextButton setTitle:@"发布" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(clickPostDyBtn) forControlEvents:UIControlEventTouchUpInside];
    [nextButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    
    
    self.textView = [UITextView new];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(200);
    }];
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.textView becomeFirstResponder];

}

- (void)clickPostDyBtn {
    if (self.textView.text.length == 0) {
        [MFHUDManager showError:@"请输入要修改的内容"];
        return;
    }
    if (self.textView.text.length > 16) {
        [MFHUDManager showError:@"长度不能大于16"];
        return;
    }
    if (self.block) {
        self.block(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
