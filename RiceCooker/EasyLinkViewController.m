//
//  EasyLinkViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EasyLinkViewController.h"
#import "AddDeviceViewController.h"
#define SERVERIP @"202.75.219.40"
#define SERVERPORT @"8899"
#define DEVICEWLANNAME @"MXCHIP_4A1B0A"

@interface EasyLinkViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *WlanViewImage;
@property (weak, nonatomic) IBOutlet UITextField *SSIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
- (IBAction)tapBack:(id)sender;
- (IBAction)pushNextView:(id)sender;
- (IBAction)backStep:(id)sender;

@end

@implementation EasyLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加设备";
    self.SSIDTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    NSString *SSIDN = [[NSUserDefaults standardUserDefaults] objectForKey:@"SSIDContent"];
    NSString *SSIDName = [[self fetchSSIDInfo] objectForKey:@"SSID"];
    if (![SSIDName isEqualToString:DEVICEWLANNAME]) {
        [[NSUserDefaults standardUserDefaults] setObject:SSIDName forKey:@"SSIDContent"];
        self.SSIDTextField.text = SSIDName;

    }else
        self.SSIDTextField.text = SSIDN;
    
    
    
}

- (id)fetchSSIDInfo{
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    NSLog(@"Support interfaces : %@", ifs);
    NSDictionary *info;
    for (NSString *ifnam in ifs)
    {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count])
        {
            break;
        }
    }
    return  info;
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

#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_passwordTextField]) {
        _passwordImageView.highlighted = YES;
    }else if ([textField isEqual:_SSIDTextField])
    {
        _WlanViewImage.highlighted = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _passwordImageView.highlighted = NO;
    _WlanViewImage.highlighted = NO;
}


- (IBAction)tapBack:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)pushNextView:(id)sender {
//    [self restart];
    AddDeviceViewController *viewController = [[AddDeviceViewController alloc] initWithNibName:@"AddDeviceViewController" bundle:nil];
    viewController.isAdd = YES;
    [self.navigationController pushViewController:viewController animated:YES];

}

- (IBAction)backStep:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)restart
{
    NSString *urlStr = @"http://192.168.1.1/advanced.htm";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    NSMutableString *body = [NSMutableString stringWithFormat:@"wifi_mode=1&wifi_ssid=%@&security_mode=4&wifi_key=%@&wifi_ssid1=&security_mode1=0&wifi_key1=&wifi_ssid2=&security_mode2=0&wifi_key2=&wifi_ssid3=&security_mode3=0&wifi_key3=&wifi_ssid4=&security_mode4=0&wifi_key4=&uap_ssid=&uap_secmode=1&uap_key=&dhcp_enalbe=1&local_ip_addr=0.0.0.0&netmask=0.0.0.0&gateway_ip_addr=0.0.0.0&dns_server=0.0.0.0&mstype=1&remote_server_mode=0&remote_dns=202.75.219.40&rport=8899&lport=8899&", self.SSIDTextField.text, self.passwordTextField.text];
    
    [body appendString:@"estype=4&esaddr=&esrport=0&eslport=0&baudrate=4&parity=0&data_length=0&stop_bits=0&cts_rts_enalbe=0&dma_buffer_size=0&uart_trans_mode=4&device_num=0&ps_enalbe=0&tx_power=31&keepalive_num=4&keepalive_time=120&socks_type=0&socks_addr=0.0.0.0&socks_port=0&socks_user=&socks_pass=&socks_1=0&socks_2=0&web_user=admin&web_pass=admin&cld_id=0&cld_key=00000000000000000000000000000000&device_name=EMW_3162+%284A1B0A%29&roam_val=75&udp_enable=1&reset=Reset"];
    
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *length = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:@"http://192.168.1.1" forHTTPHeaderField:@"Origin"];
    [request setValue:@"Basic YWRtaW46YWRtaW4=" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"http://192.168.1.1/advanced.htm" forHTTPHeaderField:@"Referer"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:length forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [request setValue:@"192.168.1.1" forHTTPHeaderField:@"Host"];
    [request setHTTPBody:bodyData];
    NSHTTPURLResponse *respose;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&respose error:&error];
    
    if ([respose statusCode] == 200) {
        AddDeviceViewController *viewController = [[AddDeviceViewController alloc] initWithNibName:@"AddDeviceViewController" bundle:nil];
        viewController.isAdd = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }

}


@end
