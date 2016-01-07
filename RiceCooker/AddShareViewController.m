//
//  AddShareViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddShareViewController.h"

@interface AddShareViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *sharePhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *sharePhoneNumberImageView;
@property (weak, nonatomic) IBOutlet UIImageView *repeatPhoneNumberImageView;
@property (weak, nonatomic) IBOutlet UITextField *repeatPhoneNumberTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
- (IBAction)shareDevices:(id)sender;


@end

@implementation AddShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = _shareDevice.devicename;
    NSString *image = [NSString stringWithFormat:@"icon-%@188", _shareDevice.devicename];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    self.iconImage.image = [UIImage imageWithContentsOfFile:path];
    self.shareButton.layer.cornerRadius = 2;
    _repeatPhoneNumberTextFiled.delegate = self;
    _sharePhoneNumberTextField.delegate = self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_sharePhoneNumberTextField]) {
        _sharePhoneNumberImageView.highlighted = YES;
    }else
    {
        _repeatPhoneNumberImageView.highlighted = YES;
    }
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

- (IBAction)shareDevices:(id)sender {
}

- (IBAction)tapBack:(id)sender {
    [self.view endEditing:YES];
}
@end
