//
//  MainViewController.m
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.tabBar.barTintColor = UIColorFromRGB(0x40c8c4);
    self.tabBar.tintColor = UIColorFromRGB(0xbbf5f4);
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0xbbf5f4),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : UIColorFromRGB(0xbbf5f4),NSFontAttributeName:[UIFont fontWithName:@"Marion-Italic" size:11.0]} forState:UIControlStateNormal];
    
    
    _items = self.tabBar.items;
    UITabBarItem *kitchen = _items[0];
    kitchen.title = @"我的厨房";
    kitchen.image = [[UIImage imageNamed:@"icon-我的厨房（未选中）.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    kitchen.selectedImage = [[UIImage imageNamed:@"icon-我的厨房.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *shop = _items[1];
    shop.title = @"点点商城";
    
    shop.image = [[UIImage imageNamed:@"icon-68点点商城(未选中）.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shop.selectedImage = [[UIImage imageNamed:@"icon-68点点商城.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    UITabBarItem *userInfo = _items[2];
    userInfo.image = [[UIImage imageNamed:@"icon-个人中心（未选中）.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userInfo.selectedImage = [[UIImage imageNamed:@"icon-个人中心.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    userInfo.title = @"个人中心";
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
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
