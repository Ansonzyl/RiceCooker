//
//  AddDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UIBarButtonItem *exited = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(exit:)];
//    UIBarButtonItem *exited = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:uibar target:self action:@selector(exit:)];
//    self.navigationItem.leftBarButtonItem = exited;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

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
