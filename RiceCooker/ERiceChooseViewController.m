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


@property (strong, nonatomic) IBOutlet UIImageView *fireImage;
@property (strong, nonatomic) IBOutlet UIImageView *cookModeImage;
@property (strong, nonatomic) IBOutlet UIImageView *finishTimeImage;
@property (strong, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *fireLabel;

@property (strong, nonatomic) IBOutlet UILabel *cookModeLabel;
@property (strong, nonatomic) IBOutlet UILabel *finishTimeLabel;
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


@property (nonatomic, copy) NSString *pNumberStr;
@property (nonatomic, strong) NSString *finishTime;


@property (nonatomic, strong) NSArray *pNumberArray;
@property (nonatomic, strong) NSArray *fireArray;
@property (nonatomic, strong) NSArray *cookModeArray;
@end

@implementation ERiceChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    
    [self setImageAndLabelText];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ERicePickerViewList" ofType:@"plist"];
        _dic = [NSDictionary dictionaryWithContentsOfFile:path];
        _pNumberArray = [_dic objectForKey:@"pNumber"];
        _fireArray = [_dic objectForKey:@"fire"];
        _cookModeArray = [_dic objectForKey:@"cookMode"];
    

        _dateFormatter = [[NSDateFormatter alloc] init];
        

   
        [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:47*60]];
    


    
        [_datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:24*60*60]];
        [_datePicker addTarget:self
                        action:@selector(dateChange)
              forControlEvents:UIControlEventValueChanged];
        [_dateFormatter setDateFormat:@"MMddHH:mm"];

    
       
        _pNumberStr = _device.pnumberweight;

    
        [self addGestureForImageViews];
    
    
    
        [self initializeTheImageViewAndPickerView];
    
    
    _finishTime = _device.finishtime;
//        [_firePickerView selectRow:[self contentOfPickerView:_firePickerView].count/2 inComponent:0 animated:YES];
//    
//    //    [_cookModePickerView selectRow:[self contentOfPickerView:_cookModePickerView].count/2  inComponent:0 animated:YES];
//    
//    [_cookModePickerView selectRow:[[self contentOfPickerView:_cookModePickerView] indexOfObject:_device.degree] inComponent:0 animated:YES];
//    [_pNumberPickerView selectRow:[_pNumberArray indexOfObject:[_device.pnumberweight substringToIndex:1]] inComponent:1 animated:YES];
//
    
    
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
    _fireImage = [self setImageViewWithFrame:CGRectMake(136*kRate, height, size, size) withImage:@"icon-e饭宝-烹饪方式（152）.png" withHighlightedImage:@"icon-e饭宝-烹饪方式选中（152）.png"];
    _cookModeImage = [self setImageViewWithFrame:CGRectMake(229*kRate, height, size, size) withImage:@"icon-e饭宝-口感（152）.png" withHighlightedImage:@"icon-e饭宝-口感选中（152）.png"];
    _finishTimeImage = [self setImageViewWithFrame:CGRectMake(322*kRate, height, size, size) withImage:@"icon-e饭宝-预约（152）.png" withHighlightedImage:@"icon-e饭宝-预约选中（152）.png"];
    
    CGRect frame = CGRectMake(0, 0, 60*kRate, 21*kRate);
    size = 12 * kRate;
    _pNumberLabel = [self setLabelWithFrame:frame withText:[NSString stringWithFormat:@"%@人份", _device.pnumberweight ]withSize:size withColor:[UIColor blackColor]];
    _pNumberLabel.center = [self makeCenterWithPoint:_pNumber.center];
    
    _fireLabel = [self setLabelWithFrame:frame withText:@"煮饭" withSize:size withColor:[UIColor blackColor]];
    _fireLabel.center = [self makeCenterWithPoint:_fireImage.center];
    NSLog(@"%@", _fireLabel.text);
    
    _cookModeLabel = [self setLabelWithFrame:frame withText:_device.state withSize:size withColor:[UIColor blackColor]];
    _cookModeLabel.center = [self makeCenterWithPoint:_cookModeImage.center];
    _finishTimeLabel = [self setLabelWithFrame:frame withText:_device.appointTime withSize:size withColor:[UIColor blackColor]];
    _finishTimeLabel.center = [self makeCenterWithPoint:_finishTimeImage.center];
    
    UIColor *textColor = [UIColor whiteColor];
    UILabel *stateLabel = [self setLabelWithFrame:CGRectMake(150*kRate, 121*kRate, 115*kRate, 21*kRate) withText:_device.module withSize:26.0*kRate withColor:textColor];
    
    
    UILabel *riceText = [self setLabelWithFrame:CGRectMake(124*kRate, 187*kRate, 166*kRate, 21*kRate) withText:[NSString stringWithFormat:@"米仓还剩%@％", self.device.ericestorage] withSize:17*kRate withColor:UIColorFromRGB(0xe1ebf2)];
    size = 18.0 * kRate;
    height = 282 * kRate;
    UILabel *riceWeight = [self setLabelWithFrame:CGRectMake(0, height, 33*kRate, 21*kRate) withText:@"30" withSize:size withColor:[UIColor whiteColor]];
    riceWeight.textAlignment = NSTextAlignmentRight;
    UILabel *applyNum = [self setLabelWithFrame:CGRectMake(166*kRate, height, 45 * kRate, 21 * kRate) withText:@"100" withSize:size withColor:textColor];
    applyNum.textAlignment = NSTextAlignmentRight;
    UILabel *dayNum = [self setLabelWithFrame:CGRectMake(335*kRate, height, 38, 21*kRate) withText:@"30" withSize:size withColor:textColor];
    dayNum.textAlignment = NSTextAlignmentRight;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.view addSubview:stateLabel];
        [self.view addSubview:riceText];
        [self.view addSubview:riceWeight];
        [self.view addSubview:applyNum];
        [self.view addSubview:dayNum];
        
        [self.view addSubview:_finishTimeLabel];
        [self.view addSubview:_cookModeLabel];
        [self.view addSubview:_fireLabel];
        [self.view addSubview:_pNumberLabel];
        [self.view addSubview:_pNumber];
        [self.view addSubview:_fireImage];
        [self.view addSubview:_cookModeImage];
        [self.view addSubview:_finishTimeImage];
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






- (void) initializeTheImageViewAndPickerView
{
    [self dateChange];
    [_pNumberPickerView selectRow:[_pNumberArray indexOfObject:[_device.pnumberweight substringToIndex:1]] inComponent:0 animated:YES];
    _cookModeLabel.text = _cookModeArray[0];
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
        return 2;
    }else
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    

    if ([pickerView isEqual:_pNumberPickerView]) {
        if (component == 1) {
            return 1;
        }else
        return _pNumberArray.count;
    }else if ([pickerView isEqual:_firePickerView])
    {
        return _fireArray.count;
    }else if ([pickerView isEqual:_cookModePickerView])
    {
        return _cookModeArray.count;
    }else
        return 0;

}





- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    if ([pickerView isEqual:_pNumberPickerView]) {
        if (component == 0) {
            return [_pNumberArray objectAtIndex:row];
        }
        else if (component == 1)
            return @"人份";
        else
            return nil;
    }else if ([pickerView isEqual:_firePickerView])
    {
        return  [_fireArray objectAtIndex:row];
    }else if ([pickerView isEqual:_cookModePickerView])
    {
        return [_cookModeArray objectAtIndex:row];
    }else
        return nil;
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ([pickerView isEqual:_pNumberPickerView]) {
        if (component == 0) {
            self.pNumberStr = [NSString stringWithFormat:@"%d", (int)(row + 1)];
            self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", self.pNumberStr];
            
        }

    }else if ([pickerView isEqual:_firePickerView])
    {
        self.fireLabel.text = _fireArray[row];
    }else if ([pickerView isEqual:_cookModePickerView])
    {
        self.cookModeLabel.text = [_cookModeArray objectAtIndex:row];
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
        if (component == 0) {
            retval.textAlignment = NSTextAlignmentRight;
            retval.font = [UIFont systemFontOfSize:26*kRate];
        }else
        {
            retval.textAlignment = NSTextAlignmentLeft;
            retval.font = [UIFont systemFontOfSize:15*kRate];
        }
    }
    else
    {
         retval.textAlignment = NSTextAlignmentCenter;
        retval.font = [UIFont systemFontOfSize:21*kRate];
        
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
//    CGFloat center = 50;
    if (pickerView == _pNumberPickerView) {
        if (component == 0) {
            return width/2 + 10;
        }else
            return width/2 - 10;
        
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
                                     @"pnumberweight" : self.pNumberStr,
                                     @"degree" : self.fireLabel.text,
                                     @"state" : self.cookModeLabel.text,
                                     @"devicename" : self.device.devicename,
                                     @"finishtime" : self.finishTime,
                                     @"UUID" : self.device.UUID
                                     };
        
        [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *recieve = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",recieve);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([recieve isEqualToString:@"ericestart"]) {
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
                  
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"设置失败\n请重新设置";
                    hud.labelFont = [UIFont systemFontOfSize:11.0f];
                    [hud hide:YES afterDelay:1.5f];

                }


            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];

    }else
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"烹饪时间不足\n请重新设置";
        hud.labelFont = [UIFont systemFontOfSize:11.0f];
        [hud hide:YES afterDelay:1.5f];
       
    }
    
    
}


// 判断完成时间是否大于设置时间
- (BOOL)isFinishTimeGreaterThanSetTime
{
    
    if ([self timeOfInsulation] < 45*60) {
        return NO;
    }else
        return YES;
   
    
}


#pragma mark deviceDelegate
- (void)changeDevice
{
    _device.module = @"预约中";
    _device.state = self.cookModeLabel.text;
    _device.degree = self.fireLabel.text;
    _device.pnumberweight = _pNumberStr;
    _device.finishtime = [NSMutableString stringWithString: self.finishTime];
    _device.appointTime = self.finishTimeLabel.text;
    if ( 45 * 60 <[self timeOfInsulation] && [self timeOfInsulation] < 46 * 60) {
        _device.module = @"烹饪中";
    }
    
    _device.remianTime = [self timeOfInsulation];
    _device.settingTime = 45 * 60;
    
    
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


@end
