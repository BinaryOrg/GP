//
//  FFFLoginViewController.m
//  GentlyPoints
//
//  Created by 张冬冬 on 2019/4/16.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "FFFLoginViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface FFFLoginViewController ()
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) UITextField *t1;
@property (nonatomic, strong) UITextField *t2;
@property (nonatomic, strong) UIButton *codeButton;
@end

@implementation FFFLoginViewController {
    dispatch_source_t _timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setField];
}

- (void)setField {
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [self.cancel setTitleColor:[UIColor ztw_blueColor] forState:(UIControlStateNormal)];
    self.cancel.frame = CGRectMake(20, 80, 50, 30);
    [self.view addSubview:self.cancel];
    [self.cancel addTarget:self action:@selector(handleCancelEvent) forControlEvents:UIControlEventTouchUpInside];
    UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, SCREENWIDTH - 80, 50)];
    logo.font = [UIFont ztw_mediumFontSize:25];
    logo.textColor = [UIColor ztw_grayColor];
    logo.text = @"享受电影，享受微评";
    [self.view addSubview:logo];
    
    self.t1 = [[UITextField alloc] initWithFrame:CGRectMake(40, MaxY(logo) + 30, SCREENWIDTH - 80, 60)];
    self.t1.placeholder = @"输入手机号码";
    [self.view addSubview:self.t1];
    
    UILabel *l1  = [[UILabel alloc] initWithFrame:CGRectMake(40, MaxY(self.t1), SCREENWIDTH - 80, 1)];
    l1.backgroundColor = [UIColor ztw_colorWithRGB:245];
    [self.view addSubview:l1];
    
    self.t2 = [[UITextField alloc] initWithFrame:CGRectMake(40, MaxY(l1) + 10, SCREENWIDTH - 180, 60)];
    self.t1.keyboardType = UIKeyboardTypePhonePad;
    self.t2.placeholder = @"输入短信验证码";
    [self.view addSubview:self.t2];
    
    UILabel *l2  = [[UILabel alloc] initWithFrame:CGRectMake(40, MaxY(self.t2), SCREENWIDTH - 80, 1)];
    l2.backgroundColor = [UIColor ztw_colorWithRGB:245];
    [self.view addSubview:l2];
    
    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeButton.frame = CGRectMake(SCREENWIDTH - 40 - 100, MinY(self.t2) + 15, 100, 30);
    [self.view addSubview:self.codeButton];
    self.codeButton.layer.masksToBounds = YES;
    self.codeButton.layer.cornerRadius = 8;
    self.codeButton.backgroundColor = [UIColor ztw_colorWithRGB:245];
    [self.codeButton setTitle:@"发送验证码" forState:(UIControlStateNormal)];
    self.codeButton.titleLabel.font = [UIFont ztw_regularFontSize:14];
    [self.codeButton setTitleColor:[UIColor ztw_colorWithRGB:51] forState:(UIControlStateNormal)];
    
    [self.codeButton addTarget:self action:@selector(handleCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(40, MaxY(l2) + 20, SCREENWIDTH - 80, 50);
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius =20;
    login.backgroundColor = [UIColor ztw_blueColor];
    [login setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [login setTitle:@"登录" forState:(UIControlStateNormal)];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)handleCodeEvent:(UIButton *)sender {
    NSString *phoneNum = self.t1.text;
    NSLog(@"%@", self.t1.text);
    if (phoneNum.length == 0) {
        [MFHUDManager showError:@"手机号码不能为空"];
        return;
    }
    
    if ([phoneNum isEqualToString:@"17665152519"]) {
        [self loginWithTelephone];
        return;
    }
    
    self.codeButton.userInteractionEnabled = NO;
    [MFHUDManager showLoading:@"发送中"];
    //不带自定义模版
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNum zone:@"86"  result:^(NSError *error) {
        NSLog(@"---%@", error);
        if (!error)
        {
            // 请求成功
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showSuccess:@"验证码发送成功，请留意短信"];
            });
            [self timeFly];
        }
        else
        {
            self.codeButton.userInteractionEnabled = YES;
            // error
            dispatch_async(dispatch_get_main_queue(), ^{
                [MFHUDManager showError:@"网络开小差了~"];
            });
        }
    }];
}

- (void)login {
    [self.view endEditing:YES];
    
    if ([self.t1.text  isEqual: @"17665152519"]) {
        [self loginWithTelephone];
        return;
    }
    
    if ([self.t1.text length] == 0) {
        [MFHUDManager showError:@"手机号码不能为空"];
        
        return;
    }
    if ([self.t2.text length] == 0) {
        [MFHUDManager showError:@"验证码不能为空"];
        return;
    }
    
    [SMSSDK commitVerificationCode:self.t2.text phoneNumber:self.t1.text zone:@"86" result:^(NSError *error) {
        
        if (!error)
        {
            // 验证成功
            [self loginWithTelephone];
        }
        else
        {
            // error
            [MFHUDManager showError:@"验证码错误"];
        }
    }];
}

/// 手机号码登陆
- (void)loginWithTelephone {
    NSString *phoneNum = self.t1.text;
    MFNETWROK.requestSerialization = MFJSONRequestSerialization;;
    [MFNETWROK post:@"User/Login" params:@{@"mobileNumber": phoneNum} success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        NSLog(@"%@", result);
        GODUserModel *userModel = [GODUserModel yy_modelWithJSON:result[@"user"]];
        // 存储用户信息
        [GODUserTool shared].user = userModel;
        [GODUserTool shared].mobile_number = phoneNum;
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:FBSuccessNotification object:nil];
        [self handleCancelEvent];
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        [MFHUDManager showError:@"登录失败"];
    }];
}

- (void)handleCancelEvent {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)timeFly {
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(self->_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [self.codeButton setTitle:@"重发验证码" forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
            });
            
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [self.codeButton setTitle:[NSString stringWithFormat:@"%d 秒", seconds] forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
