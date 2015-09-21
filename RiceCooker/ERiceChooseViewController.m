//
//  ERiceChooseViewController.m
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "ERiceChooseViewController.h"

@interface ERiceChooseViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *pNumber;


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

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;


@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;


@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) UITapGestureRecognizer *ges1;
@property (nonatomic, strong) UITapGestureRecognizer *ges2;
@property (nonatomic, strong) UITapGestureRecognizer *ges3;
@property (nonatomic, strong) UITapGestureRecognizer *ges4;
@property (nonatomic, strong) NSString *contentStr;


@end

@implementation ERiceChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ERicePickerViewList" ofType:@"plist"];
    _dic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"HH:mm"];
    NSDate *currentTime = [NSDate date];
    [_dataPicker setMinimumDate:currentTime];
    [_dataPicker addTarget:self action:@selector(dateChange) forControlEvents:UIControlEventValueChanged];
    
    
    
    self.pNumberLabel.text = _device.pnumberweight;
    self.fireLabel.text = _device.state;
    self.cookModeLabel.text = _device.degree;
    self.finishTimeLabel.text = _device.finishtime;
    
    

    _pNumberPickerView.showsSelectionIndicator = YES;
    [_pNumberPickerView selectRow:[_device.pnumberweight intValue]-1 inComponent:0 animated:YES];

    _firePickerView.showsSelectionIndicator = YES;
    [_firePickerView selectRow:[[self contentOfPickerView:_firePickerView] indexOfObject:_device.state] inComponent:0 animated:YES];
    _cookModePickerView.showsSelectionIndicator = YES;
    [_cookModePickerView selectRow:[[self contentOfPickerView:_cookModePickerView] indexOfObject:_device.degree] inComponent:0 animated:YES];
    
    [self addGestureForImageViews];
    
    [self initializeTheImageViewAndPickerView];
}

- (void)dateChange
{
    NSString *destDateString = [_dateFormatter stringFromDate:_dataPicker.date];
    self.finishTimeLabel.text = destDateString;
    NSLog(@"%@", destDateString);
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
    _dataPicker.hidden = YES;
    
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
        _dataPicker.hidden = NO;
        self.chooseLabel.text = @"预约完成时间";
        
    }
    
    
}



#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *array = [self contentOfPickerView:pickerView];
    return array.count;
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

     return [array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _contentStr = [[self contentOfPickerView:pickerView] objectAtIndex:row];
    if ([pickerView isEqual:_pNumberPickerView]) {
        self.pNumberLabel.text = _contentStr;
    }else if ([pickerView isEqual:_firePickerView])
    {
        self.fireLabel.text = _contentStr;
    }else if ([pickerView isEqual:_cookModePickerView])
    {
        self.cookModeLabel.text = _contentStr;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)startCooking:(UIButton *)sender {
    
    
    
    
    
}
@end
