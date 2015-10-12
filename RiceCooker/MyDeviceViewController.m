//
//  MyDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "MyDeviceViewController.h"
#import "DM_MyDevices.h"
#import "BasicCell.h"
#import "DeviceDetailViewController.h"
@interface MyDeviceViewController ()
@property (nonatomic, strong) NSArray *deviceArray;
@end

@implementation MyDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设备";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self JSONWithURL];
}


- (void)JSONWithURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/EriceEvegetableMydeviceServlet", SERVER_URL] parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        _deviceArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showTopMessage:@"连接不到服务器"];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _deviceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BasicCell *cell = [tableView dequeueReusableCellWithIdentifier:[BasicCell cellID]];
    if (cell == nil) {
        cell = [BasicCell basicCell];
    }
    DM_MyDevices *device = [DM_MyDevices myDeviceWithDic:_deviceArray[indexPath.row]];
    cell.device = device;
    NSString *image = [NSString stringWithFormat:@"icon-%@133", device.devicename];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImage.image = [UIImage imageWithContentsOfFile:path];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceDetailViewController *viewController = [[DeviceDetailViewController alloc] initWithNibName:@"DeviceDetailViewController" bundle:nil];
    DM_MyDevices *device = [DM_MyDevices myDeviceWithDic:_deviceArray[indexPath.row]];
    viewController.deviceName = device.devicename;
    viewController.deviceState = device.state;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
