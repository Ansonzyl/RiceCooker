//
//  CommodityDetailViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "CommodityDetailViewController.h"
#import "CartViewController.h"
#import "DM_UIConten.h"
#import "RecipeCell.h"
#import "TitleCell.h"
#import "Cell2.h"
#import "Cell3.h"
#import "imageCell.h"

#define kRate [UIScreen mainScreen].bounds.size.width/414

@interface CommodityDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DM_UIConten *ui;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *numLabel2;
@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSArray *array;
@end

@implementation CommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ui = [[DM_UIConten alloc] init];
    _numInShop = 0;
    _userDefaults = [NSUserDefaults standardUserDefaults];
//    _array = [_userDefaults objectForKey:@"CartArray"];
    [self setlabel];
    [self setButton];
    [self setNavigationBar];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.bounds = CGRectMake(0, 0,30*kRate, 30*kRate );
    [leftBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-返回（商品详情页）.png" ofType:nil]] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [self.view addSubview:leftBtn];
    


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



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _array = [_userDefaults objectForKey:@"CartArray"];
    _numLabel2.text = [NSString stringWithFormat:@"%lu", (unsigned long)_array.count];
    if (_array.count <= 0) {
        _numLabel2.hidden = YES;
    }else
        _numLabel2.hidden = NO;

    [self setNavigationBar];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        _cartArray = [NSMutableArray array];
        for (int i = 0; i<_array.count; i++) {
            DM_Commodity *com = [DM_Commodity commodityWithDict:_array[i]];
            [_cartArray addObject:com];
        }
        
    });
}



- (void)setlabel
{
    _numLabel = [_ui initializeLabelWithFrame:CGRectMake(65*kRate, 691*kRate, 30*kRate, 40*kRate) withText:@"1" withSize:13];
    _numLabel.textColor = UIColorFromRGB(0x848484);
    [self.view addSubview:_numLabel];
    CGFloat size = 18 * kRate;
    _numLabel2 = [_ui initializeLabelWithFrame:CGRectMake(391*kRate, 694*kRate, size, size) withText:nil withSize:9];
    _numLabel2.backgroundColor = UIColorFromRGB(0x40c8c4);

    _numLabel2.textColor = [UIColor whiteColor];
    
    _numLabel2.layer.borderWidth  = 1.0f;
    
    _numLabel2.layer.borderColor = UIColorFromRGB(0x40c8c4).CGColor;
    _numLabel2.layer.cornerRadius = size / 2;
    [_numLabel2.layer setMasksToBounds:YES];
    
    [self.view addSubview:_numLabel2];
    
}

- (void) setNavigationBar
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation_bar_background.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void) setButton
{
    CGFloat size = 40 * kRate;
    UIButton *subtractBtn = [[UIButton alloc] initWithFrame:CGRectMake(14*kRate, 691*kRate, size, size)];
    [subtractBtn setImage:[UIImage imageNamed:@"icon-减（商品详情页）.png"] forState:UIControlStateNormal];
    [subtractBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];

    subtractBtn.tag = 10;
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(106*kRate, 691*kRate, size, size)];
    [plusBtn setImage:[UIImage imageNamed:@"icon-加（商品详情页）.png"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(changeNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addShop = [_ui setButtonWithFrame:CGRectMake(160*kRate, 691*kRate, 200*kRate, size) withText:@"添加到购物车" withFont:13];
    [addShop addTarget:self action:@selector(addToShop:) forControlEvents:UIControlEventTouchUpInside];
    addShop.backgroundColor = UIColorFromRGB(0x40c8c4);
    [addShop setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addShop.layer.cornerRadius = 1;
    
    UIButton *shopBtn = [[UIButton alloc] initWithFrame:CGRectMake(373*kRate, 705*kRate, 23, 20)];
    [shopBtn setImage:[UIImage imageNamed:@"icon-购物车（商品详情页）.png"] forState:UIControlStateNormal];
    [shopBtn addTarget:self action:@selector(gotoShop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shopBtn];
    [self.view addSubview:subtractBtn];
    [self.view addSubview:plusBtn];
    [self.view addSubview:addShop];
    
    
}

- (void) gotoShop
{
    CartViewController *viewController = [[CartViewController alloc] init];
    viewController.cartArray = self.cartArray;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<_cartArray.count; i++) {
     [array addObject:[(DM_Commodity *)_cartArray[i] encodedItem]];
    }
    [_userDefaults setObject:array forKey:@"CartArray"];
}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   if (!(indexPath.row == 3)){
       
       if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
           [cell setSeparatorInset:UIEdgeInsetsZero];
       }
       
       if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
           [cell setLayoutMargins:UIEdgeInsetsZero];
       }
       if (!(indexPath.row == 1 || indexPath.row == 2))
       {
       cell.separatorInset = UIEdgeInsetsMake(0, 0, 0,cell.bounds.size.width);
       }

       
    }
    
    
}



- (void)changeNumber:(UIButton *)sender
{
    int num = [_numLabel.text intValue];
    if (sender.tag == 10) {
        
        if (num > 1) {
            num --;
        }
    }else
    {
        num ++;
    }
    _numLabel.text = [NSString stringWithFormat:@"%d", num];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)addToShop:(UIButton *)sender
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"添加购物车成功";
    hud.labelFont = [UIFont systemFontOfSize:11.0f];
    [hud hide:YES afterDelay:1.0f];
    
    _numLabel2.hidden = NO;
    
    BOOL isExist = NO;
    int i ;
    for ( i = 0; i<_cartArray.count; i++) {
        DM_Commodity *com = _cartArray[i];
        // 如果购物车中已有该商品
        if ([_commodity.nameKey isEqual:com.nameKey]) {
            isExist = YES;
            break;
            
        }else
        {
            
        }
    }
    if (isExist) {
        DM_Commodity *com = _cartArray[i];
        com.count = [NSString stringWithFormat:@"%d",([com.count intValue] + [_numLabel.text intValue])];
        
        [_cartArray replaceObjectAtIndex:i withObject:com];

    }else
    {
        _commodity.count = [NSString stringWithFormat:@"%d",([_commodity.count intValue] + [_numLabel.text intValue])];
        [_cartArray addObject:_commodity];

    }
    
    
    _numLabel2.text = [NSString stringWithFormat:@"%d", (int)_cartArray.count];
}
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    }else
     return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            RecipeCell *cell = [[RecipeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"recipeCell"];
            return cell;
        }else if (indexPath.row == 1)
        {
            TitleCell *cell = [[TitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            [cell setTitleLabel:_commodity.nameKey priceLabel:_commodity.priceKey deleteLabel:_commodity.deletePriceKey salesLabel:@"18"];
            
            return cell;
        }else if (indexPath.row == 2)
        {
            Cell2 *cell = [[Cell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell22"];
            
            return cell;
        }else if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 6)
        {
            imageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
            if (cell == nil) {
                cell = [[imageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];

            }
            NSString *name ;
            if (indexPath.row == 0) {
                name = @"大图1";
            }else if (indexPath.row == 4)
                name = @"备菜图";
            else
                name = @"detail";
            cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]];
            return cell;
        }else if (indexPath.row == 5)
        {
            Cell3 *cell = [[Cell3 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell3"];
            cell.textLabel.text = @"做法";
            cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-做法" ofType:@"png"]];
            return cell;

        }

    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"1";
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 394*kRate;
                break;
            case 1:
                return 60*kRate;
                break;
            case 2:
                return 83*kRate;
                break;
            case 3:
                return 140*kRate;
                break;
            case 4:
                return 374*kRate;
                break;
            case 5:
                return 40*kRate;
                break;
            case 6:
                return 619*kRate;
                break;
            default:
                return 40*kRate;
                break;
        }

    }else
        return 44;
    
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
