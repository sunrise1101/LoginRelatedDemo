//
//  LoginViewController.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "LoginViewController.h"
#import "DXDReTextField.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIButton *switchButton;
@property (nonatomic, strong) DXDReTextField *phoneTF;
@property (nonatomic, strong) DXDReTextField *passwordTF;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self bindView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)bindView {
    @weakify(self);
    RACSignal *loginSignal = [[RACSignal combineLatest:@[[RACObserve(self.phoneTF, text)  merge:self.phoneTF.rac_textSignal], [RACObserve(self.passwordTF, text)  merge:self.passwordTF.rac_textSignal]] reduce:^id(NSString *phoneString, NSString *passwordString){
        phoneString = [phoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return @(phoneString.length >= 11 && passwordString.length >= 6);
    }] distinctUntilChanged];
    
    [loginSignal subscribeNext:^(NSNumber *active) {
        @strongify(self);
        self.loginButton.enabled = [active boolValue];
        self.loginButton.backgroundColor = [UIColor pb_colorWithHexString:c_grapefruit Alpha:[active boolValue] ? 1 : 0.6];
    }];
}

- (void)setupViews {
    [self.view addSubview:self.switchButton];
    [self.view addSubview:self.phoneTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginButton];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

-(void)updateViewConstraints {
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dxd_autoResize(22));
        make.right.mas_equalTo(dxd_autoResize(-20));
    }];
    
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(dxd_autoResize(180));
        make.left.offset(dxd_autoResize(12));
        make.right.offset(dxd_autoResize(-12));
        make.height.mas_equalTo(dxd_autoResize(40));
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTF.mas_bottom).offset(dxd_autoResize(5));
        make.left.right.height.equalTo(self.phoneTF);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneTF);
        make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(dxd_autoResize(20));
        make.height.mas_equalTo(dxd_autoResize(44));
    }];
    
    [super updateViewConstraints];
}

- (UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton sizeToFit];
        _switchButton.titleLabel.font = PBSysFont(dxd_autoResize(16));
        [_switchButton setTitleColor:[UIColor pb_colorWithHexString:c_warmGrey] forState:(UIControlStateNormal)];
        [_switchButton setTitle:@"切换环境" forState:(UIControlStateNormal)];
        @weakify(self);
        [[_switchButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            @strongify(self);
            [self switchSetting];
        }];
#ifdef DEBUG
        _switchButton.hidden = NO;
#else
        _switchButton.hidden = YES;
#endif
    }
    return _switchButton;
}

- (DXDReTextField *)phoneTF {
    if (!_phoneTF) {
        _phoneTF = [[DXDReTextField alloc] init];
        _phoneTF.font = PBSysFont(dxd_autoResize(15));
        _phoneTF.textColor = [UIColor pb_colorWithHexString:c_black];
        _phoneTF.placeholder = @"请输入手机号";
        _phoneTF.pattern = PB_PHONE_REGEXP;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.backgroundColor = [UIColor pb_colorWithHexString:c_whiteSix];
    }
    return _phoneTF;
}

- (DXDReTextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[DXDReTextField alloc] init];
        _passwordTF.font = PBSysFont(dxd_autoResize(15));
        _passwordTF.textColor = [UIColor pb_colorWithHexString:c_black];
        _passwordTF.placeholder = @"请输入密码(不少于6位)";
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.secureTextEntry = YES;
        _passwordTF.backgroundColor = [UIColor pb_colorWithHexString:c_whiteSix];
    }
    return _passwordTF;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _loginButton.backgroundColor = [UIColor pb_colorWithHexString:c_grapefruit];
        _loginButton.layer.cornerRadius = 3;
        _loginButton.layer.masksToBounds = YES;
        [_loginButton setTitle:@"开始" forState:(UIControlStateNormal)];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _loginButton.titleLabel.font = PBSysBoldFont(dxd_autoResize(17));
        @weakify(self);
        [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.view endEditing:YES];
            [DXDDefultInfoHelper sharedInstance].isLogin = YES;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate switchRootController:[DXDDefultInfoHelper sharedInstance].isLogin];
        }];
    }
    return _loginButton;
}

- (void)switchSetting {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    [DXDAlertHelper addActionTarget:alert title:@"测试环境" action:^(UIAlertAction *action) {
        [DXDDefultInfoHelper sharedInstance].urlHeader = testUrlHeaderString;
    }];
    [DXDAlertHelper addActionTarget:alert title:@"生产环境" action:^(UIAlertAction *action) {
        [DXDDefultInfoHelper sharedInstance].urlHeader = urlHeaderString;
    }];
    [DXDAlertHelper addCancelActionTarget:alert title:@"取消" action:^(UIAlertAction *action) {}];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
