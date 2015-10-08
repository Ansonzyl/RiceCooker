//
//  EVegetabelCell1.m
//  RiceCooker
//
//  Created by yi on 15/7/31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EVegetabelCell1.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation EVegetabelCell1

+ (NSString *)cellID
{
    return @"vegetableCell_first";
}

+ (id)eVegetableCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"homeCell" owner:nil options:nil][1];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    [self setImageAndLabel];
    
    
    
    
}

- (UILabel *)setLabelWithFrame:(CGRect)frame  withSize:(CGFloat)size withTextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  textAlignment;
    label.font = [UIFont systemFontOfSize:size];
    
    label.textColor = UIColorFromRGB(0xD4FFFF);
    
    return label;
}

- (UIImageView *)setImageViewWithFrame:(CGRect)frame withImage:(NSString *)imagePath
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    return imageView;
}

- (void)setImageAndLabel
{
    
    
    _iconImage = [self setImageViewWithFrame:CGRectMake(0, 0, 63*kRate, 63*kRate) withImage:[[NSBundle mainBundle] pathForResource:@"icon-e菜宝上（188）" ofType:@"png"]];
    _iconImage.center = CGPointMake(kRate * 57, CGRectGetHeight(self.frame)/2 *kRate);
    [self addSubview:_iconImage];
    
    
    double size = 25 * kRate;
    _setTimeImageView = [self setImageViewWithFrame:CGRectMake(kWidth - 57*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e菜宝上-烹饪时长" ofType:@"png"]];
    
    _weightImageView = [self setImageViewWithFrame:CGRectMake(kWidth - 102*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e菜宝上-重量" ofType:@"png"]];
    _materialImageView = [self setImageViewWithFrame:CGRectMake(266*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e菜宝上-食材" ofType:@"png"]];
    
    _degreeImageView = [self setImageViewWithFrame:CGRectMake(221*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle] pathForResource:@"icon-e菜宝上-烹饪方式" ofType:@"png"]];
    
    CGRect frame = CGRectMake(0, 0, 40*kRate, 18*kRate);
    CGFloat fontSize = 12*kRate;
    
    _pNumberLabel = [self setLabelWithFrame:frame withSize:fontSize withTextAlignment:NSTextAlignmentCenter];
    
    _pNumberLabel.center = [self makeCenterWithPoint:_weightImageView.center];
    
    
    [self addSubview:_pNumberLabel];
    
    _stateLabel = [self setLabelWithFrame:frame withSize:fontSize withTextAlignment:NSTextAlignmentCenter];
    
    _stateLabel.center = [self makeCenterWithPoint:_materialImageView.center];
    [self addSubview:_stateLabel];
    
    
    _degreeLabel = [self setLabelWithFrame:frame withSize:fontSize withTextAlignment:NSTextAlignmentCenter];
    
    _degreeLabel.center = [self makeCenterWithPoint:_degreeImageView.center];
    [self addSubview:_degreeLabel];
    
    _settimeLabel = [self setLabelWithFrame:frame withSize:fontSize withTextAlignment:NSTextAlignmentCenter];
    _settimeLabel.center = [self makeCenterWithPoint:_setTimeImageView.center];
    [self addSubview:_settimeLabel];
    _device = [self setLabelWithFrame:CGRectMake(110*kRate, 30*kRate, 70*kRate, 21*kRate)   withSize:21*kRate withTextAlignment:NSTextAlignmentLeft];
    _moduleLable = [self setLabelWithFrame:CGRectMake(110*kRate, 57*kRate, 70*kRate, 21*kRate)  withSize:15*kRate withTextAlignment:NSTextAlignmentLeft];
    _finishTime = [self setLabelWithFrame:CGRectMake(110*kRate, 86*kRate, 70*kRate, 21*kRate) withSize:fontSize withTextAlignment:NSTextAlignmentLeft];
    
    
    [self addSubview:_degreeImageView];
    [self addSubview:_weightImageView];
    [self addSubview:_setTimeImageView];
    [self addSubview:_materialImageView];
   
    [self addSubview:_device];
    [self addSubview:_moduleLable];
    [self addSubview:_finishTime];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(110*kRate, 115*kRate, 267*kRate, 20*kRate)];
    _progressView.trackTintColor = UIColorFromRGB(0x2b4564);
    _progressView.tintColor = UIColorFromRGB(0xd4ffff);
    self.progressView.layer.cornerRadius = 6;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f * kRate);
    [self addSubview:_progressView];
    
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 30*kRate;
    return point;
}


- (void)setVegetable:(DM_EVegetable *)vegetable
{
    _vegetable = vegetable;
    self.device.text = vegetable.device;
    _stateLabel.text = vegetable.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@", vegetable.pnumberweight];
    self.moduleLable.text = vegetable.module;
    self.degreeLabel.text = vegetable.degree;
    self.settimeLabel.text = vegetable.settime;
    
    self.finishTime.text = vegetable.appointTime;
    [self.progressView setProgress:(vegetable.settingTime - vegetable.remianTime)/vegetable.settingTime];
}


- (void)setVegetable2:(DM_EVegetable *)vegetable2
{
    _vegetable2 = vegetable2;
    self.device.text = vegetable2.device;
    self.backgroundColor = UIColorFromRGB(0x4b5a8b);
    self.iconImage.image = [UIImage imageNamed:@"icon-e菜宝中（188）.png"];
    self.setTimeImageView.image = [UIImage imageNamed:@"icon-e菜宝中-烹饪时长.png"];
    self.weightImageView.image = [UIImage imageNamed:@"icon-e菜宝中-重量.png"];
    self.materialImageView.image = [UIImage imageNamed:@"icon-e菜宝中-食材.png"];
    self.degreeImageView.image = [UIImage imageNamed:@"icon-e菜宝中-烹饪方式.png"];
    _stateLabel.text = vegetable2.state;
    self.stateLabel.textColor = UIColorFromRGB(0xd1f0ff);
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@", vegetable2.pnumberweight];
    self.moduleLable.text = vegetable2.module;
    self.degreeLabel.text = vegetable2.degree;
    self.settimeLabel.text = vegetable2.settime;
    self.finishTime.text = vegetable2.appointTime;
    self.stateLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.pNumberLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.moduleLable.textColor = UIColorFromRGB(0xd1d0ff);
    self.degreeLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.settimeLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.finishTime.textColor = UIColorFromRGB(0xd1d0ff);
    self.device.textColor = UIColorFromRGB(0xd1d0ff);
    self.progressView.trackTintColor = UIColorFromRGB(0x363152);
    self.progressView.progressTintColor = UIColorFromRGB(0xd1d0ff);
    [self.progressView setProgress:(vegetable2.settingTime - vegetable2.remianTime)/vegetable2.settingTime];
}

- (void)setVegetable3:(DM_EVegetable *)vegetable3
{
    _vegetable3 = vegetable3;
    self.device.text = vegetable3.device;
    self.backgroundColor = UIColorFromRGB(0x544d7f);
    self.iconImage.image = [UIImage imageNamed:@"icon-e菜宝下（188）.png"];
    self.setTimeImageView.image = [UIImage imageNamed:@"icon-e菜宝下-烹饪时长.png"];
    self.weightImageView.image = [UIImage imageNamed:@"icon-e菜宝下-重量.png"];
    self.materialImageView.image = [UIImage imageNamed:@"icon-e菜宝下-食材.png"];
    self.degreeImageView.image = [UIImage imageNamed:@"icon-e菜宝下-烹饪方式.png"];
    _stateLabel.text = vegetable3.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@", vegetable3.pnumberweight];
    self.moduleLable.text = vegetable3.module;
    self.degreeLabel.text = vegetable3.degree;
    self.settimeLabel.text = vegetable3.settime;
    self.finishTime.text = vegetable3.appointTime;
    self.stateLabel.textColor = UIColorFromRGB(0xe9d0ff);
    self.stateLabel.textColor = UIColorFromRGB(0xe9d0ff);
    self.pNumberLabel.textColor = UIColorFromRGB(0xe9d0ff);
    self.moduleLable.textColor = UIColorFromRGB(0xe9d0ff);
    self.degreeLabel.textColor = UIColorFromRGB(0xe9d0ff);
    self.settimeLabel.textColor = UIColorFromRGB(0xde9d0ff);
    self.finishTime.textColor = UIColorFromRGB(0xe9d0ff);
    self.device.textColor = UIColorFromRGB(0xe9d0ff);
    self.progressView.trackTintColor = UIColorFromRGB(0x363152);
    self.progressView.progressTintColor = UIColorFromRGB(0xe9d0ff);
    [self.progressView setProgress:(vegetable3.settingTime - vegetable3.remianTime)/vegetable3.settingTime];

}


//- (void)setImageWithPath:(NSString *)imagePath
//{
//    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
//}

//- (NSString *)imagePathWithDeviceName:(NSString *)devicename with
//
//- (void)setCellWithDeviceName:(NSString *)deviceName BackGroundColor:(UIColor *)backGroundColor withTrackTinColor:(UIColor *)trackTinColor withProgressTinColor:(UIColor *)progressTinColor
//{
//    [[NSBundle mainBundle]pathForResource:@"icon-e菜宝上-烹饪时长" ofType:@"png"]
//    self.iconImage.image = [UIImage imageWithContentsOfFile:<#(NSString *)#>]
//    self.backgroundColor = UIColorFromRGB(0x544d7f);
//}



@end
