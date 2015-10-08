//
//  ERiceChooseViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "ERiceChooseViewController.h"
#define kRate [UIScreen mainScreen].bounds.size.width/414

@interface ERiceChooseViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *pNumber;


@property (weak, nonatomic) IBOutlet UIImageView *fireImage;
@property (weak, nonatomic) IBOutlet UIImageView *cookModeImage;
@property (weak, nonatomic) IBOutlet UIImageView *finishTimeImage;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fireLabel;

@property (weak, nonatomic) IBOutlet UILabel *cookModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *pNumberPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *firePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *cookModePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;


@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UITapGestureRecognizer *ges1;
@property (nonatomic, strong) UITapGestureRecognizer *ges2;
@property (nonatomic, strong) UITapGestureRecognizer *ges3;
@property (nonatomic, strong) UITapGestureRecognizer *ges4;
@property (nonatomic, strong) NSString *contentStr;

@property (nonatomic, strong) NSString *finishTime;

@end

@implementation ERiceChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ERicePickerViewList" ofType:@"plist"];
        _dic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        
        NSDate *currentTime = [NSDate date];
        [_datePicker setMinimumDate:currentTime];
        
        NSDate *date = [currentTime initWithTimeIntervalSinceNow:32*60*60];
        [_datePicker setMaximumDate:date];
        [_datePicker addTarget:self
                        action:@selector(dateChange)
              forControlEvents:UIControlEventValueChanged];
        [_dateFormatter setDateFormat:@"MMddHH:mm"];

        
    });
    
    [self setImageAndLabelText];
    
    dispatch_async(queue, ^{
        self.pNumberLabel.text = _device.pnumberweight;
        self.fireLabel.text = _device.state;
        self.cookModeLabel.text = _device.degree;
        self.finishTimeLabel.text = _device.appointTime;
    });
    
    
    
    
   
        [self addGestureForImageViews];
    
    
    dispatch_async(queue, ^{
        [self initializeTheImageViewAndPickerView];
    });
    
        [_firePickerView selectRow:[self contentOfPickerView:_firePickerView].count/2 inComponent:0 animated:YES];
    
    //    [_cookModePickerView selectRow:[self contentOfPickerView:_cookModePickerView].count/2  inComponent:0 animated:YES];
    
    [_cookModePickerView selectRow:[[self contentOfPickerView:_cookModePickerView] indexOfObject:_device.degree] inComponent:0 animated:YES];
    
    
}

- (void)dateChange
{
    
    _finishTime = [_dateFormatter stringFromDate:_datePicker.date];
    
    NSString *destString = [_finishTime substringFromIndex:4];
    
   self.finishTimeLabel.text = [NSString stringWithFormat:@"%@完成", destString];
    
   }


- (void)setImageAndLabelText
{
    CGFloat size = 51*kRate;
    CGFloat height = 571 * kRate;
    _pNumber = [self setImageViewWithFrame:CGRectMake(41*kRate, height, size, size) withImage:@"icon-e饭宝-米量（152）.png" withHighlightedImage:@"icon-e饭宝-米量选中（152）.png"];
//    _fireImage = [self setImageViewWithFrame:CGRectMake(136*kRate, height, size, size) withImage:@"icon-e饭宝-烹饪方式（152）.png" withHighlightedImage:@"icon-e饭宝-烹饪方式选中（152）.png"];
//    _cookModeImage = [self setImageViewWithFrame:CGRectMake(229*kRate, height, size, size) withImage:@"icon-e饭宝-口感（152）.png" withHighlightedImage:@"icon-e饭宝-口感选中（152）.png"];
//    _finishTimeImage = [self setImageViewWithFrame:CGRectMake(322*kRate, height, size, size) withImage:@"icon-e饭宝-预约（152）.png" withHighlightedImage:@"icon-e饭宝-预约选中（152）.png"];
    
    CGRect frame = CGRectMake(0, 0, 60*kRate, 21*kRate);
    size = 12 * kRate;
    _pNumberLabel = [self setLabelWithFrame:frame withText:_device.pnumberweight withSize:size withColor:[UIColor whiteColor]];
    
    
    
    
    
    
    [self.view addSubview:_pNumber];
    [self.view addSubview:_fireImage];
    [self.view addSubview:_cookModeImage];
    [self.view addSubview:_finishTimeImage];
    
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
    label.textAlignment =  NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:size];
    
    label.textColor = textColor;
    label.text = text;
    return label;
}






- (void) initializeTheImageViewAndPickerView
{
    switch (_currentTag) {
        case 0:
            [self optionSingletap:_ges1];
            break;
        case 1:
            [self optionSingletap:_ges2];
            break;
        case 2:
            [self optionSingletap:_ges3];
            break;
        case 3:
            [self optionSingletap:_ges4];
//            [self dateChange];
            break;
            
        default:
            break;
    }
}


- (void)addGestureForImageViews
{
    _pNumber.userInteractionEnabled = YES;
    _fireImage.userInteractionEnabled = YES;
    _cookModeImage.userInteractionEnabled = YES;
    _finishTimeImage.userInteractionEnabled = YES;
    
    _ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingletap:)];
    [_pNumber addGestureRecognizer:_ges1];
    _ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingletap:)];
    [_fireImage addGestureRecognizer:_ges2];
    _ges3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingletap:)];
    [_cookModeImage addGestureRecognizer:_ges3];
    _ges4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(optionSingletap:)];
    
    
    [_finishTimeImage addGestureRecognizer:_ges4];

}


- (void)optionSingletap:(UITapGestureRecognizer *)ges
{
    _pNumber.highlighted = NO;
    _fireImage.highlighted = NO;
    _cookModeImage.highlighted = NO;
    _finishTimeImage.highlighted = NO;
    
    _pNumberPickerView.hidden = YES;
    _firePickerView.hidden = YES;
    _cookModePickerView.hidden = YES;
    _datePicker.hidden = YES;
    
    if (ges == _ges1) {
        _pNumber.highlighted = YES;
        _pNumberPickerView.hidden = NO;
        self.chooseLabel.text = @"米量";
        [_pNumberPickerView selectRow:[[self contentOfPickerView:_pNumberPickerView] indexOfObject:[self.pNumberLabel.text substringToIndex:1]] inComponent:1 animated:YES];

        
    }else if (ges == _ges2)
    {
        _fireImage.highlighted = YES;
        _firePickerView.hidden = NO;
        self.chooseLabel.text = @"烹饪方式";
    }else if (ges == _ges3)
    {
        _cookModeImage.highlighted = YES;
        _cookModePickerView.hidden = NO;
        self.chooseLabel.text = @"口感";
    }else
    {
        _finishTimeImage.highlighted = YES;
        _datePicker.hidden = NO;
        self.chooseLabel.text = @"预约完成时间";
        
        
    }
    
    
}



#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == _pNumberPickerView) {
        return 3;
    }else
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 2) {
        return 1;
    }else
    {
    NSArray *array = [self contentOfPickerView:pickerView];
    return array.count;
    }
}


- (NSArray *)contentOfPickerView:(UIPickerView *)pickerView
{
    NSArray *array;
    if ([pickerView isEqual:_pNumberPickerView]) {
        array = [_dic objectForKey:@"pNumber"];
    }else if ([pickerView isEqual:_firePickerView])
    {
        array = [_dic objectForKey:@"fire"];
    }else if ([pickerView isEqual:_cookModePickerView])
    {
        array = [_dic objectForKey:@"cookMode"];
    }
    return array;

}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *array = [self contentOfPickerView:pickerView];
    if (row < [array count]) {
        if (pickerView == _pNumberPickerView) {
            if (component == 1) {
                return [array objectAtIndex:row];
            }
            else if (component == 2)
                return @"人份";
            else
                return nil;
        }else
        {
            return [array objectAtIndex:row];
        }

    }else
        return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *array = [self contentOfPickerView:pickerView];
    if (row < array.count) {
        _contentStr = [array objectAtIndex:row];
        if ([pickerView isEqual:_pNumberPickerView]) {
            if (component == 1) {
                //            _contentStr = [array objectAtIndex:row];
                
                self.pNumberLabel.text = [NSString stringWithFormat:@"%ld人份", row + 1];
                
            }
        }else if ([pickerView isEqual:_firePickerView])
        {
            self.fireLabel.text = _contentStr;
        }else if ([pickerView isEqual:_cookModePickerView])
        {
            self.cookModeLabel.text = _contentStr;
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
    if (pickerView == _pNumberPickerView)
    {
        if (component == 1) {
            retval.textAlignment = NSTextAlignmentCenter;
            retval.font = [UIFont systemFontOfSize:26];
        }else
        {
            retval.textAlignment = NSTextAlignmentLeft;
            retval.font = [UIFont systemFontOfSize:15];
        }
    }
    else
    {
         retval.textAlignment = NSTextAlignmentCenter;
        retval.font = [UIFont systemFontOfSize:21];
        
    }
    retval.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return retval;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 34;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width = CGRectGetHeight(pickerView.frame);
    CGFloat center = 50;
    if (pickerView == _pNumberPickerView) {
        if (component == 1) {
            return center;
        }else
            return (width - center)/2;
    }else
        return width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)startCooking:(UIButton *)sender {
    if ([self isFinishTimeGreaterThanSetTime]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        self.startBtn.userInteractionEnabled = NO;
        NSString *urlStr = [NSString stringWithFormat: @"http://%@/Reciveservlet", SERVER_URL];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"phonenumber" : self.device.phonenumber,
                                     @"device" : self.device.device,
                                     @"pnumberweight" : self.pNumberLabel.text,
                                     @"degree" : self.fireLabel.text,
                                     @"state" : self.cookModeLabel.text,
                                     @"devicename" : self.device.devicename,
                                     @"finishtime" : self.finishTime,
                                     @"UUID" : self.device.UUID
                                     };
        
        [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",recieve);
            if ([recieve isEqualToString:@"start"]) {
                [self changeDevice];
                [_delegate changeDevice:_device withIndex:_currentIndex];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else
            {
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        [self changeDevice];
        [_delegate changeDevice:_device withIndex:_currentIndex];
        [self.navigationController popViewControllerAnimated:YES];

    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"烹饪时间不足" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}


// 判断完成时间是否大于设置时间
- (BOOL)isFinishTimeGreaterThanSetTime
{

//    NSDate *finish = [_dateFormatter dateFromString:_finishTime];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:30*60];
    
    if (_datePicker.date < date) {
        return NO;
    }else
        return YES;
   
    
}


#pragma mark deviceDelegate
- (void)changeDevice
{
    _device.state = self.cookModeLabel.text;
    _device.degree = self.fireLabel.text;
    _device.pnumberweight = _pNumberLabel.text;
    _device.finishtime = [NSMutableString stringWithString: self.finishTime];
    _device.appointTime = self.finishTimeLabel.text;
    _device.module = @"烹饪中";
    _device.remianTime = 30 * 60;
    _device.settingTime = 30 * 60;
    
    
}





@end
