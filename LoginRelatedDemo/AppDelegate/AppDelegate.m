//
//  AppDelegate.m
//  LoginRelatedDemo
//
//  Created by 邓旭东 on 2018/1/2.
//  Copyright © 2018年 邓旭东. All rights reserved.
//

#import "AppDelegate.h"
#import "PBTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) PBTabBarController *tabBarController;
@property (nonatomic, strong) LoginViewController *loginController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *tempVC = [[UIViewController alloc] init];
    tempVC.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:[self getLaunchImageName]].CGImage);
    self.window.rootViewController = tempVC;
    
    BOOL isLogin = [[DXDDefultInfoHelper sharedInstance] isLogin];
    [self switchRootController:isLogin];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)switchRootController:(BOOL)isLogin {
    self.loginController = nil;
    self.tabBarController = nil;
    
    if (isLogin) {
        self.window.rootViewController = self.tabBarController;
    }
    else {
        self.window.rootViewController = self.loginController;
    }
}

- (PBTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[PBTabBarController alloc] init];
    }
    return _tabBarController;
}

- (LoginViewController *)loginController {
    if (!_loginController) {
        _loginController = [[LoginViewController alloc] init];
    }
    return _loginController;
}

- (NSString *) getLaunchImageName {
    CGSize viewSize = self.window.bounds.size;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return launchImage;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
