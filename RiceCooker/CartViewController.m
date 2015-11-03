//
//  CartViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CartViewController.h"
#import "CartCell.h"
#import "AddressCell.h"
#import "AddNewAddressCell.h"
#import "AffirmViewController.h"

#define RowHeight 57
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface CartViewController ()<UITableViewDataSource, UITableViewDelegate, CartCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *affirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *totolLabel;
@property (nonatomic, strong) UITableView *topTableView;
@property (nonatomic, strong) UIControl *overlay;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.title = @"购物列表";
    [self setNavigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
    self.affirmBtn.titleLabel.font = [UIFont systemFontOfSize:13*kRate];
    self.affirmBtn.layer.cornerRadius = 2;
    self.totolLabel.font = [UIFont systemFontOfSize:13*kRate];
    [self totolPrice];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self initializeTableViewAndeArray];
        
    });
    
}

- (void)initializeTableViewAndeArray
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"addressArray"];
    _addressArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        DM_UserMessage *msg = [DM_UserMessage userMessageWithDict:array[i]];
        [_addressArray addObject:msg];
    }
    CGFloat kH = (_addressArray.count + 1)*RowHeight;
    _topTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - kH, kWidth, kH)];
    _topTableView.delegate = self;
    _topTableView.dataSource = self;
    _topTableView.rowHeight = RowHeight;

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_cartArray.count; i++) {
        [array addObject:[(DM_Commodity *)_cartArray[i] encodedItem]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"CartArray"];

    
}




- (void) setNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x40c8c4)];
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0xd7ffff)];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:UIColorFromRGB(0xd7ffff) forKey:NSForegroundColorAttributeName]];
    
}




#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        return 0.1;
    }else

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView]) {
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

    }else if ([tableView isEqual:_topTableView])
    {
        if (section == 0) {
            return _addressArray.count;
        }else
        {
            return 1;
        }

    }else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 购物车列表
    if ([tableView isEqual:self.tableView]) {
        if (indexPath.section == 1) {
            static NSString *cellID = @"cartCell";
            CartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.delegate = self;
            DM_Commodity *commodity = _cartArray[indexPath.row];
            cell.commidity = commodity;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else
        {
            AddressCell *cell = [AddressCell addressCell];
            cell.select.image = [UIImage imageNamed:@"icon-地址.png"];
            cell.userMessage = (DM_UserMessage *)_addressArray[0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else // 选择地址
    {
        if (indexPath.section == 0) {
            static NSString *cellID = @"addressCell";
            AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [AddressCell addressCell];
            }
            cell.userMessage = (DM_UserMessage *)_addressArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.selected = YES;
            return cell;
            
        }else
        {
            AddNewAddressCell *cell = [[AddNewAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressNewCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 95*kRate;
    }else
        return RowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if (indexPath.section == 1) {
            DM_Commodity *commodity = _cartArray[indexPath.row];
            CartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell.check.highlighted) {
                cell.check.highlighted = NO;
                
            }else
            {
                cell.check.highlighted = YES;
            }
            commodity.isSelected = !cell.check.highlighted;
            [_cartArray replaceObjectAtIndex:indexPath.row withObject:commodity];
            [self totolPrice];
        }else
        {
            [self setTopView];
        }

    }else
    {
        if (indexPath.section == 0) {
            DM_UserMessage * address = [_addressArray objectAtIndex:indexPath.row];
            NSLog(@"%@", address.userAddress);
            [_addressArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [self.topTableView reloadData];
            [self.tableView reloadData];
            
            
            [self dismiss];
        }else
        {
#warning 地址
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
                    -- num;
                    commodity.count = [NSString stringWithFormat:@"%d",num];
                    
                }else if(num <= 1)
                {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除商品吗" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
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
        [self totolPrice];
    }
    
    
    
}

- (void)totolPrice
{
    double price=0;
    for (int i = 0; i<_cartArray.count; i++) {
        DM_Commodity *commodity = [_cartArray objectAtIndex:i];
        if (commodity.isSelected) {
            int count = [commodity.count intValue];
            double p = [commodity.priceKey doubleValue];
            price = price + count * p;
        }
    }
    _totolLabel.text = [NSString stringWithFormat:@"¥%.1f",price];
    NSLog(@"%f",price);
}

//
- (IBAction)pushToBuy:(id)sender {
    AffirmViewController *viewController = [[AffirmViewController alloc] initWithNibName:@"AffirmViewController" bundle:nil];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSScanner *scanner;
    int weight = 0;
    for (int i = 0; i < _cartArray.count; i++) {
        DM_Commodity *com = _cartArray[i];
        if (com.isSelected) {
            [array addObject:com];
            
            scanner = [NSScanner scannerWithString:com.nameKey];
            [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
            int j = 0;
            [scanner scanInt:&j];
            weight += j * [com.count intValue];
        }else
            [array2 addObject:com];
    }

    
    viewController.userMsg = _addressArray[0];
    viewController.affirmArray = array;
    viewController.weight = weight;
    viewController.cartArray = array2;
    viewController.totolPrice = _totolLabel.text;
    if (array.count > 0) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
  }


#pragma mark 下拉tableview
- (void)setTopView
{
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.topTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    CGFloat h =  CGRectGetHeight(self.navigationController.navigationBar.frame) + 20;
    _overlay = [[UIControl alloc] initWithFrame:CGRectMake(0, h, kWidth, CGRectGetHeight(self.view.frame))];
    _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_overlay addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _overlay.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [self.navigationController.view insertSubview:_topTableView belowSubview:self.navigationController.navigationBar];
    [self.view addSubview:_overlay];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _topTableView.frame;
        frame.origin.y = h;
        _topTableView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _topTableView.frame;
        frame.origin.y = - RowHeight * 2;
        _topTableView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self.overlay removeFromSuperview];
        [_topTableView removeFromSuperview];
    }];
}


@end
