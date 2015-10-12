//
//  DeviceDetailViewController.m
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "AddDeviceCell.h"
@interface DeviceDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSArray *object;

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = _deviceName;
    NSString *image = [NSString stringWithFormat:@"icon-%@188", _deviceName];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    self.iconImage.image = [UIImage imageWithContentsOfFile:path];
    self.nameLabel.text = _deviceState;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _object = [NSArray arrayWithObjects:@"修改设备名称",@"分享给家人", @"检查固件升级", @"解除连接", @"反馈", @"说明书",  nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _object.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddDeviceCell ID]];
    if (cell == nil) {
        cell = [AddDeviceCell AddDeviceCell];
    }
    cell.myLebel.text = _object[indexPath.row];
    NSString *image = [NSString stringWithFormat:@"icon-%@", _object[indexPath.row]];
    NSString *path = [[NSBundle mainBundle] pathForResource:image ofType:@"png"];
    cell.logoImage.image = [UIImage imageWithContentsOfFile:path];
    cell.myLebel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
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
