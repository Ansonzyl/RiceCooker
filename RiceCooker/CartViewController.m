//
//  CartViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CartViewController.h"
#import "CartCell.h"

@interface CartViewController ()<UITableViewDataSource, UITableViewDelegate, CartCellDelegate>

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"购物列表";
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 100)];
    //    label.backgroundColor = [UIColor blackColor];
    //    [self.tableView addSubview:label];
    [self setNavigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void) setNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return  1;
            break;
        case 1:
            return _cartArray.count;
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"1";
    if (indexPath.section == 1) {
        static NSString *cellID = @"cartCell";
        CartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.delegate = self;
        DM_Commodity *com = _cartArray[indexPath.row];
        
        cell.commidity = com;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 95*kRate;
    }else
        return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        CartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.check.highlighted) {
            cell.check.highlighted = NO;
        }else
        {
            cell.check.highlighted = YES;
        }
    }
    
}

#pragma mark Cartdelegate
- (void)btnClick:(UITableViewCell *)cell andFlag:(NSInteger)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    if (index.section == 1) {
        DM_Commodity *commodity = _cartArray[index.row];
        int num = [commodity.count intValue];
        switch (flag) {
            case 5:
                if (num > 1) {
                    num --;
                    commodity.count = [NSString stringWithFormat:@"%d",num];
                    
                }else if(num == 1)
                {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除商品吗" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        commodity.count = @"0";
                    }];
                    UIAlertAction *affirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [_cartArray removeObjectAtIndex:index.row];
                        [self.tableView reloadData];
                        
                    }];
                    [alert addAction:cancelAction];
                    [alert addAction:affirm];
                    [self presentViewController:alert animated:YES completion:^{
                        
                    }];
                }
                break;
            case 6:
            {
                num ++;
                commodity.count = [NSString stringWithFormat:@"%d",num];
            }
                break;
            default:
                break;
        }
        [self.tableView reloadData];

    }
    
    
    
}

- (void)totolPrice
{
    for (int i = 0; i<_cartArray.count; i++) {
        DM_Commodity *commodity = [_cartArray objectAtIndex:i];
        
    }
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
