//
//  PBTabBarController.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "PBTabBarController.h"
#import "MyViewController.h"

@interface PBTabBarController ()

@end

@implementation PBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customTabbarVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 自定义tabbarController结构及UI
 */
- (void)customTabbarVC {
    //base custom
    NSArray *namesArr = @[@"UIViewController", @"MyViewController"];
    NSArray *titlesArr = @[@"首页", @"我的"];
    NSArray *nImagesArr = @[@"ic_homepage_s", @"ic_my_s"];
    NSArray *sImagesArr = @[@"ic_homepage", @"ic_my"];
    
    
    //init controllers
    NSMutableArray *itemArr = [NSMutableArray arrayWithCapacity:namesArr.count];
    for (int i = 0; i < namesArr.count; i++) {
        UIViewController *VC = [[NSClassFromString(namesArr[i]) alloc] init];
        VC.title = titlesArr[i];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        nav.tabBarItem.image = [UIImage imageNamed:nImagesArr[i]];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:sImagesArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor pb_colorWithHexString:c_warmGrey]} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor pb_colorWithHexString:c_grapefruit]} forState:UIControlStateSelected];
        [itemArr addObject:nav];
    }
    
    //set tabbar
    self.viewControllers = itemArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
