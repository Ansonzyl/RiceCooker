//
//  MainViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(exit:)];
//    self.navigationItem.leftBarButtonItem = button;
    self.tabBar.barTintColor = UIColorFromRGB(0x40c8c4);
    self.tabBar.tintColor = UIColorFromRGB(0xbbf5f4);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xbbf5f4),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    NSArray *items = self.tabBar.items;
    UITabBarItem *kitchen = items[0];
    kitchen.title = @"我的厨房";
    kitchen.image = [[UIImage imageNamed:@"icon-导航-点点商城.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    kitchen.selectedImage = [[UIImage imageNamed:@"icon-导航-点点商城select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *shop = items[1];
    shop.title = @"点点商城";
    shop.image = [[UIImage imageNamed:@"icon-我的厨房.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shop.selectedImage = [[UIImage imageNamed:@"icon-我的厨房select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *userInfo = items[2];
    userInfo.image = [[UIImage imageNamed:@"icon-导航-个人中心.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userInfo.selectedImage = [[UIImage imageNamed:@"icon-导航-个人中心select.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    userInfo.title = @"个人中心";
    
}


- (void)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
