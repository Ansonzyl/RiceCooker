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
{
    UIButton *_retryButton;
    UILabel *_percentLabel;
}

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
    
    CGRect frame = CGRectMake(0, 0, 60*kRate, 18*kRate);
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
    _device = [self setLabelWithFrame:CGRectMake(110*kRate, 30*kRate, 100*kRate, 21*kRate)   withSize:21*kRate withTextAlignment:NSTextAlignmentLeft];
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
    _percentLabel = [self setLabelWithFrame:CGRectMake(307*kRate, 86*kRate, 70*kRate, 21*kRate) withSize:fontSize withTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:_percentLabel];
    _retryButton = [[UIButton alloc] initWithFrame:CGRectMake(292*kRate, 20*kRate, 92*kRate, 42*kRate)];
    [_retryButton setTitle:@"连接" forState:UIControlStateNormal];
    
    
    [_retryButton setTitleColor:UIColorFromRGB(0xD4FFFF) forState:UIControlStateNormal];
    [_retryButton.layer setCornerRadius:3.0f];
    [_retryButton.layer setBorderWidth:1.0];
    [_retryButton.layer setBorderColor:UIColorFromRGB(0xD4FFFF).CGColor];
    _retryButton.titleLabel.font = [UIFont systemFontOfSize:16*kRate];
    [self.contentView addSubview:_retryButton];
    _retryButton.hidden = YES;

    
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.y += 30*kRate;
    return point;
}


- (void)setVegetable:(DM_EVegetable *)vegetable
{
    if ([vegetable.devicename isEqualToString:@"e菜宝中"]) {
        [self setBackgroundColorWithUIcolor:UIColorFromRGB(0x4b5a8b) withIcon:@"icon-e菜宝中（188）.png" withSetTimeImage:@"icon-e菜宝中-烹饪时长.png" withWeightImage:@"icon-e菜宝中-重量.png" withMaterialImge:@"icon-e菜宝中-食材.png" withDegreeImage:@"icon-e菜宝中-烹饪方式.png"];
        [self setLableColorWithColor:UIColorFromRGB(0xd1d0ff)];
        [self setProgressViewWithTrackTinColor:UIColorFromRGB(0x363152) withProgressTintColor:UIColorFromRGB(0xd1d0ff)];
    }else if ([vegetable.devicename isEqualToString:@"e菜宝下"])
    {
        [self setBackgroundColorWithUIcolor:UIColorFromRGB(0x544d7f) withIcon:@"icon-e菜宝下（188）.png" withSetTimeImage:@"icon-e菜宝下-烹饪时长.png" withWeightImage:@"icon-e菜宝下-重量.png" withMaterialImge:@"icon-e菜宝下-食材.png" withDegreeImage:@"icon-e菜宝下-烹饪方式.png"];
        [self setLableColorWithColor:UIColorFromRGB(0xe9d0ff)];
        [self setProgressViewWithTrackTinColor:UIColorFromRGB(0x363152) withProgressTintColor:UIColorFromRGB(0xe9d0ff)];
        
    }
    _vegetable = vegetable;
    self.device.text = vegetable.devicename;
    if ([vegetable.connectstate isEqualToString:@"1"] || ![vegetable.module isEqualToString:@"未连接"]) {
        _stateLabel.text = vegetable.state;
        self.pNumberLabel.text = [NSString stringWithFormat:@"%@", vegetable.pnumberweight];
        self.degreeLabel.text = vegetable.degree;
        self.settimeLabel.text = vegetable.settime;
        self.finishTime.text = vegetable.appointTime;
        double percent = (vegetable.settingTime - vegetable.remianTime)/vegetable.settingTime;
        _percentLabel.text = [NSString stringWithFormat:@"%d％", (int)(percent*100)];
        [self.progressView setProgress:percent];
    }else
    {
        _pNumberLabel.hidden = YES;
        _stateLabel.hidden = YES;
        _degreeLabel.hidden = YES;
        _settimeLabel.hidden = YES;
        _weightImageView.hidden = YES;
        _degreeImageView.hidden = YES;
        _materialImageView.hidden = YES;
        _setTimeImageView.hidden = YES;
        _iconImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-e饭宝未连接（188）" ofType:@"png"]];
        [self.progressView setProgress:0];
        _retryButton.hidden = NO;
    }

    
    self.moduleLable.text = vegetable.module;
}




- (void)setProgressViewWithTrackTinColor:(UIColor *)trackTinColor withProgressTintColor:(UIColor *)tintColor
{
    _progressView.trackTintColor = trackTinColor;
    _progressView.progressTintColor = tintColor;
}

- (void)setLableColorWithColor:(UIColor *)color
{
    self.stateLabel.textColor = color;
    self.stateLabel.textColor = color;
    self.pNumberLabel.textColor = color;
    self.moduleLable.textColor = color;
    self.degreeLabel.textColor = color;
    self.settimeLabel.textColor = color;
    self.finishTime.textColor = color;
    self.device.textColor = color;
    _percentLabel.textColor = color;
    [_retryButton setTitleColor:color forState:UIControlStateNormal];
}


- (void)setBackgroundColorWithUIcolor:(UIColor *)backgroundColor withIcon:(NSString *)iconImage withSetTimeImage:(NSString *)setTimeImage withWeightImage:(NSString *)weightImage withMaterialImge:(NSString *)materialImage withDegreeImage:(NSString *)degreeImage
{

    self.backgroundColor = backgroundColor;
    self.iconImage.image = [UIImage imageNamed:iconImage];
    self.setTimeImageView.image = [UIImage imageNamed:setTimeImage];
    self.weightImageView.image = [UIImage imageNamed:weightImage];
    self.materialImageView.image = [UIImage imageNamed:materialImage];
    self.degreeImageView.image = [UIImage imageNamed:degreeImage];

}






@end
