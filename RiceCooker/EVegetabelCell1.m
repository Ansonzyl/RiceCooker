//
//  EVegetabelCell1.m
//  RiceCooker
//
//  Created by yi on 15/7/31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EVegetabelCell1.h"


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
//    [super awakeFromNib];
//    _progressView = [[UIProgressView alloc] init];
//    _progressView.frame = CGRectMake(110, 115, 280, 7);
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    self.progressView.layer.cornerRadius = 5;
}





- (void)setVegetable:(DM_EVegetable *)vegetable
{
    _vegetable = vegetable;
    _stateLabel.text = vegetable.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@", vegetable.pnumberweight];
    self.moduleLable.text = vegetable.module;
    self.degreeLabel.text = vegetable.degree;
    self.settimeLabel.text = vegetable.settime;
    
    self.finishTime.text = [NSString stringWithFormat:@"%@完成", vegetable.finishtime];
    [self.progressView setProgress:vegetable.remianTime/vegetable.settingTime];
}


- (void)setVegetable2:(DM_EVegetable *)vegetable2
{
    _vegetable2 = vegetable2;
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
    self.finishTime.text = [NSString stringWithFormat:@"%@完成", vegetable2.finishtime];
    self.stateLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.pNumberLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.moduleLable.textColor = UIColorFromRGB(0xd1d0ff);
    self.degreeLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.settimeLabel.textColor = UIColorFromRGB(0xd1d0ff);
    self.finishTime.textColor = UIColorFromRGB(0xd1d0ff);
    self.device.textColor = UIColorFromRGB(0xd1d0ff);
    self.progressView.trackTintColor = UIColorFromRGB(0x363152);
    self.progressView.progressTintColor = UIColorFromRGB(0xd1d0ff);
    [self.progressView setProgress:vegetable2.remianTime/vegetable2.settingTime];
}

- (void)setVegetable3:(DM_EVegetable *)vegetable3
{
    _vegetable3 = vegetable3;
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
    self.finishTime.text = [NSString stringWithFormat:@"%@完成", vegetable3.finishtime];
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
    [self.progressView setProgress:vegetable3.remianTime/vegetable3.settingTime];

}





@end
