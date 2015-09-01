//
//  MyViewController.m
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyViewController.h"
#import "MDRadialProgressView.h"

@interface MyViewController ()
@property (nonatomic, strong) DM_EVegetable *device;
@end

@implementation MyViewController

- (id)initWithDevice:(DM_EVegetable *)device
{
    if (self = [super initWithNibName:@"MyViewController" bundle:nil]) {
        _device = device;
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = _device.devicename;
    NSString *imageName = [NSString stringWithFormat:@"%@背景", _device.devicename];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    NSData *image = [NSData dataWithContentsOfFile:filePath];
    self.backgroundView.image = [UIImage imageWithData:image];
    
//    MDRadialProgressView *radialview = [self progressViewWithFrame:<#(CGRect)#>]
    
    
}

- (MDRadialProgressView *)progressViewWithFrame:(CGRect)frame
{
    MDRadialProgressView *view = [[MDRadialProgressView alloc] initWithFrame:frame];
    view.center = CGPointMake(self.view.center.x + 80, view.center.y);
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
