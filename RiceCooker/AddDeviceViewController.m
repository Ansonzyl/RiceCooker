//
//  AddDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "EasyLinkViewController.h"


@interface AddDeviceViewController ()
- (IBAction)exit:(id)sender;


@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加设备";
    if (_isAdd) {
        _leftButton.hidden = YES;
        _rightButton.hidden = YES;
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PushEasyLink:(id)sender {
    EasyLinkViewController *viewController = [[EasyLinkViewController alloc] initWithNibName:@"EasyLinkViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
