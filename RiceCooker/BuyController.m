//
//  BuyController.m
//  RiceCooker
//
//  Created by yi on 15/11/3.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "BuyController.h"
#import "DM_Commodity.h"
#import "Cell9.h"
@interface BuyController () <UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, strong) NSArray *payArray;
@property (nonatomic, strong) NSString *money;
@end

@implementation BuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pay" ofType:@"plist"];
    _payArray = [NSArray arrayWithContentsOfFile:path];
    _phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self URLForResidualAmount];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.bounds = CGRectMake(0, 0,12, 20);
    [leftBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-返回.png" ofType:nil]] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.view addSubview:leftBtn];

    _remarks = @"1";
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)back
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消支付"  message:@"您要放弃这次支付吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"继续支付" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}



- (void)URLForResidualAmount
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *paramters = @{@"phonenumber":self.phoneNumber};
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat: @"http://%@/ShopFirstServlet", SERVER_URL];
    [manager POST:url parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableString *recieve = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([recieve isEqualToString:@"fail"]) {
            
        }else
        {
            NSString *s = [recieve substringToIndex:7];
            if ([s isEqualToString:@"success"]) {
                _money = [recieve substringFromIndex:7];
                [self.tableView reloadData];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
        [self showTopMessage:@"连接不到服务器"];
        
    }];
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"buyCell1"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"buyCell1"];
            
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"总价";
            cell.textLabel.textColor = UIColorFromRGB(0xff6314);
            cell.detailTextLabel.text = _totalPrice;
            cell.detailTextLabel.textColor = UIColorFromRGB(0xff6314);
        }else
        {
            cell.textLabel.textColor = UIColorFromRGB(0x848484);
            cell.detailTextLabel.textColor = UIColorFromRGB(0x40c8c4);
            if (indexPath.row == 1) {
                cell.textLabel.text  = @"账户余额";
                cell.detailTextLabel.text = [NSString stringWithFormat: @"¥%@",self.money];
            }else
            {
                cell.textLabel.text = @"还需支付";
                double i =  [[_totalPrice substringFromIndex:1] doubleValue] - [self.money doubleValue];
                if (i > 0) {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%.1f", i];
                }else
                    cell.detailTextLabel.text = @"¥0";
                
            }
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        return cell;
    }else
    {
        Cell9 *cell = [tableView dequeueReusableCellWithIdentifier:@"buyCell2"];
        if (cell == nil) {
            cell = [[Cell9 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"buyCell2"];
        }
        NSDictionary *dic = [self.payArray objectAtIndex:indexPath.row];
        
        cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[dic valueForKey:@"image"] ofType:@"png"]];
        cell.textLabel.text = [dic valueForKey:@"title"];
        cell.detailTextLabel.text = [dic valueForKey:@"detail"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"   请选择支付方式";
    }else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 12;
    }else
        return 20;
}

- (IBAction)payment:(id)sender {
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        for (int i = 0; i < _affirmArray.count; i++)
    {
        DM_Commodity *commodity = _affirmArray[i];

    
        
        NSString *urlStr = [NSString stringWithFormat: @"http://%@/ShopOrderServlet", SERVER_URL];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        
        NSString *body = [NSString stringWithFormat:@"phonenumber=%@&nameKey=%@&count=%@&priceKey=%@&deliveryTime=%@&userName=%@&userPhone=%@&userAddress=%@&totalPrice=%@&remarks=%@", self.phoneNumber, commodity.nameKey, commodity.count, commodity.priceKey, _deliveryTime, _userMsg.userName, _userMsg.userPhone, _userMsg.userAddress, [_totalPrice substringFromIndex:1], _remarks];
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *recieve = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", recieve);
            NSInteger state = [(NSHTTPURLResponse *)response statusCode];
            if ([recieve isEqualToString:@"fail"]) {
                
            }else
            {
                if (recieve.length > 7) {
                    NSString *s = [recieve substringToIndex:7];
                    if ([s isEqualToString:@"success"]) {
                        [self cartURL];
                        _money = [recieve substringFromIndex:7];
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                        }];
                        [alert addAction:cancel];
                        [self presentViewController:alert animated:YES completion:^{
                            
                        }];
                    }
                
                }else
                {
                    
                }

            }
            NSLog(@"%@",error);
            
            
        }];
        
        [task resume];
        
        
    }
    
}

- (void)cartURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (_cartArray.count == 0) {
        [self encodedItem];
    }else
    {
    for (int i = 0; i<_cartArray.count; i++) {
        DM_Commodity *commodity = _cartArray[i];
        
        NSDictionary *paramters = @{@"phonenumber" : self.phoneNumber,
                                    @"nameKey" : commodity.nameKey,
                                    @"count" : commodity.count,
                                    @"priceKey" : commodity.priceKey,
                                   };
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *url = [NSString stringWithFormat: @"http://%@/ShopRemainServlet", SERVER_URL];
        [manager POST:url parameters:paramters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableString *recieve = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@", recieve);
                if ([recieve isEqualToString:@"fail"]) {
                
            }else if ([recieve isEqualToString:@"success"])
            {
                [self encodedItem];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@", error);
            
            [self showTopMessage:@"连接不到服务器"];
            
        }];
    }
    }

    

}

- (void)encodedItem
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_cartArray.count; i++) {
        [array addObject:[(DM_Commodity *)_cartArray[i] encodedItem]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"CartArray"];

}


@end
