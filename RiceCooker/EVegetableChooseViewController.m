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
@property (weak, nonatomic) IBOutlet UIPickerView *weightPicerView;
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



@property (nonatomic, strong) NSArray *array;

@end

@implementation EVegetableChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _device.devicename;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EVegetablePickerViewList" ofType:@"plist"];
    
    _cookTypePickerView.hidden = NO;
    
    _array = [NSArray arrayWithObjects:@"1",@"2", @"3", nil];
    
    [self addGestureForImageViews];
    [self initializeTheImageViewAndPickerView];
    
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
    
    _cookTypePickerView.hidden = YES;
    _materialPickerView.hidden = YES;
    _weightPicerView.hidden = YES;
    _datePicker.hidden = YES;
    _timePicker.hidden = YES;
    
    if (ges == _ges1) {
        _cookTypeImageView.highlighted = YES;
        _cookTypePickerView.hidden  = NO;
        _cookTypeLabel.text = @"烹饪方式";
    }else if (ges == _ges2)
    {
        _materialImageView.highlighted = YES;
        _materialPickerView.hidden = NO;
        _materialLabel.text = @"食材选择";
    }else if (ges == _ges3)
    {
        _weightImageView.highlighted = YES;
        _weightPicerView.hidden = NO;
        _weightLabel.text = @"食材重量";
    }else if (ges == _ges4)
    {
        _finishTimeImageView.highlighted = YES;
        _datePicker.hidden = NO;
        _timePicker.hidden = NO;
        _finishTimeLabel.text = @"预约完成时间";
        _setFinishTimeLabel.hidden = NO;
        _setTimeLabel.hidden = NO;
    }
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _array[row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
