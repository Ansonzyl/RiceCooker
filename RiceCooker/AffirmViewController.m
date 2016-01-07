//
//  AffirmViewController.m
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "AffirmViewController.h"
#import "BuyController.h"
#import "AddressCell.h"
#import "DM_Commodity.h"
#import "Cell4.h"
#import "Cell5.h"
#import "Cell6.h"
#import "Cell7.h"
#import "Cell8.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface AffirmViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *totlePirceLabel;
@property (strong, nonatomic) IBOutlet UIButton *affirmBtn;
@property (nonatomic, strong) NSMutableArray *timeArray;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIView *timePickerView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) UIControl *overlay;
@property (nonatomic, copy) NSString *deliveryTime;
@property (nonatomic, strong) NSArray *dateArray;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, copy) NSString *selectDate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *remarks;
@end

@implementation AffirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilizeArray];
    self.title = @"确认订单";
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];

    [self setLabel];
    
    _deliveryTime = @"未选择时间";
    [self setPickerView];
}


// 初始化数组
- (void)initilizeArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"date" ofType:@"plist"];
    _timeArray = [NSMutableArray arrayWithContentsOfFile:path];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];

    // 大于21:30点 明天送
    if (hour < 21 || (hour > 21 && minute < 30))
    {
        _dateArray = @[@"今天", @"明天"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:_timeArray];
        if (hour > 10) {
            NSInteger time = (hour-10) * 60 + minute;
            NSInteger i = time / 30 + 1;
            [array removeObjectsInRange:NSMakeRange(0, i)];
        }
        _dic = @{@"今天": array,
                 @"明天": _timeArray
                 };
    }else
    {
        _dateArray = @[@"明天"];
        _dic = [NSDictionary dictionaryWithObjectsAndKeys:_timeArray,@"明天", nil];
        
    }
    _selectDate = _dateArray[0];
}



- (void) setPickerView
{
    _timePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRate * 393, 316 * kRate)];
    _timePickerView.center = CGPointMake(kWidth / 2, kHeight / 2);
    _timePickerView.backgroundColor = [UIColor whiteColor];
    _timePickerView.layer.cornerRadius = 4;
    CGFloat size = 22 * kRate;
    CGFloat height = 14 * kRate;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(116 * kRate, height, size, size)];
    image.image = [UIImage imageNamed:@"icon-做法.png"];
    [self.timePickerView addSubview:image];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(155*kRate, height, 200 * kRate, 22 *kRate)];
    label.text = @"营业时间 10:00-21:00";
    label.textColor = UIColorFromRGB(0x535353);
    label.font = [UIFont systemFontOfSize:11 *kRate];
    [self.timePickerView addSubview:label];
    CGFloat width = CGRectGetWidth(_timePickerView.frame);
    height = 50 * kRate;
    CGRect frame = CGRectMake(0, height, width, 1);
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height, width, 211 * kRate)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [_timePickerView addSubview:_pickerView];
    UIView *line1 = [[UIView alloc] initWithFrame:frame];
    line1.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.timePickerView addSubview:line1];

    frame.origin.y = 264*kRate;
    UIView *line2 = [[UIView alloc] initWithFrame:frame];
    line2.backgroundColor = line1.backgroundColor;
    [_timePickerView addSubview:line2];
    height = 50 * kRate;
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.origin.y, width/2, height)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:UIColorFromRGB(0x848484) forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(dismissDatePicek:) forControlEvents:UIControlEventTouchUpInside];
    cancel.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UIButton *affirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2, frame.origin.y, width/2, height)];
    affirmBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [affirmBtn setTitle:@"确定送达时间" forState:UIControlStateNormal];
    [affirmBtn setTitleColor:UIColorFromRGB(0x40c8c4) forState:UIControlStateNormal];
    [affirmBtn addTarget:self action:@selector(dismissDatePicek:) forControlEvents:UIControlEventTouchUpInside];
    [self.timePickerView addSubview:cancel];
    [self.timePickerView addSubview:affirmBtn];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(width/2, frame.origin.y, 1, height)];
    line3.backgroundColor = line2.backgroundColor;
    [self.timePickerView addSubview:line3];
}

- (void)dismissDatePicek:(UIButton *)sender
{
    [UIView beginAnimations:@"out" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView animateWithDuration:0.25 animations:^{
        _timePickerView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_timePickerView removeFromSuperview];
        [_overlay removeFromSuperview];
    }];
    if ([sender.titleLabel.text isEqualToString: @"确定送达时间"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Cell4 *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"%@", cell.textLabel.text);
        _deliveryTime = _content;
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    

    
}


- (void)setLabel
{
    _subView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight - 49*kRate , CGRectGetWidth(self.view.frame), 49 * kRate)];
    _subView.backgroundColor = [UIColor whiteColor];
        UILabel *commodityLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 87*kRate, 49*kRate)];
    commodityLabel.text = @"商品总价";
    commodityLabel.textColor = UIColorFromRGB(0x505050);
    commodityLabel.font = [UIFont systemFontOfSize:13];
    [_subView addSubview:commodityLabel];
    _totlePirceLabel = [[UILabel alloc] initWithFrame:CGRectMake(211*kRate, 0, 59*kRate, 49 *kRate)];
    _totlePirceLabel.textColor = UIColorFromRGB(0x40C8C4);
    _totlePirceLabel.font = [UIFont systemFontOfSize:13*kRate];
    _totlePirceLabel.textAlignment = NSTextAlignmentRight;
    _totlePirceLabel.text = _totolPrice;
    [_subView addSubview:_totlePirceLabel];
    
    _affirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(294*kRate, 4, 105*kRate, 40*kRate)];
    _affirmBtn.backgroundColor = UIColorFromRGB(0x40C8C4);
    [_affirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _affirmBtn.titleLabel.font = _totlePirceLabel.font;
    _affirmBtn.layer.cornerRadius = 2;
    [_affirmBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    [_affirmBtn addTarget:self action:@selector(pushToNextView:) forControlEvents:UIControlEventTouchUpInside];
    [_subView addSubview:_affirmBtn];
//    [self.navigationController.view insertSubview:_subView aboveSubview:self.tableView];

    
}







- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.view insertSubview:_subView aboveSubview:self.tableView];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.subView removeFromSuperview];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _affirmArray.count + 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddressCell *cell = [AddressCell addressCell];
        cell.select.image = [UIImage imageNamed:@"icon-地址.png"];
        cell.userMessage = _userMsg;
        
        return cell;

    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            Cell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            if (cell == nil) {
                cell = [[Cell4 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell4"];
            }
            cell.detailTextLabel.text = _deliveryTime;
            cell.imageView.image = [UIImage imageNamed:@"icon-期望送达时间.png"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if(indexPath.row == 1)
        {
            Cell5 *cell = [[Cell5 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell5"];
            //            cell.imageView.image = [UIImage imageNamed:@"icon-期望送达时间.png"];
            cell.totolLabel.text = _totolPrice;
            cell.weightLabel.text = [NSString stringWithFormat:@"%dKG", _weight];
            return cell;
        }else
        {
            Cell6 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell6"];
            if (cell == nil) {
                cell = [[Cell6 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell6"];
            }
            if (indexPath.row == _affirmArray.count + 2) {
                cell.titleLabel.text = @"配送费";
                cell.priceLabel.text = @"免费";
                cell.priceLabel.textColor = UIColorFromRGB(0x848484);
            }else
            {
                DM_Commodity *commodity = _affirmArray[indexPath.row - 2];
                cell.titleLabel.text = commodity.nameKey;
                cell.countLabel.text = [NSString stringWithFormat:@"×%@", commodity.count];
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", commodity.priceKey];
            }
            return cell;
        }
        
    }else if (indexPath.section == 2)
    {
        Cell7 *cell = [[Cell7 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell7"];
        cell.commodityPrice.text = _totolPrice;
        cell.packingFee.text = @"+ ¥0";
        cell.discount.text = @"- ¥0";
        cell.totalPrice.text = _totolPrice;
        return cell;
    }else
    {
        Cell8 *cell = [[Cell8 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell8"];
        cell.textFiled.delegate = self;
        cell.textFiled.returnKeyType = UIReturnKeyDone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        if (indexPath.row == 1 ) {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:UIEdgeInsetsZero];
            }
            
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, 54, 0, cell.bounds.size.width)];
            }

        }else if (indexPath.row == 0)
        {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
               
                [cell setSeparatorInset:UIEdgeInsetsMake(0, 54, 0, 0)];
               
            }
            
        }else
        {
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0,0);
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self popPickerView];
            return;

        }
    }
        [self.view endEditing:YES];
}


- (void)popPickerView
{
    _overlay = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    _overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.navigationController.view insertSubview:_overlay aboveSubview:self.tableView];
    [self.navigationController.view insertSubview:_timePickerView aboveSubview:self.tableView];
    _timePickerView.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    _timePickerView.alpha = 1.0;
    [UIView commitAnimations];
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 57;
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                return 43;
                break;
            case 1:
                return 35;
                break;
            default:
                return 26;
                break;
        }
        
        
    }else if(indexPath.section == 2)
    {
        return 78;
    }else
        return 44;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return @"结算";
    }else if (section == 3)
    {
        return @"备注";
    }else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2 || section == 1) {
        return 0.6;
    }else if (section == 3)
    {
        return 49;
    }
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        return 43;
    }else  if (section == 0)
    {
        return 0.1;
    }else
        return 6;
}


#pragma mark pickerViewdatasource
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _dateArray.count;
    }else
    {
        NSArray *array = [_dic objectForKey:_selectDate];
        return array.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _dateArray[row];
    }else if (component == 1)
    {
        NSArray *array = [_dic objectForKey:_selectDate];
        return [array objectAtIndex:row];
    }else
        return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _selectDate = [_dateArray objectAtIndex:row];
        [self.pickerView reloadComponent:1];
    }
    NSArray *array = [_dic objectForKey:_selectDate];
    _content = [NSString stringWithFormat:@"%@%@", _selectDate,array[row]];
    NSLog(@"%@", _content);
    
    
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 46*kRate;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval) {
        retval = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
        
    }
    retval.textColor = UIColorFromRGB(0x535353);
    retval.textAlignment = NSTextAlignmentCenter;
    if (component == 1) {
        retval.textAlignment = NSTextAlignmentLeft;
    }
    retval.font = [UIFont systemFontOfSize:21 * kRate];
    retval.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return retval;
}


#pragma mark ----UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _remarks = textField.text;
    NSLog(@"%@", _remarks);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)pushToNextView:(id)sender {
    BuyController *viewController = [[BuyController alloc] initWithNibName:@"BuyController" bundle:nil];
    [self.subView removeFromSuperview];
    viewController.userMsg = self.userMsg;
    viewController.affirmArray = self.affirmArray;
    viewController.cartArray = self.cartArray;
    viewController.remarks = self.remarks;
    viewController.deliveryTime = self.deliveryTime;
    viewController.totalPrice = [NSMutableString stringWithString: self.totolPrice];
    [self.navigationController pushViewController:viewController animated:YES];
    
}
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"营业时间10:00－21：00" message:@"\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定送达时间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            }];
//            UIPickerView *pickerView = [[UIPickerView alloc] init];
//
//            [alert addAction:cancel];
//            [alert addAction:ok];
//            [self presentViewController:alert animated:YES completion:^{
//
//            }];


@end
