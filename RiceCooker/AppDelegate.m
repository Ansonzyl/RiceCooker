//
//  AppDelegate.m
//  RiceCooker
//
//  Created by yi on 15-6-2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface AppDelegate ()

@end

@implementation AppDelegate

//应用程序启动后，要执行的委托调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = nav;
    
//    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x40c8c4)];//    [[UINavigationBar appearance] setTranslucent:YES];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed: @"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    
//    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0xd7ffff)];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];

    
    return YES;
}


//应用程序将要由活动状态切换到非活动状态时执行的委托调用，如按下home 按钮，返回主屏幕，或全屏之间切换应用程序等。
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//在应用程序已进入后台程序时，要执行的委托调用。所以要设置后台继续运行，则在这个函数里面设置即可。
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//在应用程序将要进入前台时(被激活)，要执行的委托调用，与applicationWillResignActive 方法相对应。

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//在应用程序已被激活后，要执行的委托调用，刚好与  applicationDidEnterBackground 方法相对应。
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//在应用程序要完全退出的时候，要执行的委托调用。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
