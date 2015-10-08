//
//  EriceCell.m
//  RiceCooker
//
//  Created by yi on 15/7/29.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EriceCell.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation EriceCell

+(NSString *)cellID
{
    return @"riceCell";
}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self setImageAndLabel];
    
}


- (UILabel *)setLabelWithFrame:(CGRect)frame  withText:(NSString *)text withSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment =  NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:size];
    
    label.textColor = UIColorFromRGB(0xD4FFFF);
    label.text = text;
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
    
    _iconImage = [self setImageViewWithFrame:CGRectMake(0, 0, 63*kRate, 63*kRate) withImage:[[NSBundle mainBundle] pathForResource:@"icon-e饭宝（188）" ofType:@"png"]];
    _iconImage.center = CGPointMake(kRate * 57, CGRectGetHeight(self.frame)/2 *kRate);
    
    double size = 25 * kRate;
    UIImageView *degreeImage = [self setImageViewWithFrame:CGRectMake(kWidth - 57*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-口感" ofType:@"png"]];
    UIImageView *stateImage = [self setImageViewWithFrame:CGRectMake(kWidth - 102*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-烹饪方式" ofType:@"png"]];
    UIImageView *pNumberImage = [self setImageViewWithFrame:CGRectMake(266*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-米量" ofType:@"png"]];
    
    CGRect frame = CGRectMake(0, 0, 40*kRate, 18*kRate);
    CGFloat fontSize = 12*kRate;
    
    _pNumberLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _pNumberLabel.textAlignment = NSTextAlignmentCenter;
    _pNumberLabel.center = [self makeCenterWithPoint:pNumberImage.center];
    
    
    [self addSubview:_pNumberLabel];
    
    _stateLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.center = [self makeCenterWithPoint:stateImage.center];
    [self addSubview:_stateLabel];
    

    _degreeLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _degreeLabel.textAlignment = NSTextAlignmentCenter;
    _degreeLabel.center = [self makeCenterWithPoint:degreeImage.center];
    [self addSubview:_degreeLabel];
    
    
    _deviceLabel = [self setLabelWithFrame:CGRectMake(110*kRate, 30*kRate, 70*kRate, 21*kRate)  withText:@"e饭宝" withSize:21*kRate];
    _moduleLable = [self setLabelWithFrame:CGRectMake(110*kRate, 57*kRate, 70*kRate, 21*kRate) withText:nil withSize:15*kRate];
    _finishTime = [self setLabelWithFrame:CGRectMake(110*kRate, 86*kRate, 70*kRate, 21*kRate) withText:nil withSize:fontSize];
    
    
    [self addSubview:stateImage];
    [self addSubview:pNumberImage];
    [self addSubview:degreeImage];

    [self addSubview:_iconImage];
    [self addSubview:_deviceLabel];
    [self addSubview:_moduleLable];
    [self addSubview:_finishTime];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(110*kRate, 115*kRate, 267*kRate, 20*kRate)];
    _progressView.backgroundColor = UIColorFromRGB(0x2b75aa);
    _progressView.tintColor = UIColorFromRGB(0xd4ffff);
    self.progressView.layer.cornerRadius = 6;
    
    [self addSubview:_progressView];

}


- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 30*kRate;
    return point;
}

+ (id)ericeCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"homeCell" owner:nil options:nil][0];
}

- (void)setRiceCell:(DM_ERiceCell *)riceCell
{
//    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//    self.progressView.layer.cornerRadius = 6;
    _riceCell = riceCell;
    _stateLabel.text = riceCell.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", riceCell.pnumberweight];
    
    self.moduleLable.text = riceCell.module;
    self.degreeLabel.text = riceCell.degree;
    self.finishTime.text = riceCell.appointTime;
    [self.progressView setProgress:(riceCell.settingTime -riceCell.remianTime)/riceCell.settingTime];
}


- (void)setDevice:(DM_EVegetable *)device
{
//    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
//    self.progressView.layer.cornerRadius = 6;
    _device = device;
    _stateLabel.text = device.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", device.pnumberweight];
    
    self.moduleLable.text = device.module;
    self.degreeLabel.text = device.degree;
    self.finishTime.text =  device.appointTime;
    [self.progressView setProgress:(device.settingTime -device.remianTime)/device.settingTime];
}


@end
