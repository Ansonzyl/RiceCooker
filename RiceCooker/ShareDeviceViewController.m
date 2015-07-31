//
//  ShareDeviceViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "ShareDeviceViewController.h"
#import "SwipeableCell.h"
#import "DM_ShareDevices.h"
#import "AddShareViewController.h"
#import "ManageShareDeviceViewController.h"
@interface ShareDeviceViewController ()<SwipebleCellDelegate>
@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) NSMutableSet *cellsCurrentlyEditing;
@end

@implementation ShareDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备共享";
    self.cellsCurrentlyEditing = [NSMutableSet new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self JSONWithURL];
}


- (void)JSONWithURL
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"phonenumber":_phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"http://%@/EriceEvegetableShareServlet", SERVER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _objects = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self showTopMessage:@"连接不上服务器"];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _objects.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwipeableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell" forIndexPath:indexPath];
    
    DM_ShareDevices *shareDevice = [DM_ShareDevices shareDeviceWithDic:_objects[indexPath.row]];
    cell.shareDevice = shareDevice;
    cell.delegate = self;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark SwipebleCellDelegate
- (void)buttonShareActionForItem:(DM_ShareDevices *)shareDevice
{
    NSLog(@"in delegate,click shareButton");
    AddShareViewController *viewController = [[AddShareViewController alloc] initWithNibName:@"AddShareViewController" bundle:nil];
    viewController.shareDevice = shareDevice;
    [self.navigationController pushViewController:viewController animated:YES];
    
}


- (void)buttonManagerActionForItem:(DM_ShareDevices *)shareDevice
{
    NSLog(@"in delegate,click managerButton");
    ManageShareDeviceViewController *viewController = [[ManageShareDeviceViewController alloc] init];
    viewController.shareDevice = shareDevice;
    [self.navigationController pushViewController:viewController animated:YES];

}


- (void)cellDidOpen:(UITableViewCell *)cell {
    NSIndexPath *currentEditingIndexPath = [self.tableView indexPathForCell:cell];
    [self.cellsCurrentlyEditing addObject:currentEditingIndexPath];
}

- (void)cellDidClose:(UITableViewCell *)cell {
    [self.cellsCurrentlyEditing removeObject:[self.tableView indexPathForCell:cell]];
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
