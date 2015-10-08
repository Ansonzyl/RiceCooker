//
//  EVegetableChooseViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EVegetableChooseViewController.h"

@interface EVegetableChooseViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UIPickerView *cookTypePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *materialPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *weightPickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *setTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *setFinishTimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cookTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *materialImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *finishTimeImageView;

@property (weak, nonatomic) IBOutlet UILabel *cookTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *materialLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;

@property (nonatomic, strong) UITapGestureRecognizer *ges1;
@property (nonatomic, strong) UITapGestureRecognizer *ges2;
@property (nonatomic, strong) UITapGestureRecognizer *ges3;
@property (nonatomic, strong) UITapGestureRecognizer *ges4;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, copy) NSString *finishTime;
@property (nonatomic, copy) NSString *selectMaterial;
@property (nonatomic, strong) NSDictionary *materialDic;
@property (nonatomic, strong) NSArray *materialArray;
//@property (nonatomic, strong) NSArray *weightArray;
//@property (nonatomic, strong) NSArray *setTimeArray;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (nonatomic, strong) NSString *setTime;
@end

@implementation EVegetableChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@背景1", _device.devicename] ofType:@".png"];
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

        self.backImage.image = [UIImage imageWithData:imageData];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EVegetablePickerViewList" ofType:@"plist"];
        _dic = [NSDictionary dictionaryWithContentsOfFile:path];
        _materialDic = [_dic objectForKey:@"material"];

    self.stateLabel.text = _device.module;
    
    dispatch_async(queue, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"MMddHH:mm"];
        NSDate *currentTime = [NSDate date];
        [_datePicker setMinimumDate:currentTime];
        NSDate *date = [currentTime initWithTimeIntervalSinceNow:32*60*60];
        [_datePicker setMaximumDate:date];
        [_datePicker addTarget:self
                        action:@selector(dateChange)
              forControlEvents:UIControlEventValueChanged];
        
    });
        
    NSArray  *array = [[_materialDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _selectMaterial = [array objectAtIndex:0];
    
    [self addGestureForImageViews];
    dispatch_async(queue, ^{
        [self initializeTheImageViewAndPickerView];
    });
    
    
}

- (void)dateChange
{
    _finishTime = [_dateFormatter stringFromDate:_datePicker.date];
    
    NSString *destString = [_finishTime substringFromIndex:4];
    
    self.finishTimeLabel.text = [NSString stringWithFormat:@"%@完成", destString];
}



- (void)addGestureForImageViews
{
    _cookTypeImageView.userInteractionEnabled = YES;
    _materialImageView.userInteractionEnabled = YES;
    _weightImageView.userInteractionEnabled = YES;
    _finishTimeImageView.userInteractionEnabled = YES;
    
    _ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingleTap:)];
    [_cookTypeImageView addGestureRecognizer:_ges1];
    
    _ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingleTap:)];
    [_materialImageView addGestureRecognizer:_ges2];
    
    _ges3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingleTap:)];
    [_weightImageView addGestureRecognizer:_ges3];
    
    _ges4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingleTap:)];
    [_finishTimeImageView addGestureRecognizer:_ges4];
    
}

- (void) initializeTheImageViewAndPickerView
{
    switch (_currentTag) {
        case 0:
            [self optionSingleTap:_ges1];
            break;
        case 1:
            [self optionSingleTap:_ges2];
            break;
        case 2:
            [self optionSingleTap:_ges3];
            break;
        case 3:
            [self optionSingleTap:_ges4];
            break;
            
        default:
            break;
    }
}


- (void)optionSingleTap:(UIGestureRecognizer *)ges
{
    
    _cookTypeImageView.highlighted = NO;
    _materialImageView.highlighted = NO;
    _weightImageView.highlighted = NO;
    _finishTimeImageView.highlighted = NO;
    
    _setFinishTimeLabel.hidden = YES;
    _setTimeLabel.hidden = YES;
    _cookTypePickerView.hidden = YES;
    _materialPickerView.hidden = YES;
    _weightPickerView.hidden = YES;
    _datePicker.hidden = YES;
    _timePicker.hidden = YES;
    
    if (ges == _ges1) {
        _cookTypeImageView.highlighted = YES;
        _cookTypePickerView.hidden  = NO;
        _contentLabel.text = @"烹饪方式";
    }else if (ges == _ges2)
    {
        _materialImageView.highlighted = YES;
        _materialPickerView.hidden = NO;
        _contentLabel.text = @"食材选择";
    }else if (ges == _ges3)
    {
        _weightImageView.highlighted = YES;
        _weightPickerView.hidden = NO;
        _contentLabel.text = @"食材重量";
        
    }else if (ges == _ges4)
    {
        _finishTimeImageView.highlighted = YES;
        _datePicker.hidden = NO;
        _timePicker.hidden = NO;
        _contentLabel.text = @"预约完成时间";
        _setFinishTimeLabel.hidden = NO;
        _setTimeLabel.hidden = NO;
    }
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == _cookTypePickerView) {
        return 1;
    }else if (pickerView == _materialPickerView )
    {
        return 4;
    }else
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *array;
    array = [self contentOfPickerView:pickerView];
    
    if (pickerView == _materialPickerView) {
        if (component == 2) {
            return [[_materialDic objectForKey:_selectMaterial] count];
        }
    }else if ([pickerView isEqual:_weightPickerView] || [pickerView isEqual:_timePicker])
    {
        if (component == 2) {
            return 1;
        }else
            return array.count;
    }
    
    return array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array;
    array = [self contentOfPickerView:pickerView];
    if (array >= 0)
    {
        if (pickerView == _timePicker || pickerView == _weightPickerView) {
            if (component == 0) {
                return nil;
            }else if (component == 1)
            {
                return array[row];
            }else
            {
                if ([pickerView isEqual:_timePicker]) {
                    return @"分钟";
                }else
                    return @"g";
            }
        }else if ([pickerView isEqual:_materialPickerView])
        {
            if (component == 1) {
                return [array objectAtIndex:row];
            }else if (component == 2)
                return [[_materialDic objectForKey:_selectMaterial] objectAtIndex:row];
            else
                return nil;
        }else
            return array[row];
    }else
        return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 32;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *array = [self contentOfPickerView:pickerView];
    NSString *str = [array objectAtIndex:row];
    if (array.count > 0) {
        if ([pickerView isEqual:_cookTypePickerView]) {
            _cookTypeLabel.text = str;
        }else if ([pickerView isEqual:_weightPickerView])
        {
            _weightLabel.text = [NSString stringWithFormat:@"%@g",str];
        }else if ([pickerView isEqual:_materialPickerView])
        {
            if (component == 1) {
                 _selectMaterial = [array objectAtIndex:row];
                [_materialPickerView reloadComponent:2];
                
                NSString *temp = [[_materialDic objectForKey:_selectMaterial] objectAtIndex:0];
                
                _materialLabel.text = temp;

            }else
            {
                NSString *temp = [[_materialDic objectForKey:_selectMaterial] objectAtIndex:row];
                
                _materialLabel.text = temp;
            }
        }else
        {
            _setTime = array[row];
        }

    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *retval = (id)view;
    if (!retval) {
        retval = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
        
    }
    retval.textColor = UIColorFromRGB(0x636363);
    if ([pickerView isEqual:_weightPickerView] || [pickerView isEqual:_timePicker])
    {
        if (component == 1) {
            retval.textAlignment = NSTextAlignmentRight;
            retval.font = [UIFont systemFontOfSize:26];
        }else
        {
            retval.textAlignment = NSTextAlignmentLeft;
            retval.font = [UIFont systemFontOfSize:15];
        }
    }else
    {
        retval.textAlignment = NSTextAlignmentCenter;
        retval.font = [UIFont systemFontOfSize:21];
        
    }
    retval.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return retval;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = CGRectGetHeight(pickerView.frame);
    CGFloat center = 80;
    if (pickerView == _cookTypePickerView) {
        return width;
    }else if ([pickerView isEqual:_materialPickerView])
        return width/2;
    else if ([pickerView isEqual:_weightPickerView])
    {
        if (component == 1 || component == 2) {
            return center;
        }else
            return (width - center)/2;
    }else if ([pickerView isEqual:_weightPickerView])
    {
        if (component == 1) {
            return 50;
        }else
            return 100;
    }else
    {
        if (component == 1) {
            return 50;
        }else if (component == 0)
        {
            return 10;
        }else
            return 50;
    }
}


- (NSArray *)contentOfPickerView:(UIPickerView *)pickerView
{
    NSArray *array;
    if ([pickerView isEqual:_cookTypePickerView]) {
        array = [_dic objectForKey:@"cookType"];
    }else if ([pickerView isEqual:_timePicker])
    {
        array = [_dic objectForKey:@"setTime"];
    }else if ([pickerView isEqual:_weightPickerView])
    {
        array = [_dic objectForKey:@"weight"];
    }else if ([pickerView isEqual:_materialPickerView])
    {
        array = [[_materialDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        
        
    }
    return array;
    
}

- (IBAction)startCooking:(UIButton *)sender {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    NSString *urlStr = [NSString stringWithFormat: @"http://%@/Reciveservlet", SERVER_URL];
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *parameters = @{@"phonenumber" : self.device.phonenumber,
//                                 @"device" : self.device.device,
//                                 @"pnumberweight" : self.weightLabel.text,
//                                 @"degree" : self.cookTypeLabel.text,
//                                 @"state" : self.materialLabel.text,
//                                 @"devicename" : self.device.devicename,
//                                 @"finishtime" : self.finishTime,
//                                 @"UUID" : self.device.UUID
//                                 };
//
//    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",recieve);
//        if ([recieve isEqualToString:@"start"]) {
//            [self changeDevice];
//            [_delegate changeDevice:_device withIndex:_currentIndex];
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"为设置成功\n请重新设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self showTopMessage:@"连接不上服务器"];
//    }];
    
    
    [self changeDevice];
    [_delegate changeDevice:_device withIndex:_currentIndex];
    [self.navigationController popViewControllerAnimated:YES];


    
}

- (void)changeDevice
{
    _device.state = self.materialLabel.text;
    _device.degree = self.cookTypeLabel.text;
    _device.pnumberweight = _weightLabel.text;
    _device.appointTime =  _finishTimeLabel.text;
    _device.finishtime = [NSMutableString stringWithString:self.finishTime];
    _device.module = @"烹饪中";
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
