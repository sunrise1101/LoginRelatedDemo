//
//  MyViewController.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/7.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@property (nonatomic, copy) UIButton *logoutButton;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupViews {
    [self.view addSubview:self.logoutButton];
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

-(void)updateViewConstraints {
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(dxd_autoResize(12));
        make.right.offset(dxd_autoResize(-12));
        make.bottom.offset(dxd_autoResize(-70));
        make.height.mas_equalTo(dxd_autoResize(44));
    }];
    
    [super updateViewConstraints];
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _logoutButton.backgroundColor = [UIColor pb_colorWithHexString:c_grapefruit];
        _logoutButton.layer.cornerRadius = 3;
        _logoutButton.layer.masksToBounds = YES;
        [_logoutButton setTitle:@"退出" forState:(UIControlStateNormal)];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _logoutButton.titleLabel.font = PBSysBoldFont(dxd_autoResize(17));
        [[_logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [DXDDefultInfoHelper sharedInstance].isLogin = NO;
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate switchRootController:[DXDDefultInfoHelper sharedInstance].isLogin];
        }];
    }
    return _logoutButton;
}

@end
