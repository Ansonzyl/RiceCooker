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
{
    UILabel *_percentLabel;
}

+(NSString *)cellID
{
    return @"riceCell";
}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self setImageAndLabel];
    [self setOtherImageView];
    
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
    _deviceLabel = [self setLabelWithFrame:CGRectMake(110*kRate, 30*kRate, 70*kRate, 21*kRate)  withText:@"e饭宝" withSize:21*kRate];
    CGFloat fontSize = 12*kRate;
    _moduleLable = [self setLabelWithFrame:CGRectMake(110*kRate, 57*kRate, 70*kRate, 21*kRate) withText:nil withSize:15*kRate];
    _finishTime = [self setLabelWithFrame:CGRectMake(110*kRate, 86*kRate, 70*kRate, 21*kRate) withText:nil withSize:fontSize];

    [self addSubview:_iconImage];
    [self addSubview:_deviceLabel];
    [self addSubview:_moduleLable];
    [self addSubview:_finishTime];
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(110*kRate, 115*kRate, 267*kRate, 20*kRate)];
    _progressView.trackTintColor = UIColorFromRGB(0x2b75aa);
    _progressView.tintColor = UIColorFromRGB(0xd4ffff);
    self.progressView.layer.cornerRadius = 6;
     self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f * kRate);
    [self addSubview:_progressView];
    _retryButton = [[UIButton alloc] initWithFrame:CGRectMake(292*kRate, 20*kRate, 92*kRate, 42*kRate)];
    [_retryButton setTitle:@"连接" forState:UIControlStateNormal];
    
    
    [_retryButton setTitleColor:UIColorFromRGB(0xD4FFFF) forState:UIControlStateNormal];
    [_retryButton.layer setCornerRadius:3.0f];
    [_retryButton.layer setBorderWidth:1.0];
    [_retryButton.layer setBorderColor:UIColorFromRGB(0xD4FFFF).CGColor];
    _retryButton.titleLabel.font = [UIFont systemFontOfSize:16*kRate];
    [self.contentView addSubview:_retryButton];
    _retryButton.hidden = YES;
    
    _percentLabel = [self setLabelWithFrame:CGRectMake(307*kRate, 86*kRate, 70*kRate, 21*kRate) withText:nil withSize:fontSize];
    _percentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_percentLabel];


}

- (void) setOtherImageView
{
    double size = 25 * kRate;
    _stateImage = [self setImageViewWithFrame:CGRectMake(kWidth - 57*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-口感" ofType:@"png"]];
    
    _degreeImage = [self setImageViewWithFrame:CGRectMake(kWidth - 102*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-烹饪方式" ofType:@"png"]];
    _pNumberImage = [self setImageViewWithFrame:CGRectMake(266*kRate, 29*kRate, size, size) withImage:[[NSBundle mainBundle]pathForResource:@"icon-e饭宝-米量" ofType:@"png"]];
    
    CGRect frame = CGRectMake(0, 0, 40*kRate, 18*kRate);
    CGFloat fontSize = 12*kRate;
    
    _pNumberLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _pNumberLabel.textAlignment = NSTextAlignmentCenter;
    _pNumberLabel.center = [self makeCenterWithPoint:_pNumberImage.center];
    
    
    [self addSubview:_pNumberLabel];
    
    _stateLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.center = [self makeCenterWithPoint:_stateImage.center];
    [self addSubview:_stateLabel];
    
    
    _degreeLabel = [self setLabelWithFrame:frame withText:nil withSize:fontSize];
    _degreeLabel.textAlignment = NSTextAlignmentCenter;
    _degreeLabel.center = [self makeCenterWithPoint:_degreeImage.center];
    [self addSubview:_degreeLabel];
    
    
    [self addSubview:_stateImage];
    [self addSubview:_pNumberImage];
    [self addSubview:_degreeImage];
    
    
    

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
    _riceCell = riceCell;
    
    _stateLabel.text = riceCell.degree;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", riceCell.pnumberweight];
    
    self.moduleLable.text = riceCell.module;
    self.degreeLabel.text = riceCell.state;
    self.finishTime.text = riceCell.appointTime;
    [self.progressView setProgress:(riceCell.settingTime -riceCell.remianTime)/riceCell.settingTime];
}


- (void)setDevice:(DM_EVegetable *)device
{
    _device = device;
    if ([device.connectstate isEqualToString:@"1"] || ![device.module isEqualToString:@"未连接"]) {
        self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", device.pnumberweight];
        self.stateLabel.text = device.state;
        self.degreeLabel.text = device.degree;
        if ([device.module isEqualToString:@"预约中"]) {
            self.finishTime.text = [NSString stringWithFormat:@"预约至%@", device.appointTime];
        }else
        self.finishTime.text =  device.appointTime;
        double percent = (device.settingTime -device.remianTime)/device.settingTime;
        _percentLabel.text = [NSString stringWithFormat:@"%d％", (int)(percent*100)];
        [self.progressView setProgress:percent];


    }else
    {
        _pNumberLabel.hidden = YES;
        _stateLabel.hidden = YES;
        _degreeLabel.hidden = YES;
        _percentLabel.hidden = YES;

        _pNumberImage.hidden = YES;
        _stateImage.hidden = YES;
        _degreeImage.hidden = YES;
//        self.finishTime.text = @"连接失败";
        _iconImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-e饭宝未连接（188）" ofType:@"png"]];
        [self.progressView setProgress:0];
        _retryButton.hidden = NO;
        
    }

    self.moduleLable.text = device.module;
}




@end
