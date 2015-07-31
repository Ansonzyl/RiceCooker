//
//  AddShareViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddShareViewController.h"

@interface AddShareViewController ()

@end

@implementation AddShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = _shareDevice.devicename;
    NSString *image = [NSString stringWithFormat:@"icon-%@188", _shareDevice.devicename];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    self.iconImage.image = [UIImage imageWithContentsOfFile:path];
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
