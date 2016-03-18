//
//  EVegetableChooseViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EVegetableChooseViewController.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414

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

@property (strong, nonatomic) IBOutlet UIImageView *cookTypeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *materialImageView;
@property (strong, nonatomic) IBOutlet UIImageView *weightImageView;
@property (strong, nonatomic) IBOutlet UIImageView *finishTimeImageView;

@property (strong, nonatomic) IBOutlet UILabel *cookTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *materialLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *finishTimeLabel;

@property (nonatomic, strong) UITapGestureRecognizer *ges1;
@property (nonatomic, strong) UITapGestureRecognizer *ges2;
@property (nonatomic, strong) UITapGestureRecognizer *ges3;
@property (nonatomic, strong) UITapGestureRecognizer *ges4;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, copy) NSString *finishTime;
@property (nonatomic, copy) NSString *selectMaterial;
@property (nonatomic, strong) NSDictionary *materialDic;
@property (nonatomic, strong) NSArray *materialArray1;
@property (nonatomic, strong) NSArray *weightArray;
@property (nonatomic, strong) NSArray *setTimeArray;
@property (nonatomic, strong) NSArray *cookTypeArray;
@property (nonatomic, strong) NSArray *materialArray2;
@property (nonatomic, assign) NSInteger setTime;
//@property (nonatomic, strong) NSDate *currentTime;
@property (nonatomic, copy) NSString *weight;
//@property (nonatomic, copy)
@end

@implementation EVegetableChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    [self recieveArray];
    [self initializeImageAndLabelText];
    [self setAllArray];

    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@背景1", _device.devicename] ofType:@".png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

    self.backImage.image = [UIImage imageWithData:imageData];

    
    [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:_device.settingTime + 60]];


    [_datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:24*60*60]];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MMddHH:mm"];
    [_datePicker addTarget:self
                    action:@selector(dateChange)
          forControlEvents:UIControlEventValueChanged];
    _finishTime = self.device.finishtime;
        

    _selectMaterial = [_materialArray1 objectAtIndex:0];
    
    [self addGestureForImageViews];
 
    [self initializeTheImageViewAndPickerView];
    
    
    
}

- (void)recieveArray
{
    NSString *urlStr = [NSString stringWithFormat: @"http://%@/SendToApp", SERVER_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *recieve = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *array = [recieve componentsSeparatedByString:@";"];
    _setTimeArray = [array[0] componentsSeparatedByString:@","];
    _weightArray = [array[1] componentsSeparatedByString:@","];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:[NSString stringWithFormat: @"http://%@/SendToApp", SERVER_URL]; parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//    } failure:<#^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)failure#>]
}

- (void)setAllArray
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EVegetablePickerViewList" ofType:@"plist"];
    _dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    _materialDic = [_dic objectForKey:@"material"];
    _cookTypeArray = [_dic objectForKey:@"cookType"];
    if (!_setTimeArray) {
        _setTimeArray = [_dic objectForKey:@"setTime"];
    }
    if (!_weightArray) {
        _weightArray = [_dic objectForKey:@"weight"];
    }
    
    _materialArray1 = [[_materialDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (void)dateChange
{
    _finishTime = [_dateFormatter stringFromDate:_datePicker.date];
    
    NSString *destString = [_finishTime substringFromIndex:4];
    
    self.finishTimeLabel.text = [NSString stringWithFormat:@"%@完成", destString];
}


- (void) initializeImageAndLabelText
{
    
    CGFloat size = 51*kRate;
    CGFloat height = 571 * kRate;
    
    _cookTypeImageView = [self setImageViewWithFrame:CGRectMake(41*kRate, height, size, size) withImage:@"icon-e菜宝烹饪方式（152）.png" withHighlightedImage:@"icon-e菜宝-烹饪方式选中（152）.png"];
    _materialImageView = [self setImageViewWithFrame:CGRectMake(136*kRate, height, size, size) withImage:@"icon-e菜宝食材（152）.png" withHighlightedImage:@"icon-e菜宝-食材选中（152）.png"];
    _weightImageView = [self setImageViewWithFrame:CGRectMake(229*kRate, height, size, size) withImage:@"icon-e菜宝重量（152）.png" withHighlightedImage:@"icon-e菜宝-重量选中（152）.png"];
    _finishTimeImageView = [self setImageViewWithFrame:CGRectMake(322*kRate, height, size, size) withImage:@"icon-e饭宝-预约（152）.png" withHighlightedImage:@"icon-e饭宝-预约选中（152）.png"];
    
    CGRect frame = CGRectMake(0, 0, 100*kRate, 21*kRate);
    size = 12 * kRate;
    
    _cookTypeLabel = [self setLabelWithFrame:frame withText:_device.degree withSize:size withColor:[UIColor blackColor]];
    _cookTypeLabel.center = [self makeCenterWithPoint:_cookTypeImageView.center];
    
    _materialLabel = [self setLabelWithFrame:frame withText:_device.state withSize:size withColor:[UIColor blackColor]];
    _materialLabel.center = [self makeCenterWithPoint:_materialImageView.center];
    
    _weightLabel = [self setLabelWithFrame:frame withText:_device.pnumberweight withSize:size withColor:[UIColor blackColor]];
    _weightLabel.center = [self makeCenterWithPoint:_weightImageView.center];
    
    _finishTimeLabel = [self setLabelWithFrame:frame withText:_device.appointTime withSize:size withColor:[UIColor blackColor]];
    _finishTimeLabel.center = [self makeCenterWithPoint:_finishTimeImageView.center];
    
    UILabel *stateLabel = [self setLabelWithFrame:CGRectMake(0, 106*kRate, kRate*414, kRate*58) withText:self.device.module withSize:26*kRate withColor:[UIColor whiteColor]];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.view addSubview:_finishTimeLabel];
        [self.view addSubview:_weightLabel];
        [self.view addSubview:_materialLabel];
       
        [self.view addSubview:stateLabel];
        
        [self.view addSubview:_cookTypeImageView];
        [self.view addSubview:_materialImageView];
        [self.view addSubview:_finishTimeImageView];
        [self.view addSubview:_weightImageView];
        
        
        [self.view addSubview:_cookTypeLabel];
    });
    
    
}


- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 50*kRate;
    return point;
}



- (UIImageView *)setImageViewWithFrame:(CGRect)frame withImage:(NSString *)imageName withHighlightedImage:(NSString *)highlightedImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.highlightedImage = [UIImage imageNamed:highlightedImage];
    return imageView;
}


- (UILabel *)setLabelWithFrame:(CGRect)frame  withText:(NSString *)text withSize:(CGFloat)size withColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:size];
    
    label.textColor = textColor;
    label.text = text;
    return label;
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
//    _cookTypeLabel.text = _cookTypeArray[0];
    [_cookTypePickerView selectRow:[_cookTypeArray indexOfObject:_device.degree] inComponent:0 animated:YES ];
    _weight = [_weightLabel.text substringToIndex:3];
//    _weightLabel.text = [NSString stringWithFormat:@"%@g", _weight];
    [_weightPickerView selectRow:[_weightArray indexOfObject:_weight]inComponent:0 animated:YES];
    _setTime = [_device.settime integerValue];
    if (!_setTime) {
        _setTime = [_setTimeArray[0] integerValue];
    }
    [_timePicker selectRow:[_setTimeArray indexOfObject:[NSString stringWithFormat:@"%ld", (long)_setTime]] inComponent:0 animated:YES];

    [self dateChange];
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
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if ([pickerView isEqual:_cookTypePickerView]) {
        return  _cookTypeArray.count;
        
    }else if ([pickerView isEqual:_timePicker])
    {
        if (component == 1) {
            return 1;
        }else
            return _setTimeArray.count;
    }else if ([pickerView isEqual:_weightPickerView])
    {
        if (component == 1) {
            return 1;
        }else
            return _weightArray.count;
    }else if ([pickerView isEqual:_materialPickerView])
    {
        if (component == 2) {
            return [[_materialDic objectForKey:_selectMaterial] count];
        }else
           return _materialArray1.count;
    }
    return 0;
    
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([pickerView isEqual:_cookTypePickerView]) {
        return _cookTypeArray[row];
        
    }else if (pickerView == _timePicker || pickerView == _weightPickerView) {
        if (component == 0)
        {
            if ([pickerView isEqual:_timePicker])
            {
                return _setTimeArray[row];
            }else
                return _weightArray[row];
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
            return [_materialArray1 objectAtIndex:row];
        }else if (component == 2)
            return [[_materialDic objectForKey:_selectMaterial] objectAtIndex:row];
        else
            return nil;

    }
    return nil;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 32;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        if ([pickerView isEqual:_cookTypePickerView]) {
            _cookTypeLabel.text = [_cookTypeArray objectAtIndex:row];
        }else if ([pickerView isEqual:_weightPickerView])
        {
            _weight = [NSString stringWithFormat:@"%@",[_weightArray objectAtIndex:row]];
            _weightLabel.text = [NSString stringWithFormat:@"%@g",_weight];
        }else if ([pickerView isEqual:_materialPickerView])
        {
            if (component == 1) {
                 _selectMaterial = [_materialArray1 objectAtIndex:row];
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
            _setTime = [_setTimeArray[row] integerValue];
            [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:(_setTime + 1)*60]];
            [_datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:(_setTime + 1)*60]animated:YES];
            
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
        if (component == 0) {
            retval.textAlignment = NSTextAlignmentRight;
            retval.font = [UIFont systemFontOfSize:26 * kRate];
        }else
        {
            retval.textAlignment = NSTextAlignmentLeft;
            retval.font = [UIFont systemFontOfSize:15 * kRate];
        }
    }else
    {
        retval.textAlignment = NSTextAlignmentCenter;
        retval.font = [UIFont systemFontOfSize:21 * kRate];
        
    }
    retval.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return retval;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = CGRectGetWidth(pickerView.frame)*kRate;
//    CGFloat center = 40*kRate;
    if (pickerView == _cookTypePickerView) {					
        return width;
    }else if ([pickerView isEqual:_materialPickerView])
    {
        if (component == 1 ) {
            return width*9/20;
        }else if(component == 2 )
        {
            return width*9 / 20;
        }else
            return width/10;
        
    }
    else if ([pickerView isEqual:_weightPickerView])

    {
        if (component == 0) {
            return width/2 + 20;
        }else
            return width/2 - 20;
    }
    else
    {
        if (component == 0) {
            return 50*kRate;
//        }else if (component == 0)
//        {
//            return 10*kRate;
        }else
            return 50*kRate;
    }
}




- (IBAction)startCooking:(UIButton *)sender {
    
    if ([self isFinishTimeGreaterThanSetTime]) {
        [self startCookNetWork];
    }else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息" message:@"烹饪时间不足,请重新设置" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    
}

- (void)startCookNetWork
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlStr = [NSString stringWithFormat: @"http://%@/Reciveservlet", SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *parameters = @{@"phonenumber" : self.device.phonenumber,
                                 @"device" : self.device.device,
                                 @"pnumberweight" : _weight,
                                 @"degree" : self.cookTypeLabel.text,
                                 @"state" : self.materialLabel.text,
                                 @"devicename" : self.device.devicename,
                                 @"finishtime" : self.finishTime,
                                 @"UUID" : self.device.UUID,
                                 @"settime" : [NSString stringWithFormat:@"%ld", (long)_setTime]
                                 };
    
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",recieve);
        if ([recieve isEqualToString:@"evegetablestart"]) {
            [self changeDevice];
            [_delegate changeDevice:_device withIndex:_currentIndex];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息" message:@"预约成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];

            
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息" message:@"设置失败,请重新设置" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self showTopMessage:@"连接不上服务器"];
    }];

}


- (void)changeDevice
{
    _device.module = @"预约中";
    _device.state = self.materialLabel.text;
    _device.degree = self.cookTypeLabel.text;
    _device.pnumberweight = _weightLabel.text;
    _device.appointTime =  _finishTimeLabel.text;
    _device.finishtime = [NSMutableString stringWithString:self.finishTime];
    if ( [self timeOfInsulation] > _setTime && [self timeOfInsulation] < self.setTime + 60)
    {
    _device.module = @"烹饪中";
    }
    _device.settingTime = self.setTime;
    _device.remianTime = [self isFinishTimeGreaterThanSetTime];
    
}

// 判断完成时间是否大于设置时间


- (BOOL)isFinishTimeGreaterThanSetTime
{
    
    if ([self timeOfInsulation] <= self.setTime*61) {
        return NO;
    }else
        return YES;
    
    
}

- (int)timeOfInsulation
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddHH:mm"];
    NSDate *finish = [formatter dateFromString:_finishTime];
    NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    int time = [finish timeIntervalSinceDate:now];
    return time;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
