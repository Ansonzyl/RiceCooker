//
//  UserInfoViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/23.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AddDeviceCell.h"
#import "UserInfoCell.h"
#import "DM_UserInfo.h"
#import "MyDeviceViewController.h"
#import "ShareDeviceViewController.h"
#import "AddShareViewController.h"

@interface UserInfoViewController () <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *objArray;
@property (nonatomic, strong) NSMutableData *imageData;
//@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSDictionary *recieve;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
   
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    _objArray = [NSArray arrayWithObjects:@"消息中心",@"我的订单",@"反馈",@"关于", nil];
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
     [self downLoadImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)JSONWithURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"phonenumber":_phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/PersonCenter", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _recieve = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil][0];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showTopMessage:@"连接不上服务器"];
    }];
    
}

- (void)downLoadImage
{
    _imageData = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://%@/DownloadServlet", SERVER_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];

    [NSURLConnection connectionWithRequest:request delegate:self];
    
}


// 响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _imageData.length = 0;
    NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
    float length = [[resp.allHeaderFields objectForKey:@"Content-Length"] floatValue];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"%f", length);
    
}
// 响应体
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _iconImage = [UIImage imageWithData:_imageData];
    NSIndexSet *section = 0;
//    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1)
    {
        return 4;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        [self JSONWithURL];
       
        UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userInfo"];
        DM_UserInfo *userInfo = [DM_UserInfo userInfoWithDic:_recieve];
        cell.dm_userInfo = userInfo;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userIcon.image = _iconImage;
        return cell;
    }else
    {
        AddDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddDeviceCell ID]];
        if (cell == nil) {
            
            cell = [AddDeviceCell AddDeviceCell];
            
            
        }
        
        NSString *image = [NSString stringWithFormat:@"icon-%@", _objArray[indexPath.row]];
        NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.logoImage.image = [UIImage imageWithContentsOfFile:path];
        cell.myLebel.text = _objArray[indexPath.row];
        cell.myLebel.font = [UIFont systemFontOfSize:12];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 179;
    }else
        return 57;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bondDevices:(id)sender {
    MyDeviceViewController *viewController = [[MyDeviceViewController alloc] init];
    viewController.phoneNumber = self.phoneNumber;
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)shareDevices:(id)sender {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShareDeviceViewController *viewController = [stroyboard instantiateViewControllerWithIdentifier:@"ShareDeviceViewController"];
    [viewController setHidesBottomBarWhenPushed:YES];
    viewController.phoneNumber = self.phoneNumber;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)collectRecipe:(id)sender {
    //AddShareViewController *viewController = [[AddShareViewController alloc] initWithNibName:@"AddShareViewController" bundle:nil];
    //[self.navigationController pushViewController:viewController animated:YES];
    
    
}
@end
